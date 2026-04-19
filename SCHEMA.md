# SBT Schema Definition

## Overview
This document defines the schema for the GitHub Copilot Canonical Soulbound Token (SBT).

## Standard Compliance
- **EIP-5192**: Soulbound Token (SBT) Standard
- **JSON Schema**: JSON Schema Draft 2020-12
- **Non-Transferable**: By definition per EIP-5192

## Top-Level Structure

```json
{
  "sbt": {
    "id": "string",                  // Unique identifier
    "version": "string",             // Semantic versioning
    "name": "string",                // Human-readable name
    "description": "string",         // Purpose and description
    "issuer": { /* object */ },      // Issuing authority
    "subject": { /* object */ },     // Token subject
    "canonicalData": { /* object */}, // Core identity data
    "verification": { /* object */}, // Verification metadata
    "metadata": { /* object */ },    // Additional metadata
    "claims": [ /* array */ ]        // Claims about the subject
  },
  "standards": { /* object */ }      // Standards compliance
}
```

## Field Definitions

### `sbt.id`
- Type: String
- Required: Yes
- Format: kebab-case
- Example: `github-copilot-canonical-2026`

### `sbt.issuer`
Object containing issuer information:
- `name`: String - Name of issuing organization
- `organization`: String - Parent organization
- `url`: String - Official website
- `contactEmail`: String - Contact information

### `sbt.subject`
Object describing what the SBT represents:
- `name`: String - Name of the subject
- `type`: String - Category (e.g., "AI Assistant")
- `status`: Enum - One of: active, inactive, deprecated
- `launchDate`: ISO 8601 - When the subject launched
- `currentVersion`: String - Current version/release

### `sbt.canonicalData`
Core canonical information with sub-objects:

#### `identity`
- `officialName`: String
- `modelName`: String
- `purpose`: String
- `scope`: String

#### `capabilities`
- `primary`: Array of strings - Main capabilities
- `supportedLanguages`: Array of strings - Programming languages
- `features`: Array of strings - Feature set

#### `governance`
- `operator`: String - Who operates the service
- `jurisdiction`: String - Legal jurisdiction
- `complianceFramework`: Array of strings - Compliance standards

#### `usage`
- `accessMethod`: String - How users access the service
- `authentication`: String - Authentication method
- `availability`: String - Service availability
- `serviceStatus`: String (URI) - Status page

#### `limitations`
- `transferability`: String - Transfer restrictions
- `description`: String - Explanation of limitations
- `nonFungible`: Boolean - Is it unique/non-fungible
- `revocable`: Boolean - Can it be revoked

### `sbt.verification`
- `schema`: String - Standard compliance (e.g., EIP-5192)
- `issuanceDate`: ISO 8601 - When SBT was created
- `expirationDate`: ISO 8601 or null - Expiration (null = no expiration)
- `publicKey`: String - Public key identifier
- `verificationMethod`: String (URI) - How to verify

### `sbt.claims`
Array of claim objects:
- `claimType`: String - Type of claim
- `claimValue`: String - The claim assertion
- `verified`: Boolean - Whether verified
- `verifier`: String - Who verified the claim

## Example Claim Types
- `identity` - Official identity claims
- `model` - Model/version information
- `non-transferable` - Soulbound properties
- `service-provider` - Operating entity
- `capabilities` - Capability claims
- `compliance` - Compliance certifications

## Validation Rules

1. All required fields must be present
2. Dates must be ISO 8601 format
3. URIs must be valid and HTTPS where applicable
4. Version must follow semantic versioning
5. All claims must have corresponding evidence

## Storage and Distribution

SBTs can be stored at:
- GitHub Gists (with public access)
- GitHub Pages (in repository)
- GitHub Releases
- IPFS (immutable storage)
- Blockchain (for true immutability)

Recommended: GitHub Gist for easy distribution and GitHub Pages for permanent hosting.
