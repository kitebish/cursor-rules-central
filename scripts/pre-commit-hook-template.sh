#!/bin/sh
# Pre-commit hook to prevent committing Cursor configuration files
# This hook is installed by setup-project.ps1

# Check if any Cursor-related files are being committed
if git diff --cached --name-only | grep -qE '\.cursor/|\.cursorrules$|\.mdc$'; then
    echo ""
    echo "❌ ERROR: Attempting to commit Cursor configuration files!"
    echo ""
    echo "The following Cursor files are staged:"
    git diff --cached --name-only | grep -E '\.cursor/|\.cursorrules$|\.mdc$'
    echo ""
    echo "These files should NEVER be committed to customer repositories."
    echo "They are automatically gitignored for safety."
    echo ""
    echo "If you absolutely must commit (very rare), use:"
    echo "  git commit --no-verify"
    echo ""
    exit 1
fi

# All good!
exit 0
