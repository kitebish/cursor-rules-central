# Project Setup Script for Windows
# Run this in each project directory to set up safety mechanisms and copy rules

param(
    [string]$ProjectPath = "."
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Project Setup for Cursor Rules" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Navigate to project directory
Set-Location $ProjectPath
$projectName = Split-Path -Leaf (Get-Location)

Write-Host "Setting up project: $projectName" -ForegroundColor White
Write-Host "Location: $(Get-Location)" -ForegroundColor Gray
Write-Host ""

# Find the cursor-rules-central directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$centralRepoPath = Split-Path -Parent $scriptPath

Write-Host "Central rules location: $centralRepoPath" -ForegroundColor Gray
Write-Host ""

# Step 1: Copy .cursor/rules/ from central repo
Write-Host "[1/4] Copying .cursor/rules/ from central repository..." -ForegroundColor Yellow

if (Test-Path "$centralRepoPath\.cursor\rules") {
    # Create .cursor directory if it doesn't exist
    if (!(Test-Path ".cursor")) {
        New-Item -ItemType Directory -Path ".cursor" | Out-Null
    }
    
    # Copy rules directory
    Copy-Item -Recurse -Force "$centralRepoPath\.cursor\rules" ".cursor\"
    
    $ruleCount = (Get-ChildItem ".cursor\rules\*.mdc").Count
    Write-Host "SUCCESS: Copied $ruleCount rule files to .cursor/rules/" -ForegroundColor Green
} else {
    Write-Host "ERROR: Cannot find .cursor/rules/ in central repository" -ForegroundColor Red
    Write-Host "Expected location: $centralRepoPath\.cursor\rules" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Step 2: Check if it's a Git repository
Write-Host "[2/4] Checking Git repository..." -ForegroundColor Yellow
if (!(Test-Path ".git")) {
    Write-Host "WARNING: This is not a Git repository" -ForegroundColor Red
    Write-Host "Initialize Git first with: git init" -ForegroundColor Yellow
    exit 1
}
Write-Host "SUCCESS: Git repository detected" -ForegroundColor Green
Write-Host ""

# Step 3: Update .gitignore
Write-Host "[3/4] Updating .gitignore..." -ForegroundColor Yellow

$gitignorePath = ".gitignore"
$cursorIgnoreLines = @"

# Cursor AI Configuration (DO NOT COMMIT)
.cursor/
*.mdc
.cursorrules
"@

if (Test-Path $gitignorePath) {
    $content = Get-Content $gitignorePath -Raw
    if ($content -notmatch ".cursor") {
        Add-Content -Path $gitignorePath -Value $cursorIgnoreLines
        Write-Host "SUCCESS: Added Cursor rules to existing .gitignore" -ForegroundColor Green
    } else {
        Write-Host "SUCCESS: .gitignore already contains Cursor rules" -ForegroundColor Green
    }
} else {
    Set-Content -Path $gitignorePath -Value $cursorIgnoreLines.TrimStart()
    Write-Host "SUCCESS: Created .gitignore with Cursor rules" -ForegroundColor Green
}
Write-Host ""

# Step 4: Install pre-commit hook
Write-Host "[4/4] Installing pre-commit hook..." -ForegroundColor Yellow

$hookPath = ".git\hooks\pre-commit"
$hookContent = @'
#!/bin/sh
# Pre-commit hook to prevent committing Cursor configuration files

# Check for cursor files in staged changes
if git diff --cached --name-only | grep -qE '\.cursor/|\.mdc$|\.cursorrules$'; then
    echo ""
    echo "ERROR: Attempting to commit Cursor configuration files!"
    echo ""
    echo "The following Cursor files are staged:"
    git diff --cached --name-only | grep -E '\.cursor/|\.mdc$|\.cursorrules$'
    echo ""
    echo "These files should NEVER be committed to customer repositories."
    echo ""
    echo "To unstage: git restore --staged <file>"
    echo "To bypass this check (NOT RECOMMENDED): git commit --no-verify"
    echo ""
    exit 1
fi

exit 0
'@

# Create hooks directory if it doesn't exist
if (!(Test-Path ".git\hooks")) {
    New-Item -ItemType Directory -Path ".git\hooks" | Out-Null
}

Set-Content -Path $hookPath -Value $hookContent -NoNewline
Write-Host "SUCCESS: Installed pre-commit hook" -ForegroundColor Green
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "What was configured:" -ForegroundColor White
Write-Host "- Copied .cursor/rules/ to this project" -ForegroundColor Green
Write-Host "- .gitignore updated to block Cursor files" -ForegroundColor Green
Write-Host "- Pre-commit hook installed" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Open this project in Cursor" -ForegroundColor Gray
Write-Host "2. Cursor will automatically load the rules" -ForegroundColor Gray
Write-Host "3. Test by asking Cursor to generate code" -ForegroundColor Gray
Write-Host ""
Write-Host "Verify safety:" -ForegroundColor White
Write-Host "Run: verify-safety.ps1" -ForegroundColor Cyan
Write-Host ""
