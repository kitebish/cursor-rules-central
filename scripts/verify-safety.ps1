# Cursor Rules Safety Verification Script
# Verifies that all safety mechanisms are properly configured

$projectName = Split-Path -Leaf (Get-Location)
$allTestsPassed = $true

Write-Host ""
Write-Host "Safety Verification" -ForegroundColor Cyan
Write-Host "Project: $projectName"
Write-Host "Location: $(Get-Location)"
Write-Host ""

# Test 1: Check .gitignore
Write-Host "[Test 1/3] .gitignore" -ForegroundColor Yellow
if (Test-Path ".gitignore") {
    $content = Get-Content ".gitignore" -Raw
    if ($content -match "\.cursor") {
        Write-Host "  PASS" -ForegroundColor Green
    } else {
        Write-Host "  FAIL" -ForegroundColor Red
        Write-Host "  .gitignore exists but doesn't block .cursor/" -ForegroundColor Gray
        $allTestsPassed = $false
    }
} else {
    Write-Host "  FAIL" -ForegroundColor Red
    Write-Host "  No .gitignore file found" -ForegroundColor Gray
    $allTestsPassed = $false
}

# Test 2: Check pre-commit hook
Write-Host "[Test 2/3] Pre-commit hook" -ForegroundColor Yellow
if (Test-Path ".git\hooks\pre-commit") {
    $content = Get-Content ".git\hooks\pre-commit" -Raw
    if ($content -match "cursor") {
        Write-Host "  PASS" -ForegroundColor Green
    } else {
        Write-Host "  FAIL" -ForegroundColor Red
        Write-Host "  Hook exists but doesn't check for cursor files" -ForegroundColor Gray
        $allTestsPassed = $false
    }
} else {
    Write-Host "  FAIL" -ForegroundColor Red
    Write-Host "  Pre-commit hook not installed" -ForegroundColor Gray
    $allTestsPassed = $false
}

# Test 3: Check no cursor files in Git
Write-Host "[Test 3/3] No cursor files in Git" -ForegroundColor Yellow
if (Test-Path ".git") {
    $cursorFiles = git ls-files | Select-String -Pattern "\.cursor/|\.mdc$|\.cursorrules$"
    if ($cursorFiles) {
        Write-Host "  FAIL" -ForegroundColor Red
        Write-Host "  Found cursor files in Git:" -ForegroundColor Gray
        $cursorFiles | ForEach-Object { Write-Host "    $_" -ForegroundColor Gray }
        $allTestsPassed = $false
    } else {
        Write-Host "  PASS" -ForegroundColor Green
    }
} else {
    Write-Host "  SKIP" -ForegroundColor Yellow
    Write-Host "  Not a Git repository" -ForegroundColor Gray
}

# Summary
Write-Host ""
if ($allTestsPassed) {
    Write-Host "All tests passed" -ForegroundColor Green
} else {
    Write-Host "Some tests failed" -ForegroundColor Red
    Write-Host ""
    Write-Host "To fix issues:"
    Write-Host "  Run: setup-project.ps1"
}
Write-Host ""
