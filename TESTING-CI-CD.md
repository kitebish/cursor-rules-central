# Testing the CI/CD Safety Layer

## Step 1: Run Setup Script

```powershell
cd C:\Users\kiteb\OneDrive\Desktop\OJT\ojt-prep\cursor-rules-demo\example-react-project
& ..\cursor-rules-central\scripts\setup-project.ps1
```

**Expected output**:

```
[Step 5/5] Installing CI/CD safety check
  GitHub Actions workflow installed
  Will run on every push and pull request
```

## Step 2: Verify Files Were Created

```powershell
# Check if workflow file exists
Test-Path .github\workflows\safety-check.yml
# Should return: True

# View the workflow
cat .github\workflows\safety-check.yml
```

## Step 3: Commit and Push to GitHub

```powershell
# Add the workflow
git add .github\workflows\safety-check.yml
git commit -m "Add CI/CD safety check"

# Push to GitHub
git push origin main
```

## Step 4: Test the CI/CD Check

### Test 1: Try to Commit Cursor Files (Should Fail)

```powershell
# Create a test cursor file
echo "test" > .cursorrules

# Force add it (bypass gitignore)
git add -f .cursorrules

# Try to commit with --no-verify (bypass hook)
git commit --no-verify -m "test cursor file"

# Push to GitHub
git push origin main
```

**Expected**: GitHub Actions should FAIL with error message

### Test 2: Check GitHub Actions

1. Go to your GitHub repository
2. Click "Actions" tab
3. You should see the workflow run
4. It should show as FAILED (red X)
5. Click on the failed run
6. You should see error: "Cursor configuration files found"

### Test 3: Fix and Verify (Should Pass)

```powershell
# Remove the cursor file
git rm .cursorrules
git commit -m "Remove cursor file"
git push origin main
```

**Expected**: GitHub Actions should PASS (green checkmark)

## Step 5: Verify All 3 Layers

```powershell
& ..\cursor-rules-central\scripts\verify-safety.ps1
```

**Expected output**:

```
[Test 1/3] .gitignore
  PASS

[Test 2/3] Pre-commit hook
  PASS

[Test 3/3] No cursor files in Git
  PASS

All tests passed
```

## Quick Test Summary

```powershell
# 1. Run setup
& ..\cursor-rules-central\scripts\setup-project.ps1

# 2. Check workflow exists
Test-Path .github\workflows\safety-check.yml

# 3. Commit and push
git add .github\workflows\safety-check.yml
git commit -m "Add CI/CD safety check"
git push

# 4. Go to GitHub → Actions tab
# 5. Verify workflow runs on push
```

## What to Look For

✅ Workflow file created at `.github/workflows/safety-check.yml`  
✅ Workflow appears in GitHub Actions tab  
✅ Workflow runs automatically on push  
✅ Workflow fails if cursor files present  
✅ Workflow passes if no cursor files

## Troubleshooting

**Workflow doesn't run**:

- Check if `.github/workflows/safety-check.yml` is committed
- Check GitHub Actions is enabled in repo settings

**Workflow always passes**:

- Check the workflow file syntax
- Look at workflow logs in GitHub Actions tab

**Can't push**:

- Make sure you have push access to the repo
- Check if branch protection rules are blocking
