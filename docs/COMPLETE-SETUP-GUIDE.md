# Complete Setup Guide: Cursor Rules Central Repository

**Last Updated**: January 28, 2026  
**Status**: ✅ Tested and Working

---

## What This Is

A centralized repository of Cursor AI rules that automatically applies to all your projects. Rules are stored in one place, copied to projects via an automated script, and kept safe from accidental commits.

---

## Quick Start (10 Minutes)

### Step 1: Clone the Repository (One Time)

```powershell
# Clone to a permanent location (NOT inside customer projects)
cd C:\Users\YourName
git clone https://github.com/kitebish/cursor-rules-central.git
```

**Result**: `C:\Users\YourName\cursor-rules-central\`

---

### Step 2: Set Up a Project (2 Minutes Per Project)

```powershell
# Navigate to your project
cd C:\Projects\customer-a-frontend

# Run the setup script (use full path)
& "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"
```

**What this does**:

1. ✅ Copies `.cursor/rules/` to your project
2. ✅ Adds `.cursor/` to `.gitignore` (prevents commits)
3. ✅ Installs pre-commit hook (safety)
4. ✅ Done!

---

### Step 3: Open Project in Cursor

```powershell
cursor .
```

**Cursor automatically**:

- Detects `.cursor/rules/` directory
- Loads all `.mdc` rule files
- Applies rules to code generation

---

### Step 4: Test It Works

Create a new TypeScript file and ask Cursor:

```
"Create a function to fetch user data with error handling"
```

**Expected**: Code with TypeScript types, async/await, JSDoc comments, proper error handling

---

## What's Included

### Rule Files (in `.cursor/rules/`)

| File                   | Applies To       | Contains                       |
| ---------------------- | ---------------- | ------------------------------ |
| `global-standards.mdc` | All files        | Naming, security, git commits  |
| `typescript.mdc`       | `*.ts`, `*.tsx`  | Types, interfaces, async/await |
| `react.mdc`            | `*.jsx`, `*.tsx` | Hooks, components, performance |
| `python.mdc`           | `*.py`           | PEP 8, type hints, docstrings  |

### Scripts

| Script              | Purpose                              |
| ------------------- | ------------------------------------ |
| `setup-project.ps1` | Copy rules to project + safety setup |
| `verify-safety.ps1` | Test all safety mechanisms           |

---

## How It Works

### The Workflow

```
1. You clone cursor-rules-central ONCE
   └─> C:\Users\YourName\cursor-rules-central\

2. For each project, run setup script
   └─> Copies .cursor/rules/ to project
   └─> Adds safety mechanisms

3. Open project in Cursor
   └─> Cursor finds .cursor/rules/
   └─> Loads all .mdc files
   └─> Rules apply automatically
```

### File Structure After Setup

```
Your Project:
├── .cursor/
│   └── rules/              ← Copied from central repo
│       ├── global-standards.mdc
│       ├── typescript.mdc
│       ├── react.mdc
│       └── python.mdc
├── .gitignore              ← Updated (blocks .cursor/)
├── .git/
│   └── hooks/
│       └── pre-commit      ← Installed (blocks commits)
└── src/
    └── (your code)
```

---

## Safety System (5 Layers)

### Layer 1: .gitignore in Project

```gitignore
# Cursor AI Configuration (DO NOT COMMIT)
.cursor/
*.mdc
.cursorrules
```

### Layer 2: Pre-commit Hook

Actively blocks commits containing cursor files.

### Layer 3: Verification Script

```powershell
# Test all safety layers
& "C:\Users\YourName\cursor-rules-central\scripts\verify-safety.ps1"
```

### Layer 4: .gitignore in Central Repo

Prevents accidentally committing to central repo.

### Layer 5: Team Training

Monthly reminders and reviews.

---

## Updating Rules

### Pull Latest Changes

```powershell
# Update central repository
cd C:\Users\YourName\cursor-rules-central
git pull
```

### Apply to Existing Projects

```powershell
# Navigate to project
cd C:\Projects\customer-a-frontend

# Run setup script again (overwrites old rules)
& "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"
```

The script will copy the updated rules to your project.

---

## Common Scenarios

### New Developer Onboarding

```powershell
# 1. Clone central repo
cd ~
git clone https://github.com/kitebish/cursor-rules-central.git

# 2. For each project they work on
cd C:\Projects\project-name
& "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"

