# How to Put This on GitHub

## Step 1: Initialize Git Repository

```powershell
# Navigate to the cursor-rules-central directory
cd C:\Users\kiteb\OneDrive\Desktop\OJT\ojt-prep\cursor-rules-demo\cursor-rules-central

# Initialize Git
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Cursor rules central repository"
```

---

## Step 2: Create GitHub Repository

### Option A: Via GitHub Website

1. Go to https://github.com
2. Click the "+" icon (top right) → "New repository"
3. Repository name: `cursor-rules-central`
4. Description: "Centralized Cursor AI rules for consistent code generation"
5. **IMPORTANT**: Set to **Private** (contains company-specific rules)
6. **DO NOT** initialize with README, .gitignore, or license
7. Click "Create repository"

### Option B: Via GitHub CLI

```powershell
# Install GitHub CLI if not already installed
winget install GitHub.cli

# Login to GitHub
gh auth login

# Create private repository
gh repo create cursor-rules-central --private --source=. --remote=origin
```

---

## Step 3: Push to GitHub

```powershell
# Add remote (replace YOUR-USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR-USERNAME/cursor-rules-central.git

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## Step 4: Verify Upload

1. Go to https://github.com/YOUR-USERNAME/cursor-rules-central
2. You should see:
   - `.cursor/rules/` directory with 4 .mdc files
   - `README.md`
   - `scripts/` directory
   - `.gitignore`

---

## Step 5: Clone to Permanent Location

Now that it's on GitHub, clone it to where you'll actually use it:

```powershell
# Navigate to your home directory
cd ~

# Create cursor-rules directory
mkdir cursor-rules
cd cursor-rules

# Clone from GitHub
git clone https://github.com/YOUR-USERNAME/cursor-rules-central.git

# Result: ~/cursor-rules/cursor-rules-central/
```

---

## Step 6: Open in Cursor

```powershell
# Navigate to the cloned repository
cd ~/cursor-rules/cursor-rules-central

# Open in Cursor
cursor .
```

**Cursor will automatically detect and load the rules!**

---

## Step 7: Test It Works

### Test 1: Check Rules Are Loaded

1. In Cursor, press `Ctrl+Shift+P`
2. Type: "Cursor: Show Active Rules"
3. You should see your rules listed

### Test 2: Generate Code

1. Create a new file: `test.ts`
2. In Cursor Chat, ask: "Create a function to fetch user data"
3. Cursor should generate TypeScript code following your rules

### Test 3: Verify Safety

```powershell
# Create a test project
cd ..
mkdir test-project
cd test-project
git init

# Run setup script
..\cursor-rules-central\scripts\setup-project.ps1

# Try to commit a cursor file (should be blocked)
echo "test" > .cursor-test
git add -f .cursor-test
git commit -m "test"
# Expected: Commit blocked!

# Clean up
git reset HEAD .cursor-test
del .cursor-test
```

---

## Step 8: Share with Team

### Give Team Access

1. Go to your GitHub repository
2. Click "Settings" → "Collaborators"
3. Add team members

### Team Members Clone

Each team member runs:

```powershell
cd ~
mkdir cursor-rules
cd cursor-rules
git clone https://github.com/YOUR-USERNAME/cursor-rules-central.git
cursor cursor-rules-central
```

---

## Updating Rules

### You Make Changes

```powershell
cd ~/cursor-rules/cursor-rules-central

# Edit rule files
code .cursor/rules/typescript.mdc

# Commit and push
git add .
git commit -m "Update TypeScript rules: add async/await examples"
git push
```

### Team Members Get Updates

```powershell
cd ~/cursor-rules/cursor-rules-central
git pull
# Restart Cursor to apply changes
```

---

## Important Notes

### Repository Visibility

**KEEP THIS REPOSITORY PRIVATE!**

Rules may contain:

- Company-specific conventions
- Internal terminology
- Architecture details
- Customer-specific information (in project-specific rules)

### What to Commit

✅ **DO commit**:

- `.cursor/rules/*.mdc` files
- `scripts/` directory
- `docs/` directory
- `README.md`
- `.gitignore`

❌ **DON'T commit**:

- Project-specific `.cursorrules` files
- `.env` files
- Sensitive data

### Branching Strategy

For rule changes:

```powershell
# Create feature branch
git checkout -b improve-react-rules

# Make changes
# ...

# Commit
git add .
git commit -m "Add React hooks best practices"

# Push
git push -u origin improve-react-rules

# Create Pull Request on GitHub
# Team reviews and merges
```

---

## Troubleshooting

### "Permission denied" when pushing

```powershell
# Use GitHub CLI to authenticate
gh auth login

# Or use Personal Access Token
# GitHub → Settings → Developer settings → Personal access tokens
# Create token with 'repo' scope
# Use token as password when pushing
```

### "Repository not found"

```powershell
# Check remote URL
git remote -v

# Update if wrong
git remote set-url origin https://github.com/YOUR-USERNAME/cursor-rules-central.git
```

### Rules not loading after clone

```powershell
# Make sure you're opening the repository in Cursor
cursor ~/cursor-rules/cursor-rules-central

# NOT just any project
```

---

## Summary

**You've successfully**:

1. ✅ Created Git repository
2. ✅ Pushed to GitHub (private)
3. ✅ Cloned to permanent location
4. ✅ Verified rules load in Cursor
5. ✅ Tested safety mechanisms
6. ✅ Ready to share with team

**Next steps**:

- Share repository link with team
- Have team members clone and test
- Start using in real projects!

---

**Questions?** Check the main README.md or create an issue on GitHub.
