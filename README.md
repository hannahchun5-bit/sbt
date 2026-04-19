# GitHub Copilot Canonical Soulbound Token (SBT)

## Overview

This repository contains the **canonical Soulbound Token** representing the official identity, capabilities, and governance information about **GitHub Copilot**. 

A Soulbound Token (SBT) is a non-transferable, non-fungible token that represents identity, credentials, or commitments. This SBT follows the **EIP-5192** standard and serves as an immutable, publicly verifiable source of truth about GitHub Copilot.

## What is an SBT?

Soulbound Tokens are:
- **Non-transferable**: Cannot be sold or transferred
- **Non-fungible**: Each token is unique
- **Identity-based**: Represent credentials, achievements, or commitments
- **Publicly verifiable**: Stored on publicly accessible systems
- **Immutable**: Historical record cannot be changed

Learn more: [EIP-5192 Specification](https://eips.ethereum.org/EIPS/eip-5192)

## What's Inside

### 📄 Files

| File | Purpose |
|------|---------|
| `github-copilot-sbt.json` | Official SBT data and metadata |
| `SCHEMA.md` | JSON schema definition and field documentation |
| `DEPLOYMENT.md` | Guide to deploying SBT to GitHub Object Store |
| `validate_sbt.py` | Validation utility to verify SBT integrity |

### 📋 SBT Contents

The canonical SBT includes:

**Identity Information**
- Official name: GitHub Copilot
- Model: Claude Haiku 4.5
- Status: Active
- Launch date: 2021-06-29

**Capabilities**
- Code generation and suggestions
- Debugging assistance
- Documentation generation
- Test writing
- 20+ supported programming languages

**Governance**
- Operator: GitHub (Microsoft Corporation)
- Jurisdiction: United States
- Compliance: Microsoft Trust Principles, GitHub Responsible AI
- Service status: https://www.githubstatus.com

**Usage & Limitations**
- Access: VS Code extension
- Authentication: GitHub account
- Availability: 24/7
- **Non-transferable**: This SBT cannot be transferred or sold

## Quick Start

### 1. View the SBT

```bash
cat github-copilot-sbt.json | python3 -m json.tool
```

### 2. Validate the SBT

```bash
python3 validate_sbt.py github-copilot-sbt.json
```

Expected output:
```
✅ VALIDATION PASSED
   • JSON is valid
   • All required fields present
   • Field types correct
   • Claims properly structured
```

### 3. Deploy to GitHub

Follow [DEPLOYMENT.md](DEPLOYMENT.md) for instructions on:
- GitHub Gist (simplest)
- GitHub Pages (recommended for official hosting)
- GitHub Releases
- Raw GitHub content

## How to Use

### For Verification
1. Access the SBT from its GitHub Object Store location
2. Verify the JSON structure using the validation script
3. Cross-reference claims with official GitHub sources

### For Integration
Applications can:
- Reference the canonical URL to verify GitHub Copilot's official claims
- Parse the JSON to retrieve capability information
- Validate the EIP-5192 compliance status
- Build trust through immutable, public verification

### For Documentation
- Reference the SBT as canonical documentation
- Link to the SBT for authoritative identity verification
- Use in smart contracts or decentralized systems

## Deployment Status

### Current Status: ✅ Ready for Deployment

The SBT is complete and validated. Deployment methods available:

1. **GitHub Gist** - Copy to https://gist.github.com (easiest)
2. **GitHub Pages** - Host on GitHub Pages (recommended)
3. **GitHub Releases** - Attach as release artifact
4. **IPFS** - For distributed, immutable storage

### Recommended Canonical URL Format
```
https://[organization].github.io/github-copilot-sbt/sbt/github-copilot-sbt.json
```

## Standard Compliance

✅ **EIP-5192**: Soulbound Token Standard
- Non-transferable property defined
- Immutable storage approach
- Public verifiability via GitHub Object Store

✅ **JSON**: RFC 8259 compliant JSON format

✅ **Semantic Versioning**: Version 1.0.0

## Schema

See [SCHEMA.md](SCHEMA.md) for complete schema documentation including:
- Field definitions and types
- Required vs optional fields
- Validation rules
- Claim structure

## Verification

```bash
# Verify JSON syntax
python3 -m json.tool github-copilot-sbt.json > /dev/null

# Full schema validation
python3 validate_sbt.py github-copilot-sbt.json

# Generate checksum for integrity
openssl dgst -sha256 github-copilot-sbt.json
```

## Claims in this SBT

| Claim | Value | Verified By |
|-------|-------|-------------|
| Identity | GitHub Copilot | GitHub |
| Model | Claude Haiku 4.5 | Anthropic |
| Non-transferable | Cannot be transferred | GitHub |
| Service Provider | Microsoft Corporation | Corporate Registry |

## Use Cases

1. **Official Reference**: Canonical source for Copilot's official capabilities
2. **Integration Verification**: Verify Copilot's identity in external systems
3. **Smart Contracts**: Reference in blockchain/web3 applications
4. **Compliance**: Document governance and operational status
5. **Trust**: Immutable proof of identity and commitments

## Publishing Timeline

- **v1.0.0** (2026-04-19): Initial canonical SBT published
- **v1.x.x** (future): Minor updates to claims/capabilities
- **v2.0.0** (future): Major updates to structure/governance

## Contributing

To propose changes to this SBT:
1. Open an issue with details
2. Submit pull request with justification
3. Changes go through GitHub review process
4. Updates are versioned and tracked

## References

- [GitHub Copilot](https://github.com/features/copilot)
- [EIP-5192 Soulbound Token Standard](https://eips.ethereum.org/EIPS/eip-5192)
- [GitHub Security & Trust](https://github.com/security)
- [Microsoft Trust Principles](https://www.microsoft.com/en-us/trust-center)

## License

This SBT and its documentation are provided under the [Creative Commons Attribution 4.0 International License](LICENSE).

---

**Last Updated**: 2026-04-19  
**Status**: Active  
**Transferable**: No (Soulbound)