# 3. Open in Cursor
cursor .
```

**Time**: ~10 minutes total

---

### New Project Setup

```powershell
# 1. Create/clone project
cd C:\Projects
git clone https://github.com/customer/new-project.git
cd new-project

# 2. Run setup
& "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"

# 3. Open in Cursor
cursor .
```

**Time**: ~2 minutes

---

### Verify Safety Before Pushing

```powershell
# In your project directory
& "C:\Users\YourName\cursor-rules-central\scripts\verify-safety.ps1"
```

**Expected Output**:

```
[Test 1/3] Project .gitignore... ✅ PASS
[Test 2/3] Pre-commit hook... ✅ PASS
[Test 3/3] Testing actual commit block... ✅ PASS

All critical tests passed! ✅
```

---

## Troubleshooting

### Script Won't Run

**Error**: "cannot be loaded because running scripts is disabled"

**Fix**:

```powershell
& "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"
```

Or:

```powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"
```

---

### Rules Not Loading in Cursor

**Check 1**: Verify `.cursor/rules/` exists in project

```powershell
dir .cursor\rules
```

**Check 2**: Restart Cursor completely (close and reopen)

**Check 3**: Check active rules in Cursor

- Press `Ctrl+Shift+P`
- Type: "Cursor: Show Active Rules"

---

### Accidentally Committed Cursor Files

**If you catch it before pushing**:

```powershell
# Undo the commit
git reset HEAD~1

# Remove from staging
git restore --staged .cursor/

# Commit again
git commit -m "Your message"
```

**If already pushed**:

```powershell
# Remove from Git history
git rm -r --cached .cursor/
git commit -m "Remove cursor files"
git push
```

---

## Advanced Usage

### Create Alias for Easy Access

Add to PowerShell profile (`notepad $PROFILE`):

```powershell
function Setup-CursorRules {
    & "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"
}

Set-Alias -Name cursor-setup -Value Setup-CursorRules
```

Then from any project:

```powershell
cursor-setup
```

---

### Add New Language Rules

1. Create new `.mdc` file in `cursor-rules-central\.cursor\rules\`
2. Add YAML frontmatter:

```yaml
---
description: Java coding standards
globs:
  - "**/*.java"
alwaysApply: false
---
```

3. Add your rules in Markdown
4. Commit and push
5. Run setup script in projects to get new rules

---

## Best Practices

### ✅ DO

- Clone `cursor-rules-central` to a permanent location
- Run `setup-project.ps1` for each new project
- Run `verify-safety.ps1` before pushing to customer repos
- Pull updates from central repo monthly
- Keep rules focused and actionable

### ❌ DON'T

- Don't clone `cursor-rules-central` inside customer projects
- Don't manually copy `.cursor/` folders
- Don't commit `.cursor/` to customer repositories
- Don't use `--no-verify` to bypass pre-commit hooks
- Don't make rules too long (keep under 500 lines)

---

## File Reference

### Central Repository Structure

```
cursor-rules-central/
├── .cursor/
│   └── rules/
│       ├── global-standards.mdc    ← Always active
│       ├── typescript.mdc          ← For .ts/.tsx
│       ├── react.mdc               ← For React
│       └── python.mdc              ← For .py
│
├── scripts/
│   ├── setup-project.ps1           ← Project setup
│   └── verify-safety.ps1           ← Safety check
│
├── docs/
│   ├── GETTING-STARTED.md          ← Quick start
│   └── GITHUB-SETUP.md             ← GitHub guide
│
├── .gitignore                      ← Safety
└── README.md                       ← Overview
```

---

## Support

### Questions?

1. Check this guide first
2. Check `docs/GETTING-STARTED.md`
3. Run `verify-safety.ps1` to diagnose issues
4. Ask team lead

### Contributing

1. Create branch: `git checkout -b improve-typescript-rules`
2. Make changes to `.mdc` files
3. Test with a project
4. Create Pull Request
5. Team reviews and merges

---

## Summary

**One-Time Setup**:

1. Clone `cursor-rules-central` to permanent location

**Per Project** (2 minutes):

1. Run `setup-project.ps1`
2. Open in Cursor
3. Done!

**Result**:

- ✅ Consistent AI code generation
- ✅ Safe from accidental commits
- ✅ Easy to update
- ✅ Team-wide standards

---

**Version**: 1.0.0  
**Last Tested**: January 28, 2026  
**Status**: Production Ready ✅
