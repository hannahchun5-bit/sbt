# GitHub Copilot SBT - Deployment Guide

## Overview
This guide explains how to make the GitHub Copilot Canonical SBT available at a GitHub Object Store for public verification and reference.

## Methods to Deploy

### Method 1: GitHub Gist (Recommended for Simplicity)

GitHub Gists provide an easy way to share and version JSON files with a public URL.

**Steps:**
1. Go to https://gist.github.com
2. Create a new gist
3. Add the file `github-copilot-sbt.json`
4. Paste the contents from this repository
5. Create as public gist
6. Copy the raw URL: `https://gist.githubusercontent.com/[username]/[gist-id]/raw/[version]/github-copilot-sbt.json`

**Result:**
- Public, immutable URL
- Versioned history
- Easy to share
- No authentication needed to view

---

### Method 2: GitHub Pages (Recommended for Official Hosting)

GitHub Pages provides permanent, fast CDN-backed hosting.

**Steps:**
1. Create/push to a GitHub repository (e.g., `sbt-registry` or `canonical-identity`)
2. Enable GitHub Pages in repository settings
3. Choose main branch or `/docs` folder as source
4. Create directory structure:
   ```
   docs/
   ├── index.html
   ├── sbt/
   │   └── github-copilot-sbt.json
   └── verify/
       └── verification.html
   ```

5. Add `.json` files to `docs/sbt/`
6. Create verification page in `docs/verify/verification.html`

**Result:**
- Official GitHub Pages domain
- HTTPS SSL certificate
- Permanent storage
- Version controlled

**Example URL:**
```
https://username.github.io/sbt-registry/sbt/github-copilot-sbt.json
```

---

### Method 3: GitHub Releases

Store the SBT as an artifact in GitHub Releases.

**Steps:**
1. Create a repository: `github-copilot-sbt`
2. Make a release with version `v1.0.0`
3. Attach `github-copilot-sbt.json` as release asset
4. Release URL format:
   ```
   https://github.com/username/github-copilot-sbt/releases/download/v1.0.0/github-copilot-sbt.json
   ```

---

### Method 4: GitHub Raw Content (Simplest)

Host directly in a GitHub repository using raw content URL.

**Steps:**
1. Push files to GitHub repository
2. Access via raw URL:
   ```
   https://raw.githubusercontent.com/username/repo/main/github-copilot-sbt.json
   ```

**Limitations:**
- Rate limited (60 requests/hour unauthenticated)
- Less reliable than Gists or Pages

---

## Recommended Setup

For official GitHub Copilot SBT, I recommend **GitHub Pages** because:

✅ **Advantages:**
- Permanent official hosting
- HTTPS/SSL included
- CDN-backed (fast globally)
- Professional appearance
- Version control via Git
- Zero cost
- Beautiful UI/documentation possible

**Repository Setup:**
```
github/copilot-sbt/
├── README.md
├── docs/
│   ├── index.html              # Verification page
│   └── sbt/
│       ├── github-copilot-sbt.json
│       └── schema.json
├── src/
│   ├── generator/              # SBT generation scripts
│   └── verify/                 # Verification utilities
└── .github/
    └── workflows/
        └── validate.yml        # CI/CD validation
```

---

## Verification Setup

### Create `docs/index.html`

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GitHub Copilot Canonical SBT</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif; }
        .container { max-width: 1200px; margin: 0 auto; padding: 20px; }
        .badge { display: inline-block; padding: 8px 16px; border-radius: 4px; background: #238636; color: white; }
        pre { background: #f6f8fa; padding: 16px; border-radius: 6px; overflow-x: auto; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🤖 GitHub Copilot Canonical SBT</h1>
        <p class="badge">Soulbound Token (EIP-5192)</p>
        
        <h2>Official Identity & Data</h2>
        <p>This Soulbound Token represents the canonical identity and information about GitHub Copilot.</p>
        
        <h3>Token Details</h3>
        <ul>
            <li><strong>ID:</strong> github-copilot-canonical-2026</li>
            <li><strong>Version:</strong> 1.0.0</li>
            <li><strong>Issuer:</strong> GitHub (Microsoft)</li>
            <li><strong>Status:</strong> Active</li>
            <li><strong>Transferable:</strong> No (Soulbound)</li>
        </ul>
        
        <h3>Access Token Data</h3>
        <pre><code id="sbt-data">Loading...</code></pre>
        
        <h3>Verify Signature</h3>
        <form id="verify-form">
            <textarea id="signature" placeholder="Paste verification signature" style="width: 100%; height: 100px;"></textarea>
            <button type="submit">Verify</button>
        </form>
        
        <p><em>Last Updated: 2026-04-19</em></p>
    </div>
    
    <script>
        // Load and display SBT data
        fetch('./sbt/github-copilot-sbt.json')
            .then(r => r.json())
            .then(data => {
                document.getElementById('sbt-data').textContent = JSON.stringify(data, null, 2);
            })
            .catch(e => console.error('Failed to load SBT:', e));
    </script>
</body>
</html>
```

---

## CI/CD Validation

Create `.github/workflows/validate.yml`:

```yaml
name: Validate SBT

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Validate JSON
        run: |
          python3 -m json.tool docs/sbt/github-copilot-sbt.json > /dev/null
      - name: Check Schema
        run: python3 src/verify/validate_schema.py
```

---

## Distribution

Once deployed, share the URL:

**GitHub Gist:**
```
https://gist.github.com/[username]/[id]
```

**GitHub Pages:**
```
https://[organization].github.io/github-copilot-sbt/
```

**Raw Content:**
```
https://raw.githubusercontent.com/[org]/github-copilot-sbt/main/docs/sbt/github-copilot-sbt.json
```

---

## Verification Commands

### Validate SBT JSON Structure
```bash
python3 -m json.tool github-copilot-sbt.json > /dev/null && echo "✓ Valid JSON"
```

### Verify Compliance
```bash
# Check required fields
python3 src/verify/validate_schema.py
```

### Generate Checksum
```bash
# Create integrity hash
openssl dgst -sha256 github-copilot-sbt.json
```

---

## Security Considerations

1. **Immutability**: Once published, SBT should not change (version if needed)
2. **HTTPS**: Always use HTTPS URLs for verification
3. **Signature**: Consider signing with GPG key for authenticity
4. **Access Control**: Make SBT repository public but code changes controlled
5. **Monitoring**: Track distribution and usage of the SBT

---

## Next Steps

1. Choose deployment method (recommended: GitHub Pages)
2. Create repository with structure
3. Push SBT files
4. Enable GitHub Pages
5. Share canonical URL
6. Document verification process
7. Monitor adoption and distribution
