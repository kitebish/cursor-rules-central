# Setup Script - Auto-Configuration Features

## What Changed

The setup script is now **fully automated** - it handles everything for you!

---

## New Features

### 1. Auto-Initialize Git Repository ✨

**Before**: Script would error if no Git repo

```
ERROR: This is not a Git repository
Initialize Git first with: git init
```

**Now**: Script automatically initializes Git

```
No Git repository found. Initializing...
SUCCESS: Git repository initialized
```

### 2. Auto-Create .gitignore ✨

**Already worked**: Script creates `.gitignore` if it doesn't exist

```
SUCCESS: Created .gitignore with Cursor rules
```

### 3. Auto-Create .cursor Directory ✨

**Already worked**: Script creates `.cursor/` folder if needed

---

## What the Script Does Automatically

### Step 1: Git Repository

- ✅ Checks if `.git` exists
- ✅ If not: Runs `git init` automatically
- ✅ If yes: Continues

### Step 2: .gitignore File

- ✅ Checks if `.gitignore` exists
- ✅ If not: Creates it with Cursor rules
- ✅ If yes: Adds Cursor rules (if not already there)

### Step 3: .cursor Directory

- ✅ Checks if `.cursor` exists
- ✅ If not: Creates it
- ✅ Copies rules from central repo

### Step 4: Pre-commit Hook

- ✅ Checks if `.git/hooks` exists
- ✅ If not: Creates it
- ✅ Installs pre-commit hook

---

## Usage (Even Simpler Now!)

### For a Brand New Project (No Git, No Files):

```powershell
# 1. Create project folder
mkdir my-new-project
cd my-new-project

# 2. Run setup script - that's it!
& path\to\cursor-rules-central\scripts\setup-project.ps1
```

**The script handles everything**:

- Initializes Git
- Creates .gitignore
- Copies rules
- Installs hook

### For an Existing Project (Already has Git):

```powershell
# 1. Navigate to project
cd existing-project

# 2. Run setup script
& path\to\cursor-rules-central\scripts\setup-project.ps1
```

**The script handles everything**:

- Detects existing Git
- Updates or creates .gitignore
- Copies rules
- Installs hook

---

## What You'll See

### Brand New Project:

```
[1/4] Checking Git repository...
No Git repository found. Initializing...
Initialized empty Git repository in C:/Projects/my-project/.git/
SUCCESS: Git repository initialized

[2/4] Creating/updating .gitignore...
SUCCESS: Created .gitignore with Cursor rules

[3/4] Copying .cursor/rules/ from central repository...
SUCCESS: Copied 6 rule files to .cursor/rules/
NOTE: These files are gitignored and will NOT be committed

[4/4] Installing pre-commit hook...
SUCCESS: Installed pre-commit hook

========================================
Setup Complete!
========================================
```

### Existing Project:

```
[1/4] Checking Git repository...
SUCCESS: Git repository detected

[2/4] Creating/updating .gitignore...
SUCCESS: Added Cursor rules to existing .gitignore

[3/4] Copying .cursor/rules/ from central repository...
SUCCESS: Copied 6 rule files to .cursor/rules/
NOTE: These files are gitignored and will NOT be committed

[4/4] Installing pre-commit hook...
SUCCESS: Installed pre-commit hook

========================================
Setup Complete!
========================================
```

---

## Error Handling

### Only Possible Error: Git Not Installed

If Git is not installed on the system:

```
ERROR: Failed to initialize Git repository
Make sure Git is installed: git --version
```

**Solution**: Install Git

```powershell
# Check if Git is installed
git --version

# If not, download from: https://git-scm.com/download/win
```

---

## Summary

**Old Way** (Manual):

```powershell
mkdir project
cd project
git init                    # Manual
echo ".cursor/" > .gitignore  # Manual
& setup-project.ps1
```

**New Way** (Automatic):

```powershell
mkdir project
cd project
& setup-project.ps1         # Does everything!
```

---

## Benefits

✅ **Beginner-friendly** - No need to know Git commands  
✅ **Fewer errors** - Script handles edge cases  
✅ **Faster setup** - One command does everything  
✅ **Consistent** - Same process for all projects  
✅ **Safe** - Still maintains all safety features

---

**The script is now truly "one-command setup"!** 🎉
