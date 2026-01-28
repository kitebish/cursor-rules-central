#!/bin/bash
# Safety Verification Script for Mac/Linux
# Verifies that all safety mechanisms are properly configured

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

PROJECT_NAME=$(basename "$(pwd)")
ALL_TESTS_PASSED=true

echo ""
echo -e "${CYAN}Safety Verification${NC}"
echo "Project: $PROJECT_NAME"
echo "Location: $(pwd)"
echo ""

# Test 1: Check .gitignore
echo -n "[Test 1/3] .gitignore... "
if [ -f ".gitignore" ] && grep -q ".cursor" ".gitignore"; then
    echo -e "${GREEN}PASS${NC}"
else
    echo -e "${RED}FAIL${NC}"
    echo -e "  ${YELLOW}.gitignore missing or doesn't block .cursor/${NC}"
    ALL_TESTS_PASSED=false
fi

# Test 2: Check pre-commit hook
echo -n "[Test 2/3] Pre-commit hook... "
if [ -f ".git/hooks/pre-commit" ]; then
    if grep -q "cursor" ".git/hooks/pre-commit"; then
        echo -e "${GREEN}PASS${NC}"
    else
        echo -e "${RED}FAIL${NC}"
        echo -e "  ${YELLOW}Hook exists but doesn't check for cursor files${NC}"
        ALL_TESTS_PASSED=false
    fi
else
    echo -e "${RED}FAIL${NC}"
    echo -e "  ${YELLOW}Pre-commit hook not installed${NC}"
    ALL_TESTS_PASSED=false
fi

# Test 3: Check no cursor files in Git
echo -n "[Test 3/3] No cursor files in Git... "
if git ls-files | grep -qE '\.cursor/|\.mdc$|\.cursorrules$'; then
    echo -e "${RED}FAIL${NC}"
    echo -e "  ${YELLOW}Found cursor files in Git:${NC}"
    git ls-files | grep -E '\.cursor/|\.mdc$|\.cursorrules$' | sed 's/^/    /'
    ALL_TESTS_PASSED=false
else
    echo -e "${GREEN}PASS${NC}"
fi

# Summary
echo ""
if [ "$ALL_TESTS_PASSED" = true ]; then
    echo -e "${GREEN}All Safety Checks Passed${NC}"
    exit 0
else
    echo -e "${RED}Some Safety Checks Failed${NC}"
    echo "Run: ./setup-project.sh to fix issues"
    exit 1
fi
