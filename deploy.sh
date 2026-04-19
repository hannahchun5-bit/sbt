#!/bin/bash
# GitHub Copilot Canonical SBT - Deployment Script
# This script helps deploy the SBT to GitHub

set -e

echo "🚀 GitHub Copilot Canonical SBT - Deployment Helper"
echo "=================================================="
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check prerequisites
echo "📋 Checking prerequisites..."

if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Git found${NC}"

if ! command -v python3 &> /dev/null; then
    echo -e "${RED}✗ Python3 is not installed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Python3 found${NC}"

# Validate SBT
echo ""
echo "🔍 Validating SBT structure..."
if python3 validate_sbt.py github-copilot-sbt.json > /dev/null 2>&1; then
    echo -e "${GREEN}✓ SBT validation passed${NC}"
else
    echo -e "${RED}✗ SBT validation failed${NC}"
    python3 validate_sbt.py github-copilot-sbt.json
    exit 1
fi

# Show menu
echo ""
echo "📦 Deployment Options:"
echo "===================="
echo "1) Deploy to GitHub Gist (simplest)"
echo "2) Deploy to GitHub Pages (recommended)"
echo "3) Create GitHub Repository with Pages"
echo "4) Show verification page locally"
echo "5) Generate deployment package"
echo ""
read -p "Choose option (1-5): " choice

case $choice in
    1)
        echo ""
        echo "📝 GitHub Gist Deployment"
        echo "======================="
        echo ""
        echo "Follow these steps:"
        echo "1. Go to https://gist.github.com"
        echo "2. Create new gist"
        echo "3. Add file: github-copilot-sbt.json"
        echo "4. Paste the following content:"
        echo ""
        cat github-copilot-sbt.json
        echo ""
        echo "5. Set visibility to 'Public'"
        echo "6. Click 'Create public gist'"
        echo ""
        echo "You'll get a URL like: https://gist.github.com/your-username/gist-id"
        echo "Raw content URL: https://gist.githubusercontent.com/your-username/gist-id/raw/github-copilot-sbt.json"
        ;;
    
    2)
        echo ""
        echo "📄 GitHub Pages Deployment"
        echo "=========================="
        echo ""
        echo "These steps create the GitHub Pages structure:"
        echo ""
        
        # Create directory structure
        mkdir -p docs/sbt
        
        # Copy files
        cp github-copilot-sbt.json docs/sbt/
        cp verification.html docs/index.html
        
        # Create .nojekyll to enable all files
        touch docs/.nojekyll
        
        # Create README for docs
        cat > docs/README.md << 'EOF'
# GitHub Copilot Canonical SBT

This is the GitHub Pages hosting for the official GitHub Copilot Canonical Soulbound Token (SBT).

## Files

- `index.html` - Interactive verification page
- `sbt/github-copilot-sbt.json` - Official SBT JSON data
- `.nojekyll` - GitHub Pages configuration

## Access

- **Verification Page**: [View](index.html)
- **Direct JSON Access**: [View](sbt/github-copilot-sbt.json)

## Next Steps

1. Push this repository to GitHub
2. Enable GitHub Pages in repository settings
3. Choose 'Deploy from a branch' and select 'main' and '/docs' folder
4. Your SBT will be available at: `https://your-username.github.io/repo-name/`
EOF
        
        echo -e "${GREEN}✓ Created docs/ directory structure${NC}"
        echo ""
        echo "Next steps:"
        echo "1. Initialize git repository (if not done):"
        echo "   git init"
        echo "   git add ."
        echo "   git commit -m 'Add GitHub Copilot canonical SBT'"
        echo ""
        echo "2. Create repository on GitHub: https://github.com/new"
        echo "   Name: github-copilot-sbt (or your choice)"
        echo "   Description: Official Canonical Soulbound Token for GitHub Copilot"
        echo "   Visibility: Public"
        echo ""
        echo "3. Add remote and push:"
        echo "   git remote add origin https://github.com/YOUR-USERNAME/github-copilot-sbt.git"
        echo "   git branch -M main"
        echo "   git push -u origin main"
        echo ""
        echo "4. Enable GitHub Pages:"
        echo "   Go to: https://github.com/YOUR-USERNAME/github-copilot-sbt/settings/pages"
        echo "   Source: Deploy from a branch"
        echo "   Branch: main"
        echo "   Folder: /docs"
        echo "   Click Save"
        echo ""
        echo "5. Access your SBT at:"
        echo "   https://YOUR-USERNAME.github.io/github-copilot-sbt/"
        ;;
    
    3)
        echo ""
        echo "🏗️  Creating Complete GitHub Repository"
        echo "========================================"
        
        # Initialize if needed
        if [ ! -d .git ]; then
            git init
            echo -e "${GREEN}✓ Initialized git repository${NC}"
        fi
        
        # Create full structure
        mkdir -p docs/sbt docs/verify
        mkdir -p src/validate src/schemas
        
        # Copy files
        cp github-copilot-sbt.json docs/sbt/
        cp verification.html docs/index.html
        cp validate_sbt.py src/validate/
        cp SCHEMA.md src/schemas/
        
        # Create CI/CD workflow
        mkdir -p .github/workflows
        cat > .github/workflows/validate.yml << 'EOF'
