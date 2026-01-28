# Project Onboarding Instructions

## How to Set Up Cursor Rules in Your Project

Follow these steps to add Cursor rules to your project.

---

## Prerequisites

- Git repository initialized (`git init`)
- PowerShell (Windows)
- Access to `cursor-rules-central` repository

---

## Step-by-Step Setup

### 1. Navigate to Your Project

```powershell
cd C:\path\to\your\project
```

Example:

```powershell
cd C:\Projects\customer-acme-portal
```

### 2. Run the Setup Script

```powershell
& path\to\cursor-rules-central\scripts\setup-project.ps1
```

**The `&` (ampersand) is required** - it tells PowerShell to execute the script.

#### Example (if cursor-rules-central is in parent directory):

```powershell
& ..\cursor-rules-central\scripts\setup-project.ps1
```

#### Example (if cursor-rules-central is elsewhere):

```powershell
& C:\path\to\cursor-rules-central\scripts\setup-project.ps1
```

### 3. Verify Setup

The script will show:

```
[1/4] Checking Git repository... ✓
[2/4] Creating/updating .gitignore... ✓
[3/4] Copying .cursor/rules/... ✓
[4/4] Installing pre-commit hook... ✓

Setup Complete!
```

### 4. Verify Safety

```powershell
& path\to\cursor-rules-central\scripts\verify-safety.ps1
```

Expected output:

```
[Test 1/3] .gitignore... ✅ PASS
[Test 2/3] Pre-commit hook... ✅ PASS
[Test 3/3] No cursor files in Git... ✅ PASS

All Safety Checks Passed! ✅
```

### 5. Open Project in Cursor

```powershell
cursor .
```

Cursor will automatically load the rules!

---

## What the Script Does

1. **Checks Git repository** - Ensures you're in a Git project
2. **Creates/updates .gitignore** - Blocks `.cursor/` from being committed
3. **Copies rules** - Copies `.cursor/rules/` from central repo to your project
4. **Installs pre-commit hook** - Prevents accidental commits

---

## Quick Reference

### Setup Command Format:

```powershell
& <path-to-setup-script>
```

### Common Paths:

**If cursor-rules-central is in parent directory:**

```powershell
& ..\cursor-rules-central\scripts\setup-project.ps1
```

**If cursor-rules-central is in same parent as your project:**

```powershell
cd C:\Projects\my-project
& ..\cursor-rules-central\scripts\setup-project.ps1
```

**If cursor-rules-central is in a fixed location:**

```powershell
& C:\Dev\cursor-rules-central\scripts\setup-project.ps1
```

---

## Updating Rules

When rules are updated in the central repository:

```powershell
# 1. Pull latest rules
cd path\to\cursor-rules-central
git pull

# 2. Go to your project
cd C:\path\to\your\project

# 3. Re-run setup script
& path\to\cursor-rules-central\scripts\setup-project.ps1

# 4. Restart Cursor
cursor .
```

---

## Troubleshooting

### Error: "Cannot be loaded because running scripts is disabled"

**Solution**: Enable script execution (one-time setup)

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Error: "This is not a Git repository"

**Solution**: Initialize Git first

```powershell
git init
```

### Error: "Cannot find .cursor/rules/ in central repository"

**Solution**: Check the path to cursor-rules-central

```powershell
# Verify the path exists
Test-Path path\to\cursor-rules-central\scripts\setup-project.ps1
```

---

## Files Created in Your Project

After running setup, your project will have:

```
your-project/
├── .cursor/                 # Cursor rules (gitignored)
│   └── rules/
│       ├── global-standards.mdc
│       ├── typescript.mdc
│       ├── react.mdc
│       ├── python.mdc
│       ├── nodejs-express.mdc
│       └── project-specific-template.mdc
├── .git/
│   └── hooks/
│       └── pre-commit      # Safety hook (blocks commits)
└── .gitignore              # Updated with .cursor/
```

**Important**: `.cursor/` is gitignored and will NOT be committed!

---

## Summary

**Setup (one-time per project):**

```powershell
cd your-project
& path\to\cursor-rules-central\scripts\setup-project.ps1
```

**Update (when rules change):**

```powershell
cd cursor-rules-central
git pull
cd your-project
& path\to\cursor-rules-central\scripts\setup-project.ps1
```

**Verify:**

```powershell
& path\to\cursor-rules-central\scripts\verify-safety.ps1
```

---

**That's it! Your project now has Cursor rules with full safety protection.** ✅
