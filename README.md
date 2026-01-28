# Cursor Rules Central Repository

**Complete, production-ready Cursor AI rules for consistent code generation across all projects.**

> ⚠️ **IMPORTANT**: This repository uses the correct `.mdc` format in `.cursor/rules/` directory as per Cursor's official documentation (2024+).

---

## 📁 Repository Structure

```
cursor-rules-central/
├── .cursor/
│   └── rules/                     ← Cursor rules (proper format)
│       ├── global-standards.mdc   ← Always active
│       ├── typescript.mdc         ← For .ts/.tsx files
│       ├── react.mdc              ← For React components
│       └── python.mdc             ← For .py files
│
├── scripts/
│   ├── setup-project.ps1          ← Per-project setup (Windows)
│   └── verify-safety.ps1          ← Safety verification (Windows)
│
├── docs/
│   └── GETTING-STARTED.md         ← Quick start guide
│
├── .gitignore                     ← Prevents committing sensitive files
└── README.md                      ← You are here
```

---

## 🚀 Quick Start (5 Minutes)

### Step 1: Clone This Repository

```bash
# Clone to a permanent location
git clone https://github.com/your-org/cursor-rules-central.git
cd cursor-rules-central
```

### Step 2: Open in Cursor

```bash
# Open this repository in Cursor
cursor .
```

**That's it!** Cursor will automatically detect and load the rules from `.cursor/rules/`.

---

## 📖 How It Works

### Automatic Rule Loading

Cursor automatically loads rules from `.cursor/rules/` when you open a project. Rules are applied based on:

1. **`alwaysApply: true`** - Rule always active (e.g., global-standards.mdc)
2. **`globs` patterns** - Rule applies to matching files (e.g., `**/*.ts` for TypeScript)
3. **AI intelligence** - Cursor's AI decides relevance

### Example: TypeScript File

When you edit `src/utils/api.ts`:

```
Cursor loads:
1. global-standards.mdc    (alwaysApply: true)
2. typescript.mdc          (globs: **/*.ts)

Result: AI follows both global AND TypeScript rules
```

### Example: React Component

When you edit `src/components/UserCard.tsx`:

```
Cursor loads:
1. global-standards.mdc    (alwaysApply: true)
2. typescript.mdc          (globs: **/*.tsx)
3. react.mdc               (globs: **/*.tsx, **/components/**)

Result: AI follows global + TypeScript + React rules
```

---

## 🛡️ Safety System

### The Problem

**CRITICAL**: Cursor rules often contain company-specific information and should NEVER be committed to customer repositories.

### The Solution: Multi-Layer Protection

This repository includes safety mechanisms to prevent accidental commits:

#### Layer 1: .gitignore

```gitignore
# In each project's .gitignore
.cursor/
*.mdc
```

#### Layer 2: Pre-commit Hook

Automatically installed by `setup-project.ps1`, blocks commits containing cursor files.

#### Layer 3: Verification Script

Run `verify-safety.ps1` to test all safety layers.

---

## 🔧 Setting Up Projects

### For New Projects

```powershell
# Navigate to your project
cd C:\Projects\customer-project

# Run setup script
C:\path\to\cursor-rules-central\scripts\setup-project.ps1
```

**What this does**:

1. Adds `.cursor/` to `.gitignore`
2. Installs pre-commit hook
3. Verifies safety mechanisms

### For Existing Projects

Same process - the script is safe to run multiple times.

---

## 📝 Available Rules

### Global Standards (Always Active)

- Naming conventions
- Code organization
- Security best practices
- Git commit messages
- Testing guidelines

### TypeScript (_.ts, _.tsx)

- Type system best practices
- Modern TypeScript features
- Null safety
- Generics and utility types
- JSDoc documentation

### React (_.jsx, _.tsx, components/\*\*)

- Functional components with hooks
- Custom hooks patterns
- Props and state management
- Performance optimization
- Component organization

### Python (\*.py)

- PEP 8 compliance
- Type hints
- Docstrings
- Error handling
- Async/await patterns

---

## 🎯 Using the Rules

### In Cursor Chat

Ask Cursor to generate code:

```
You: "Create a UserCard component that displays user name and email"

Cursor: [Generates React component following all applicable rules]
```

### In Code Editor

Start typing and Cursor will suggest code that follows the rules automatically.

### Checking Active Rules

In Cursor:

1. Open Command Palette (Ctrl+Shift+P)
2. Type: "Cursor: Show Active Rules"
3. See which rules are currently loaded

---

## 🔄 Updating Rules

### Pull Latest Changes

```bash
cd cursor-rules-central
git pull
```

Restart Cursor to apply updates.

### Proposing Changes

1. Fork this repository
2. Create a branch: `git checkout -b improve-typescript-rules`
3. Edit `.cursor/rules/*.mdc` files
4. Submit Pull Request
5. Team reviews and merges

---

## 📊 Rule File Format

Rules use `.mdc` (Markdown Cursor) format with YAML frontmatter:

```markdown
---
description: Brief description of what this rule does
globs:
  - "**/*.ts"
  - "**/*.tsx"
alwaysApply: false
---

# Rule Content

Your rules in Markdown format with examples...
```

### Frontmatter Fields

- **description**: Short description (shown in Cursor UI)
- **globs**: File patterns to match (optional)
- **alwaysApply**: `true` = always active, `false` = AI decides (default: false)

---

## 🆘 Troubleshooting

### Rules Not Loading?

1. **Check file location**: Must be in `.cursor/rules/`
2. **Check file extension**: Must be `.mdc`
3. **Check frontmatter**: Must have valid YAML between `---`
4. **Restart Cursor**: Close and reopen completely

### Rules Not Applying?

1. **Check globs pattern**: Make sure it matches your files
2. **Check alwaysApply**: Set to `true` if rule should always apply
3. **Ask Cursor**: "What rules are you following?" in chat

### Safety Verification Failing?

```powershell
# Run verification script
.\scripts\verify-safety.ps1

# Fix issues by running setup again
.\scripts\setup-project.ps1
```

---

## 📚 Documentation

- **[Getting Started Guide](./docs/GETTING-STARTED.md)** - Detailed setup instructions
- **[Rule Writing Guide](./docs/WRITING-RULES.md)** - How to create effective rules
- **[Troubleshooting](./docs/TROUBLESHOOTING.md)** - Common issues and solutions

---

## 🤝 Contributing

1. Read existing rules to understand the style
2. Keep rules focused and actionable
3. Include examples for complex rules
4. Test rules before submitting PR
5. Update CHANGELOG.md

---

## 📜 License

Internal use only. © 2026 Your Company Name.

---

## 🎯 Quick Reference

| Action             | Command                                                          |
| ------------------ | ---------------------------------------------------------------- |
| Clone repo         | `git clone https://github.com/your-org/cursor-rules-central.git` |
| Open in Cursor     | `cursor .`                                                       |
| Setup project      | `.\scripts\setup-project.ps1`                                    |
| Verify safety      | `.\scripts\verify-safety.ps1`                                    |
| Update rules       | `git pull`                                                       |
| Check active rules | Cursor: Ctrl+Shift+P → "Show Active Rules"                       |

---

**Version**: 1.0.0  
**Last Updated**: 2026-01-28  
**Format**: Cursor .mdc (official format)
