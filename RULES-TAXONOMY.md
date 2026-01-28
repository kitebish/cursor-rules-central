# Cursor Rules Taxonomy

## Overview

This document defines the organization, naming strategy, and glob patterns for Cursor AI rules across all projects.

---

## Rules Hierarchy

### 1. Global Rules (Always Active)

**File**: `global-standards.mdc`

**Purpose**: Company-wide coding standards that apply to ALL files in ALL projects

**Glob Pattern**:

```yaml
globs:
  - "**/*"
alwaysApply: true
```

**Contains**:

- Code formatting standards
- Naming conventions
- Security best practices
- Git commit message format
- Documentation requirements

**When to use**: Standards that apply regardless of language or framework

---

### 2. Language-Specific Rules

**Files**:

- `typescript.mdc`
- `python.mdc`
- `react.mdc`

**Purpose**: Language-specific coding standards and best practices

**Glob Patterns**:

**TypeScript**:

```yaml
globs:
  - "**/*.ts"
  - "**/*.tsx"
alwaysApply: false
```

**Python**:

```yaml
globs:
  - "**/*.py"
alwaysApply: false
```

**React**:

```yaml
globs:
  - "**/*.jsx"
  - "**/*.tsx"
  - "**/components/**/*.ts"
  - "**/components/**/*.js"
alwaysApply: false
```

**Contains**:

- Language-specific syntax rules
- Type system usage
- Standard library patterns
- Testing conventions
- Error handling patterns

**When to use**: Rules specific to a programming language

---

### 3. Framework-Specific Rules

**Files**:

- `nodejs-express.mdc`

**Purpose**: Framework-specific patterns and best practices

**Glob Patterns**:

**Node.js/Express**:

```yaml
globs:
  - "**/server.js"
  - "**/app.js"
  - "**/routes/**/*.js"
  - "**/controllers/**/*.js"
  - "**/middleware/**/*.js"
alwaysApply: false
```

**Contains**:

- Framework architecture patterns
- Routing conventions
- Middleware patterns
- API design standards
- Security middleware

**When to use**: Rules specific to a framework or library

---

### 4. Project-Specific Rules (Gitignored)

**File**: `project-specific-template.mdc` (template only)

**Purpose**: Customer-specific context and requirements

**Glob Pattern**:

```yaml
globs:
  - "**/*"
alwaysApply: false
```

**Contains**:

- Customer name and context
- Business rules
- API endpoints
- Third-party integrations
- Team contacts
- Deployment info

**When to use**: Information unique to a specific customer project

**Important**: This file is gitignored and never committed to customer repos

---

## Naming Strategy

### File Naming Convention

**Format**: `{scope}-{type}.mdc`

**Examples**:

- `global-standards.mdc` - Global scope, standards type
- `typescript.mdc` - Language name
- `react.mdc` - Framework name
- `nodejs-express.mdc` - Runtime-framework combination
- `project-specific-template.mdc` - Project scope, template type

**Rules**:

- Use lowercase
- Use hyphens for multi-word names
- Use `.mdc` extension (Markdown with Cursor metadata)
- Be descriptive and specific

---

## Glob Strategy

### Glob Pattern Principles

1. **Be Specific**: Target exact file types or directories
2. **Use Double Star**: `**` for recursive matching
3. **Combine Patterns**: Multiple globs for comprehensive coverage
4. **Avoid Overlap**: Minimize rule conflicts between files

### Common Glob Patterns

**All files**:

```yaml
globs:
  - "**/*"
```

**Specific extension**:

```yaml
globs:
  - "**/*.ts"
  - "**/*.tsx"
```

**Specific directory**:

```yaml
globs:
  - "**/components/**/*"
  - "**/routes/**/*.js"
```

**Multiple patterns**:

```yaml
globs:
  - "**/*.ts"
  - "**/*.tsx"
  - "!**/*.test.ts" # Exclude test files
```

---

## Rule Application Order

When multiple rules match a file, Cursor applies them in this order:

1. **Global rules** (always applied first)
2. **Language-specific rules** (based on file extension)
3. **Framework-specific rules** (based on file path/name)
4. **Project-specific rules** (if present, applied last)

**Example**: For `src/routes/users.ts` in a Node.js project:

1. `global-standards.mdc` - Always applies
2. `typescript.mdc` - Matches `*.ts`
3. `nodejs-express.mdc` - Matches `routes/**/*.ts`
4. `project-specific.mdc` - If exists, applies last

---

## File Structure

```
.cursor/rules/
├── global-standards.mdc          # Layer 1: Global (always on)
├── typescript.mdc                # Layer 2: Language
├── python.mdc                    # Layer 2: Language
├── react.mdc                     # Layer 2: Language/Framework
├── nodejs-express.mdc            # Layer 3: Framework
└── project-specific-template.mdc # Layer 4: Project (gitignored)
```

---

## Adding New Rules

### When to Create a New Rule File

**Create a new language rule when**:

- Adding support for a new programming language
- Language has unique conventions

**Create a new framework rule when**:

- Team adopts a new framework
- Framework has specific patterns to enforce

**Create a new global rule when**:

- Standard applies to ALL projects
- Standard is language-agnostic

### Template for New Rules

```yaml
---
description: [Brief description of what this rule covers]
globs:
  - "[Pattern 1]"
  - "[Pattern 2]"
alwaysApply: [true/false]
---

# [Rule Name]

## [Section 1]
[Content]

## [Section 2]
[Content]
```

---

## Current Taxonomy Summary

| Level | Scope     | Files                                       | Glob Strategy             | Always On |
| ----- | --------- | ------------------------------------------- | ------------------------- | --------- |
| **1** | Global    | `global-standards.mdc`                      | `**/*`                    | Yes       |
| **2** | Language  | `typescript.mdc`, `python.mdc`, `react.mdc` | `**/*.{ext}`              | No        |
| **3** | Framework | `nodejs-express.mdc`                        | `**/routes/**/*.js`, etc. | No        |
| **4** | Project   | `project-specific.mdc`                      | `**/*`                    | No        |

---

## Best Practices

### DO:

- Keep global rules minimal and universal
- Use specific globs for language/framework rules
- Document why a rule exists
- Include examples in rule files
- Review rules quarterly

### DON'T:

- Put customer-specific info in global rules
- Overlap glob patterns unnecessarily
- Make rules too prescriptive
- Forget to update globs when adding new file types

---

## Maintenance

### Updating Rules

1. Edit rule file in `cursor-rules-central`
2. Commit and push changes
3. Teams run `setup-project.ps1` to update
4. Verify with `verify-safety.ps1`

### Versioning

- Use Git tags for major rule changes
- Document changes in CHANGELOG.md
- Announce breaking changes to team

---

**This taxonomy provides clear organization, naming consistency, and effective glob patterns for managing Cursor rules across all projects.**
