#!/usr/bin/env python3
"""
Validate GitHub Copilot SBT against schema requirements.

This script checks:
- JSON validity
- Required fields presence
- Field types and formats
- Claim consistency
"""

import json
import sys
from datetime import datetime
from typing import Dict, List, Tuple

class SBTValidator:
    """Validates Soulbound Token structure and compliance."""
    
    REQUIRED_FIELDS = [
        'sbt.id',
        'sbt.version',
        'sbt.name',
        'sbt.description',
        'sbt.issuer',
        'sbt.subject',
        'sbt.canonicalData',
        'sbt.verification',
    ]
    
    def __init__(self, filepath: str):
        self.filepath = filepath
        self.data = None
        self.errors = []
        self.warnings = []
    
    def load(self) -> bool:
        """Load and parse JSON file."""
        try:
            with open(self.filepath, 'r') as f:
                self.data = json.load(f)
            return True
        except json.JSONDecodeError as e:
            self.errors.append(f"Invalid JSON: {e}")
            return False
        except FileNotFoundError:
            self.errors.append(f"File not found: {self.filepath}")
            return False
    
    def validate(self) -> bool:
        """Run all validation checks."""
        if not self.load():
            return False
        
        self._check_required_fields()
        self._check_field_types()
        self._check_issuer()
        self._check_subject()
        self._check_verification()
        self._check_claims()
        self._check_canonical_data()
        
        return len(self.errors) == 0
    
    def _check_required_fields(self):
        """Check that all required fields exist."""
        for field in self.REQUIRED_FIELDS:
            parts = field.split('.')
            obj = self.data
            for part in parts:
                if isinstance(obj, dict) and part in obj:
                    obj = obj[part]
                else:
                    self.errors.append(f"Missing required field: {field}")
                    break
    
    def _check_field_types(self):
        """Validate field types."""
        sbt = self.data.get('sbt', {})
        
        # Check string fields
        string_fields = ['id', 'version', 'name', 'description']
        for field in string_fields:
            if field in sbt and not isinstance(sbt[field], str):
                self.errors.append(f"Field 'sbt.{field}' must be string")
        
        # Check object fields
        object_fields = ['issuer', 'subject', 'canonicalData', 'verification', 'metadata']
        for field in object_fields:
            if field in sbt and not isinstance(sbt[field], dict):
                self.errors.append(f"Field 'sbt.{field}' must be object")
        
        # Check array fields
        if 'claims' in sbt and not isinstance(sbt['claims'], list):
            self.errors.append("Field 'sbt.claims' must be array")
    
    def _check_issuer(self):
        """Validate issuer information."""
        issuer = self.data.get('sbt', {}).get('issuer', {})
        required = ['name', 'organization', 'url']
        for field in required:
            if field not in issuer:
                self.warnings.append(f"Issuer missing recommended field: {field}")
    
    def _check_subject(self):
        """Validate subject information."""
        subject = self.data.get('sbt', {}).get('subject', {})
        required = ['name', 'type', 'status']
        for field in required:
            if field not in subject:
                self.errors.append(f"Subject missing required field: {field}")
        
        # Check valid status
        if 'status' in subject:
            valid_statuses = ['active', 'inactive', 'deprecated']
            if subject['status'] not in valid_statuses:
                self.errors.append(
                    f"Invalid status: {subject['status']}. "
                    f"Must be one of: {', '.join(valid_statuses)}"
                )
    
    def _check_verification(self):
        """Validate verification metadata."""
        verification = self.data.get('sbt', {}).get('verification', {})
        required = ['schema', 'issuanceDate']
        for field in required:
            if field not in verification:
                self.errors.append(f"Verification missing required field: {field}")
        
        # Check date format
        if 'issuanceDate' in verification:
            if not self._is_iso8601(verification['issuanceDate']):
                self.errors.append(
                    f"Invalid date format: {verification['issuanceDate']}. "
                    "Must be ISO 8601 (YYYY-MM-DD)"
                )
    
    def _check_claims(self):
        """Validate claims structure."""
        claims = self.data.get('sbt', {}).get('claims', [])
        
        if not isinstance(claims, list):
            self.errors.append("Claims must be an array")
            return
        
        for i, claim in enumerate(claims):
            if not isinstance(claim, dict):
                self.errors.append(f"Claim {i} is not an object")
                continue
            
            required_claim_fields = ['claimType', 'claimValue', 'verified', 'verifier']
            for field in required_claim_fields:
                if field not in claim:
                    self.errors.append(
                        f"Claim {i} missing required field: {field}"
                    )
    
    def _check_canonical_data(self):
        """Validate canonical data structure."""
        canonical = self.data.get('sbt', {}).get('canonicalData', {})
        
        required_sections = ['identity', 'capabilities']
        for section in required_sections:
            if section not in canonical:
                self.warnings.append(
                    f"Canonical data missing recommended section: {section}"
                )
    
    @staticmethod
    def _is_iso8601(date_string: str) -> bool:
        """Check if string is valid ISO 8601 date."""
        try:
            datetime.fromisoformat(date_string.replace('Z', '+00:00'))
            return True
        except (ValueError, TypeError):
            return False
    
    def report(self):
        """Print validation report."""
        print("=" * 60)
        print("GitHub Copilot SBT Validation Report")
        print("=" * 60)
        print(f"File: {self.filepath}\n")
        
        if self.errors:
            print(f"❌ ERRORS ({len(self.errors)}):")
            for error in self.errors:
                print(f"  • {error}")
            print()
        
        if self.warnings:
            print(f"⚠️  WARNINGS ({len(self.warnings)}):")
            for warning in self.warnings:
                print(f"  • {warning}")
            print()
        
        if not self.errors:
            print("✅ VALIDATION PASSED")
            print(f"   • JSON is valid")
            print(f"   • All required fields present")
            print(f"   • Field types correct")
            print(f"   • Claims properly structured")
        else:
            print("❌ VALIDATION FAILED")
            return False
        
        return True

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 validate_sbt.py <path-to-sbt.json>")
        sys.exit(1)
    
    filepath = sys.argv[1]
    validator = SBTValidator(filepath)
    
    if validator.validate():
        validator.report()
        sys.exit(0)
    else:
        validator.report()
        sys.exit(1)

if __name__ == '__main__':
    main()