name: Validate SBT

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      
      - name: Validate JSON
        run: |
          python3 -m json.tool docs/sbt/github-copilot-sbt.json > /dev/null
          echo "✓ JSON is valid"
      
      - name: Run SBT Validation
        run: python3 src/validate/validate_sbt.py docs/sbt/github-copilot-sbt.json
EOF
        
        echo -e "${GREEN}✓ Created repository structure${NC}"
        
        # Add all files
        git add .
        git commit -m "Initial GitHub Copilot canonical SBT" || true
        
        echo ""
        echo "Repository created! Next steps:"
        echo "1. Create repository on GitHub: https://github.com/new"
        echo "2. Set remote: git remote add origin https://github.com/YOUR-USERNAME/github-copilot-sbt.git"
        echo "3. Push: git push -u origin main"
        echo "4. Enable GitHub Pages (see option 2)"
        ;;
    
    4)
        echo ""
        echo "🌐 Viewing Verification Page Locally"
        echo "===================================="
        echo ""
        echo "Starting local HTTP server..."
        echo ""
        echo -e "${YELLOW}Opening http://localhost:8000 in browser...${NC}"
        echo ""
        echo "Press Ctrl+C to stop the server"
        echo ""
        
        # Try to open in browser
        if command -v open &> /dev/null; then
            sleep 2 && open http://localhost:8000/verification.html &
        fi
        
        # Start server
        python3 -m http.server 8000
        ;;
    
    5)
        echo ""
        echo "📦 Generating Deployment Package"
        echo "================================"
        
        # Create package
        PACKAGE_DIR="github-copilot-sbt-package"
        mkdir -p "$PACKAGE_DIR"
        
        # Copy all files
        cp github-copilot-sbt.json "$PACKAGE_DIR/"
        cp verification.html "$PACKAGE_DIR/"
        cp validate_sbt.py "$PACKAGE_DIR/"
        cp README.md "$PACKAGE_DIR/"
        cp SCHEMA.md "$PACKAGE_DIR/"
        cp DEPLOYMENT.md "$PACKAGE_DIR/"
        cp QUICKSTART.md "$PACKAGE_DIR/"
        
        # Create deployment script
        cat > "$PACKAGE_DIR/deploy.sh" << 'EOF'
#!/bin/bash
# GitHub Copilot SBT - Quick Deploy Script

echo "Deploying GitHub Copilot Canonical SBT..."

# Initialize git if needed
if [ ! -d .git ]; then
    git init
    git add .
    git commit -m "GitHub Copilot canonical SBT"
fi

# Instructions
echo ""
echo "Next steps:"
echo "1. Create repository on GitHub"
echo "2. Add remote: git remote add origin <repo-url>"
echo "3. Push: git push -u origin main"
echo "4. Enable GitHub Pages"
echo ""
EOF
        
        chmod +x "$PACKAGE_DIR/deploy.sh"
        
        # Create archive
        tar -czf github-copilot-sbt.tar.gz "$PACKAGE_DIR"
        
        echo -e "${GREEN}✓ Package created: github-copilot-sbt.tar.gz${NC}"
        echo ""
        echo "Package contents:"
        tar -tzf github-copilot-sbt.tar.gz
        echo ""
        echo "Ready to distribute!"
        ;;
    
    *)
        echo -e "${RED}Invalid option${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}✓ Done!${NC}"
