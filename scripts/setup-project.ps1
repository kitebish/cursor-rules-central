# Project Setup Script for Windows
# Run this in each project directory to set up safety mechanisms

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

# Step 1: Check if it's a Git repository
Write-Host "[1/3] Checking Git repository..." -ForegroundColor Yellow
if (!(Test-Path ".git")) {
    Write-Host "WARNING: This is not a Git repository" -ForegroundColor Red
    Write-Host "Initialize Git first with: git init" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Git repository detected" -ForegroundColor Green
Write-Host ""

# Step 2: Update .gitignore
Write-Host "[2/3] Updating .gitignore..." -ForegroundColor Yellow

$gitignorePath = ".gitignore"
$cursorIgnoreLines = @"

# Cursor AI Configuration (DO NOT COMMIT)
.cursor/
*.mdc
.cursorrules
"@

if (Test-Path $gitignorePath) {
    $content = Get-Content $gitignorePath -Raw
    if ($content -notmatch "\.cursor") {
        Add-Content -Path $gitignorePath -Value $cursorIgnoreLines
        Write-Host "✓ Added Cursor rules to existing .gitignore" -ForegroundColor Green
    } else {
        Write-Host "✓ .gitignore already contains Cursor rules" -ForegroundColor Green
    }
} else {
    Set-Content -Path $gitignorePath -Value $cursorIgnoreLines.TrimStart()
    Write-Host "✓ Created .gitignore with Cursor rules" -ForegroundColor Green
}
Write-Host ""

# Step 3: Install pre-commit hook
Write-Host "[3/3] Installing pre-commit hook..." -ForegroundColor Yellow

$hookPath = ".git\hooks\pre-commit"
$hookContent = @'
#!/bin/sh
# Pre-commit hook to prevent committing Cursor configuration files

# Check for cursor files in staged changes
if git diff --cached --name-only | grep -qE '\.cursor/|\.mdc$|\.cursorrules$'; then
    echo ""
    echo "❌ ERROR: Attempting to commit Cursor configuration files!"
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
Write-Host "✓ Installed pre-commit hook" -ForegroundColor Green
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "What was configured:" -ForegroundColor White
Write-Host "✓ .gitignore updated to block Cursor files" -ForegroundColor Green
Write-Host "✓ Pre-commit hook installed" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor White
Write-Host "1. Open this project in Cursor" -ForegroundColor Gray
Write-Host "2. Cursor will automatically load rules from cursor-rules-central" -ForegroundColor Gray
Write-Host "3. Test by asking Cursor to generate code" -ForegroundColor Gray
Write-Host ""
Write-Host "Verify safety:" -ForegroundColor White
Write-Host "Run: verify-safety.ps1" -ForegroundColor Cyan
Write-Host ""
