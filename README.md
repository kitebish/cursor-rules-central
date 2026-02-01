## What This Does

Provides a single source of truth for Cursor AI rules that automatically applies to all your projects. Write rules once, use everywhere, update easily.

---

## Quick Start

### 1. Clone Repository (One Time)

```powershell
cd ~
git clone https://github.com/kitebish/cursor-rules-central.git
```

### 2. Setup a Project (2 Minutes)

```powershell
cd C:\Projects\your-project
& "C:\Users\YourName\cursor-rules-central\scripts\setup-project.ps1"
cursor .
```

### 3. Test It

Ask Cursor: _"Create a function to fetch user data"_

**Result**: Code following all your rules automatically! ✨

---

## What's Included

### 📋 Rule Files

- **global-standards.mdc** - Company-wide standards (always active)
- **typescript.mdc** - TypeScript types, interfaces, async/await
- **react.mdc** - React hooks, components, performance
- **python.mdc** - PEP 8, type hints, docstrings

### 🛠️ Scripts

- **setup-project.ps1** - Automated project setup (copies rules + safety)
- **verify-safety.ps1** - Tests all safety mechanisms

### 🛡️ Safety System

5 layers of protection prevent accidental commits:

1. Project `.gitignore`
2. Pre-commit hooks
3. Verification script
4. Central repo `.gitignore`
5. Team training

---

## How It Works

```
Central Repo (One Place)          Your Projects (Many)
┌─────────────────────┐          ┌──────────────────┐
│ cursor-rules-central│          │ customer-project │
│  └─ .cursor/rules/  │  ─────>  │  └─ .cursor/     │
│      ├─ global.mdc  │  Copy    │      └─ rules/   │
│      ├─ typescript  │          │         (copied) │
│      └─ react.mdc   │          └──────────────────┘
└─────────────────────┘
```

**The Magic**: Run `setup-project.ps1` → Rules copied → Cursor loads them → AI follows your standards

---

## Documentation

- **[Complete Setup Guide](./docs/COMPLETE-SETUP-GUIDE.md)** - Full documentation
- **[Getting Started](./docs/GETTING-STARTED.md)** - Quick start guide
- **[GitHub Setup](./docs/GITHUB-SETUP.md)** - GitHub deployment

---

## Features

✅ **Centralized** - One source of truth  
✅ **Automated** - One command setup  
✅ **Safe** - Multi-layer protection  
✅ **Flexible** - Language & framework specific  
✅ **Team-Ready** - Easy onboarding  
✅ **Version Controlled** - Git-based updates

---

## Common Commands

```powershell
# Setup new project
& "path\to\cursor-rules-central\scripts\setup-project.ps1"

# Verify safety
& "path\to\cursor-rules-central\scripts\verify-safety.ps1"

# Update central repo
cd cursor-rules-central
git pull

# Apply updates to project
cd your-project
& "path\to\setup-project.ps1"  # Re-run to update
```

---

## Requirements

- Windows 10/11 with PowerShell
- Git installed
- Cursor IDE
- GitHub account (for team sharing)

---

## Architecture

### Rule Format

Uses official Cursor `.mdc` format with YAML frontmatter:

```markdown
---
description: TypeScript coding standards
globs:
  - "**/*.ts"
  - "**/*.tsx"
alwaysApply: false
---

# TypeScript Rules

Your rules in Markdown...
```

### Directory Structure

```
cursor-rules-central/
├── .cursor/rules/       ← The rules (copied to projects)
├── scripts/             ← Automation scripts
├── docs/                ← Documentation
└── README.md            ← This file
```

---

## Safety First

**Critical**: Rules may contain company-specific information and must NEVER be committed to customer repositories.

**Protection**:

- ✅ Automatic `.gitignore` updates
- ✅ Pre-commit hooks block commits
- ✅ Verification script tests safety
- ✅ Clear documentation and training

**Test Safety**:

```powershell
& "cursor-rules-central\scripts\verify-safety.ps1"
```

---

## Team Usage

### New Developer Onboarding (10 minutes)

1. Clone `cursor-rules-central`
2. For each project: Run `setup-project.ps1`
3. Done!

### Updating Rules

1. Edit `.mdc` files in central repo
2. Commit and push
3. Team runs `git pull` + re-run `setup-project.ps1`

---

## Contributing

1. Create branch: `git checkout -b improve-rules`
2. Edit `.cursor/rules/*.mdc` files
3. Test with a project
4. Create Pull Request
5. Team reviews and merges

---

## Troubleshooting

**Rules not loading?**

- Check `.cursor/rules/` exists in project
- Restart Cursor completely
- Run `verify-safety.ps1`

**Script won't run?**

```powershell
& "path\to\setup-project.ps1"  # Use & before path
```

**See [Complete Setup Guide](./docs/COMPLETE-SETUP-GUIDE.md) for more help.**

---

## License

Internal use only. © 2026

---

## Version History

- **1.0.0** (2026-01-28) - Initial release
  - Global, TypeScript, React, Python rules
  - Automated setup scripts
  - Safety verification
  - Complete documentation

---

## Support

- 📖 [Complete Documentation](./docs/COMPLETE-SETUP-GUIDE.md)
- 🚀 [Getting Started](./docs/GETTING-STARTED.md)
- 🔧 [Troubleshooting](./docs/COMPLETE-SETUP-GUIDE.md#troubleshooting)

---

**Status**: ✅ Production Ready  
**Last Updated**: January 28, 2026  
**Tested**: Windows 11, Cursor IDE
