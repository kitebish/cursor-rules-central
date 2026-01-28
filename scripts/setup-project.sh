#!/bin/bash
# Cursor Rules Setup Script for Mac/Linux
# Automatically configures a project with Cursor AI rules and safety mechanisms

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Get project info
PROJECT_NAME=$(basename "$(pwd)")
PROJECT_PATH=$(pwd)

echo ""
echo -e "${CYAN}Cursor Rules Setup${NC}"
echo "Project: $PROJECT_NAME"
echo "Location: $PROJECT_PATH"
echo ""

# Find the cursor-rules-central directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CENTRAL_REPO_PATH="$(dirname "$SCRIPT_DIR")"

# Step 1: Initialize Git repository if needed
echo -e "${YELLOW}[Step 1/4] Checking Git repository${NC}"
if [ ! -d ".git" ]; then
    echo "  Initializing Git repository..."
    git init > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "  ${GREEN}Git repository initialized${NC}"
    else
        echo -e "  ${RED}ERROR: Failed to initialize Git${NC}"
        echo "  Please install Git: https://git-scm.com"
        exit 1
    fi
else
    echo -e "  ${GREEN}Git repository found${NC}"
fi

# Step 2: Create or update .gitignore
echo -e "${YELLOW}[Step 2/4] Configuring .gitignore${NC}"

GITIGNORE_CONTENT="
# Cursor AI Configuration (DO NOT COMMIT)
.cursor/
*.mdc
.cursorrules"

if [ -f ".gitignore" ]; then
    if ! grep -q ".cursor" ".gitignore"; then
        echo "$GITIGNORE_CONTENT" >> .gitignore
        echo -e "  ${GREEN}Added Cursor rules to .gitignore${NC}"
    else
        echo -e "  ${GREEN}.gitignore already configured${NC}"
    fi
else
    echo "$GITIGNORE_CONTENT" > .gitignore
    echo -e "  ${GREEN}Created .gitignore${NC}"
fi

# Step 3: Copy rules from central repository
echo -e "${YELLOW}[Step 3/4] Copying Cursor rules${NC}"

if [ -d "$CENTRAL_REPO_PATH/.cursor/rules" ]; then
    mkdir -p .cursor
    cp -r "$CENTRAL_REPO_PATH/.cursor/rules" .cursor/
    
    RULE_COUNT=$(find .cursor/rules -name "*.mdc" | wc -l)
    echo -e "  ${GREEN}Copied $RULE_COUNT rule files${NC}"
    echo -e "  ${GRAY}Files are gitignored (will not be committed)${NC}"
else
    echo -e "  ${RED}ERROR: Cannot find rules in central repository${NC}"
    echo "  Expected: $CENTRAL_REPO_PATH/.cursor/rules"
    exit 1
fi

# Step 4: Install pre-commit hook
echo -e "${YELLOW}[Step 4/4] Installing pre-commit hook${NC}"

HOOK_PATH=".git/hooks/pre-commit"
HOOK_CONTENT='#!/bin/sh
# Pre-commit hook to prevent committing Cursor configuration files

if git diff --cached --name-only | grep -qE '"'"'\.cursor/|\.mdc$|\.cursorrules$'"'"'; then
    echo ""
    echo "ERROR: Attempting to commit Cursor configuration files"
    echo ""
    echo "Staged Cursor files:"
    git diff --cached --name-only | grep -E '"'"'\.cursor/|\.mdc$|\.cursorrules$'"'"'
    echo ""
    echo "These files should not be committed to customer repositories."
    echo ""
    echo "To unstage: git restore --staged <file>"
    echo "To bypass (not recommended): git commit --no-verify"
    echo ""
    exit 1
fi

exit 0'

mkdir -p .git/hooks
echo "$HOOK_CONTENT" > "$HOOK_PATH"
chmod +x "$HOOK_PATH"
echo -e "  ${GREEN}Pre-commit hook installed${NC}"

# Step 5: Copy GitHub Actions workflow (CI/CD layer)
echo -e "${YELLOW}[Step 5/5] Installing CI/CD safety check${NC}"

WORKFLOW_SOURCE="$CENTRAL_REPO_PATH/.github/workflows/safety-check.yml"
WORKFLOW_DEST=".github/workflows/safety-check.yml"

if [ -f "$WORKFLOW_SOURCE" ]; then
    mkdir -p .github/workflows
    cp "$WORKFLOW_SOURCE" "$WORKFLOW_DEST"
    echo -e "  ${GREEN}GitHub Actions workflow installed${NC}"
    echo -e "  ${GRAY}Will run on every push and pull request${NC}"
else
    echo -e "  ${YELLOW}SKIP (workflow not found in central repo)${NC}"
fi

# Summary
echo ""
echo -e "${GREEN}Setup complete${NC}"
echo ""
echo "Safety layers installed:"
echo "  1. .gitignore (passive blocking)"
echo "  2. Pre-commit hook (active blocking)"
echo "  3. CI/CD check (server-side verification)"
echo ""
echo "Next steps:"
echo "  1. Open project in Cursor"
echo "  2. Rules will load automatically"
echo "  3. Verify with: ./verify-safety.sh"
echo ""
