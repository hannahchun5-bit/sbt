# Quick Start Guide - GitHub Copilot Canonical SBT

## 🚀 Getting Started in 5 Minutes

### What You Have

A **Soulbound Token** representing the canonical identity of GitHub Copilot, stored as:
- `github-copilot-sbt.json` - The official SBT data
- `verification.html` - Interactive verification page
- `validate_sbt.py` - Validation utility
- `SCHEMA.md` - Complete schema documentation
- `DEPLOYMENT.md` - Deployment instructions

### Step 1: Verify the SBT Locally

```bash
cd /Users/chunh/Documents/sbt

# Validate JSON structure
python3 validate_sbt.py github-copilot-sbt.json

# View the SBT data
cat github-copilot-sbt.json | python3 -m json.tool
```

Expected result:
```
✅ VALIDATION PASSED
   • JSON is valid
   • All required fields present
   • Field types correct
   • Claims properly structured
```

### Step 2: View in Browser

```bash
# Open the verification page
open verification.html

# Or use a simple HTTP server
python3 -m http.server 8000
# Visit http://localhost:8000/verification.html
```

### Step 3: Deploy to GitHub

Choose one method:

#### **Option A: GitHub Gist (Easiest)**
```bash
# 1. Go to https://gist.github.com
# 2. Create new gist
# 3. Add github-copilot-sbt.json
# 4. Set to public
# 5. Get the raw URL: https://gist.githubusercontent.com/...
```

#### **Option B: GitHub Pages (Recommended)**
```bash
# 1. Create repository: github-copilot-sbt
git init
git add .
git commit -m "Add GitHub Copilot canonical SBT"

# 2. Create docs folder
mkdir -p docs/sbt
cp github-copilot-sbt.json docs/sbt/
cp verification.html docs/index.html

# 3. Push to GitHub
git push -u origin main

# 4. Enable GitHub Pages in repo settings
# 5. URL will be: https://username.github.io/github-copilot-sbt/
```

## 📊 SBT Contents Summary

| Property | Value |
|----------|-------|
| **Name** | GitHub Copilot |
| **Model** | Claude Haiku 4.5 |
| **Standard** | EIP-5192 (Soulbound Token) |
| **Status** | Active |
| **Transferable** | No (Non-transferable) |
| **Version** | 1.0.0 |
| **Issued** | 2026-04-19 |

## 🔍 Key Claims

The SBT verifies these claims about GitHub Copilot:

1. ✅ **Identity**: Official GitHub Copilot AI Assistant
2. ✅ **Model**: Claude Haiku 4.5
3. ✅ **Non-transferable**: Cannot be bought/sold/transferred
4. ✅ **Operator**: GitHub (Microsoft Corporation)

## 📁 File Guide

```
/Users/chunh/Documents/sbt/
├── README.md                    # Full documentation
├── SCHEMA.md                    # JSON schema definition
├── DEPLOYMENT.md                # Deployment guide
├── QUICKSTART.md               # This file
├── github-copilot-sbt.json     # ⭐ Official SBT data
├── verification.html            # Interactive verification page
├── validate_sbt.py             # Validation script
└── .git/                        # Version control
```

## 🛠️ Common Commands

### Validate SBT
```bash
python3 validate_sbt.py github-copilot-sbt.json
```

### View SBT Data
```bash
cat github-copilot-sbt.json | python3 -m json.tool
```

### Check JSON Syntax
```bash
python3 -m json.tool github-copilot-sbt.json > /dev/null && echo "✓ Valid JSON"
```

### Generate Checksum
```bash
openssl dgst -sha256 github-copilot-sbt.json
```

### Preview in Browser
```bash
python3 -m http.server 8000
# Open http://localhost:8000/verification.html
```

## 🌐 Sharing the SBT

Once deployed, share these URLs:

**GitHub Gist:**
```
https://gist.github.com/your-username/gist-id
Raw: https://gist.githubusercontent.com/your-username/gist-id/raw/github-copilot-sbt.json
```

**GitHub Pages:**
```
https://your-username.github.io/github-copilot-sbt/
Direct: https://your-username.github.io/github-copilot-sbt/sbt/github-copilot-sbt.json
```

**Verification Page:**
```
https://your-username.github.io/github-copilot-sbt/
```

## 📖 What is a Soulbound Token (SBT)?

A **Soulbound Token** is a non-transferable NFT representing:
- **Identity** - Who/what the token represents
- **Credentials** - Qualifications or achievements
- **Commitments** - Official promises or guarantees

This SBT proves:
- ✅ GitHub Copilot's official identity
- ✅ Its current version and model
- ✅ Its status and capabilities
- ✅ Governance and compliance information

**Key property**: Cannot be transferred or sold (unlike regular NFTs)

Standard: **EIP-5192** - Soulbound Token Standard

## 🔗 Useful Resources

- [GitHub Copilot Docs](https://github.com/features/copilot)
- [EIP-5192 Standard](https://eips.ethereum.org/EIPS/eip-5192)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
- [JSON Schema Validation](https://json-schema.org/)

## ✅ Next Steps

1. ✓ Created canonical SBT data
2. ✓ Validated structure
3. ⏭️ Choose deployment method
4. ⏭️ Deploy to GitHub (Gist or Pages)
5. ⏭️ Share canonical URL
6. ⏭️ Document verification process

## 💡 Pro Tips

- **Immutability**: Version your SBT changes in Git history
- **Verification**: Share the raw URL for direct JSON access
- **Verification Page**: Point users to the interactive HTML verification page
- **Documentation**: Link to SCHEMA.md for technical details
- **Integration**: Reference the canonical URL in smart contracts or applications

## 📞 Support

For issues or questions:
1. Check [SCHEMA.md](SCHEMA.md) for field definitions
2. See [DEPLOYMENT.md](DEPLOYMENT.md) for deployment help
3. Review [README.md](README.md) for full documentation
4. Run `python3 validate_sbt.py` to check SBT integrity

---

**Last Updated**: 2026-04-19
**Status**: Ready for deployment
**Recommendation**: Deploy to GitHub Pages for official hosting
