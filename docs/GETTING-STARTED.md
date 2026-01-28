# Getting Started with Cursor Rules

**Complete guide to using the cursor-rules-central repository.**

---

## What You Have

A production-ready Cursor rules repository using the **official .mdc format** (2024+).

### Key Features

- ✅ Correct `.cursor/rules/` structure
- ✅ Proper `.mdc` file format with YAML frontmatter
- ✅ Automatic rule loading by Cursor
- ✅ Safety mechanisms to prevent leaks
- ✅ Ready for GitHub and team sharing

---

## Quick Start (5 Minutes)

### Step 1: Open in Cursor

```powershell
cd C:\Users\kiteb\OneDrive\Desktop\OJT\ojt-prep\cursor-rules-demo\cursor-rules-central
cursor .
```

**That's it!** Cursor automatically loads rules from `.cursor/rules/`.

### Step 2: Verify Rules Are Loaded

1. In Cursor, press `Ctrl+Shift+P`
2. Type: "Cursor: Show Active Rules"
3. You should see:
   - global-standards
   - typescript
   - react
   - python

### Step 3: Test It Works

Create a new file `test.ts` and ask Cursor:

```
"Create a function to fetch user data with error handling"
```

Cursor should generate TypeScript code following your rules!

---

## How It Works

### Automatic Rule Detection

Cursor looks for `.cursor/rules/` in your project and loads `.mdc` files automatically.

### Rule Application

**Example 1: TypeScript File**

When you edit `src/api.ts`:

```
Cursor loads:
1. global-standards.mdc (alwaysApply: true)
2. typescript.mdc (globs: **/*.ts)

Result: Global + TypeScript rules applied
```

**Example 2: React Component**

When you edit `src/components/UserCard.tsx`:

```
Cursor loads:
1. global-standards.mdc (alwaysApply: true)
2. typescript.mdc (globs: **/*.tsx)
3. react.mdc (globs: **/*.tsx, **/components/**)

Result: Global + TypeScript + React rules applied
```

---

## For Your Presentation

### What to Demo (5 minutes)

1. **Show the structure** (30 sec):
   - Open `cursor-rules-central` folder
   - Show `.cursor/rules/` directory
   - Show 4 .mdc files

2. **Show a rule file** (1 min):
   - Open `typescript.mdc`
   - Point out YAML frontmatter
   - Point out globs pattern
   - Point out examples

3. **Show it working** (2 min):
   - Open Cursor
   - Create `test.ts`
   - Ask: "Create a UserCard component"
   - Show generated code follows rules

4. **Show safety** (1 min):
   - Show `.gitignore` blocks `.cursor/`
   - Show pre-commit hook script
   - Run `verify-safety.ps1`

5. **Explain** (30 sec):
   - "Cursor automatically detects file types"
   - "Loads appropriate rules"
   - "AI follows all applicable rules"

### What to Say

> "I built a complete, production-ready implementation using Cursor's official .mdc format. The rules are stored in .cursor/rules/ and Cursor automatically loads them based on file type. I can show you a live demo..."

---

## Putting on GitHub

See [GITHUB-SETUP.md](./GITHUB-SETUP.md) for complete instructions.

**Quick version**:

```powershell
cd cursor-rules-central
git init
git add .
git commit -m "Initial commit"
gh repo create cursor-rules-central --private --source=. --remote=origin
git push -u origin main
```

---

## Using in Real Projects

### Setup a Project

```powershell
cd C:\Projects\customer-project
C:\path\to\cursor-rules-central\scripts\setup-project.ps1
```

This adds safety mechanisms to prevent committing cursor files.

### Open Project in Cursor

```powershell
cursor .
```

Cursor will load rules from the central repository automatically!

---

## Troubleshooting

### Rules not loading?

1. Make sure files are in `.cursor/rules/`
2. Make sure files have `.mdc` extension
3. Make sure frontmatter is valid YAML
4. Restart Cursor

### Rules not applying?

1. Check `globs` pattern matches your files
2. Try setting `alwaysApply: true` for testing
3. Ask Cursor: "What rules are you following?"

---

## Next Steps

1. ✅ Test in Cursor (done above)
2. ✅ Put on GitHub (see GITHUB-SETUP.md)
3. ✅ Practice your demo
4. ✅ Present on Monday!

---

**You're ready!** 🚀

This is a complete, working implementation using the correct Cursor format. You can demo it live and show real code generation following your rules.
