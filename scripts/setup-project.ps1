# Cursor Rules Setup Script
# Automatically configures a project with Cursor AI rules and safety mechanisms

param(
    [string]$ProjectPath = "."
)

# Navigate to project directory
Set-Location $ProjectPath
$projectName = Split-Path -Leaf (Get-Location)

Write-Host ""
Write-Host "Cursor Rules Setup" -ForegroundColor Cyan
Write-Host "Project: $projectName"
Write-Host "Location: $(Get-Location)"
Write-Host ""

# Find the cursor-rules-central directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$centralRepoPath = Split-Path -Parent $scriptPath

# Step 1: Initialize Git repository if needed
Write-Host "[Step 1/4] Checking Git repository" -ForegroundColor Yellow
if (!(Test-Path ".git")) {
    Write-Host "  Initializing Git repository..."
    git init | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Git repository initialized" -ForegroundColor Green
    } else {
        Write-Host "  ERROR: Failed to initialize Git" -ForegroundColor Red
        Write-Host "  Please install Git: https://git-scm.com"
        exit 1
    }
} else {
    Write-Host "  Git repository found" -ForegroundColor Green
}

# Step 2: Create or update .gitignore
Write-Host "[Step 2/4] Configuring .gitignore" -ForegroundColor Yellow

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
        Write-Host "  Added Cursor rules to .gitignore" -ForegroundColor Green
    } else {
        Write-Host "  .gitignore already configured" -ForegroundColor Green
    }
} else {
    Set-Content -Path $gitignorePath -Value $cursorIgnoreLines.TrimStart()
    Write-Host "  Created .gitignore" -ForegroundColor Green
}

# Step 3: Copy rules from central repository
Write-Host "[Step 3/4] Copying Cursor rules" -ForegroundColor Yellow

if (Test-Path "$centralRepoPath\.cursor\rules") {
    if (!(Test-Path ".cursor")) {
        New-Item -ItemType Directory -Path ".cursor" | Out-Null
    }
    
    Copy-Item -Recurse -Force "$centralRepoPath\.cursor\rules" ".cursor\"
    
    $ruleCount = (Get-ChildItem ".cursor\rules\*.mdc").Count
    Write-Host "  Copied $ruleCount rule files" -ForegroundColor Green
    Write-Host "  Files are gitignored (will not be committed)" -ForegroundColor Gray
} else {
    Write-Host "  ERROR: Cannot find rules in central repository" -ForegroundColor Red
    Write-Host "  Expected: $centralRepoPath\.cursor\rules"
    exit 1
}

# Step 4: Install pre-commit hook
Write-Host "[Step 4/4] Installing pre-commit hook" -ForegroundColor Yellow

$hookPath = ".git\hooks\pre-commit"
$hookContent = @'
#!/bin/sh
# Pre-commit hook to prevent committing Cursor configuration files

if git diff --cached --name-only | grep -qE '\.cursor/|\.mdc$|\.cursorrules$'; then
    echo ""
    echo "ERROR: Attempting to commit Cursor configuration files"
    echo ""
    echo "Staged Cursor files:"
    git diff --cached --name-only | grep -E '\.cursor/|\.mdc$|\.cursorrules$'
    echo ""
    echo "These files should not be committed to customer repositories."
    echo ""
    echo "To unstage: git restore --staged <file>"
    echo "To bypass (not recommended): git commit --no-verify"
    echo ""
    exit 1
fi

exit 0
'@

if (!(Test-Path ".git\hooks")) {
    New-Item -ItemType Directory -Path ".git\hooks" | Out-Null
}

Set-Content -Path $hookPath -Value $hookContent -NoNewline
Write-Host "  Pre-commit hook installed" -ForegroundColor Green

# Summary
Write-Host ""
Write-Host "Setup complete" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:"
Write-Host "  1. Open project in Cursor"
Write-Host "  2. Rules will load automatically"
Write-Host "  3. Verify with: verify-safety.ps1"
Write-Host ""
