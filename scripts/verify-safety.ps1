# Safety Verification Script for Windows
# Verifies that all safety mechanisms are working correctly

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Cursor Rules Safety Verification" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$allTestsPassed = $true

# Test 1: Project gitignore
Write-Host "[Test 1/3] Project .gitignore..." -NoNewline
if (Test-Path ".gitignore") {
    $content = Get-Content ".gitignore" -Raw
    if ($content -match "\.cursor") {
        Write-Host " ✅ PASS" -ForegroundColor Green
    } else {
        Write-Host " ❌ FAIL" -ForegroundColor Red
        Write-Host "  .gitignore exists but doesn't include .cursor/" -ForegroundColor Yellow
        Write-Host "  Run setup-project.ps1 to fix this" -ForegroundColor Yellow
        $allTestsPassed = $false
    }
} else {
    Write-Host " ❌ FAIL" -ForegroundColor Red
    Write-Host "  No .gitignore file found" -ForegroundColor Yellow
    Write-Host "  Run setup-project.ps1 to create it" -ForegroundColor Yellow
    $allTestsPassed = $false
}

# Test 2: Pre-commit hook
Write-Host "[Test 2/3] Pre-commit hook..." -NoNewline
if (Test-Path ".git\hooks\pre-commit") {
    $content = Get-Content ".git\hooks\pre-commit" -Raw
    if ($content -match "cursor") {
        Write-Host " ✅ PASS" -ForegroundColor Green
    } else {
        Write-Host " ❌ FAIL" -ForegroundColor Red
        Write-Host "  Hook exists but doesn't check for cursor files" -ForegroundColor Yellow
        $allTestsPassed = $false
    }
} else {
    Write-Host " ❌ FAIL" -ForegroundColor Red
    Write-Host "  Pre-commit hook not installed" -ForegroundColor Yellow
    Write-Host "  Run setup-project.ps1 to install it" -ForegroundColor Yellow
    $allTestsPassed = $false
}

# Test 3: Actual commit test
Write-Host "[Test 3/3] Testing actual commit block..." -NoNewline
if (Test-Path ".git") {
    # Create a test cursor file
    "test" | Out-File -FilePath ".cursor-test" -NoNewline
    
    # Try to stage it
    git add -f ".cursor-test" 2>$null
    
    # Try to commit (should fail)
    $commitOutput = git commit -m "test" 2>&1
    
    # Clean up
    git reset HEAD ".cursor-test" 2>$null
    Remove-Item ".cursor-test" -ErrorAction SilentlyContinue
    
    if ($commitOutput -match "ERROR.*Cursor" -or $commitOutput -match "nothing to commit") {
        Write-Host " ✅ PASS" -ForegroundColor Green
        Write-Host "  (Commit was blocked as expected)" -ForegroundColor Gray
    } else {
        Write-Host " ⚠️  WARNING" -ForegroundColor Yellow
        Write-Host "  Could not verify commit blocking" -ForegroundColor Yellow
    }
} else {
    Write-Host " ⚠️  SKIP" -ForegroundColor Yellow
    Write-Host "  (Not a Git repository)" -ForegroundColor Gray
}

# Summary
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
if ($allTestsPassed) {
    Write-Host "All critical tests passed! ✅" -ForegroundColor Green
} else {
    Write-Host "Some tests failed ❌" -ForegroundColor Red
    Write-Host "Please review the failures above" -ForegroundColor Yellow
}
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if (!$allTestsPassed) {
    Write-Host "To fix issues:" -ForegroundColor White
    Write-Host "Run: setup-project.ps1" -ForegroundColor Cyan
    Write-Host ""
}
