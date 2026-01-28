# Cross-Platform Compatibility

## Script Compatibility

### Windows

- **Setup**: `setup-project.ps1` (PowerShell)
- **Verify**: `verify-safety.ps1` (PowerShell)
- **Pre-commit hook**: Works (uses Git Bash)

### Mac/Linux

- **Setup**: `setup-project.sh` (Bash)
- **Verify**: `verify-safety.sh` (Bash)
- **Pre-commit hook**: Works (native bash)

---

## Usage by Platform

### Windows (PowerShell)

```powershell
# Setup
cd your-project
& path\to\cursor-rules-central\scripts\setup-project.ps1

# Verify
& path\to\cursor-rules-central\scripts\verify-safety.ps1
```

### Mac/Linux (Bash)

```bash
# Setup
cd your-project
bash path/to/cursor-rules-central/scripts/setup-project.sh

# Verify
bash path/to/cursor-rules-central/scripts/verify-safety.sh
```

Or make executable and run directly:

```bash
# Make executable (one-time)
chmod +x path/to/cursor-rules-central/scripts/setup-project.sh
chmod +x path/to/cursor-rules-central/scripts/verify-safety.sh

# Run
cd your-project
../cursor-rules-central/scripts/setup-project.sh
../cursor-rules-central/scripts/verify-safety.sh
```

---

## What Works Cross-Platform

### Pre-commit Hook (Works Everywhere)

The pre-commit hook is a **shell script** that works on all platforms:

- Windows: Uses Git Bash (included with Git for Windows)
- Mac/Linux: Uses native bash

### Rules Files (Work Everywhere)

The `.cursor/rules/*.mdc` files work on all platforms - Cursor reads them the same way.

### Git (Works Everywhere)

Git commands work identically across platforms.

---

## File Structure

```
cursor-rules-central/
└── scripts/
    ├── setup-project.ps1      # Windows (PowerShell)
    ├── setup-project.sh       # Mac/Linux (Bash)
    ├── verify-safety.ps1      # Windows (PowerShell)
    └── verify-safety.sh       # Mac/Linux (Bash)
```

---

## Key Differences

### Path Separators

- **Windows**: Backslash `\`
- **Mac/Linux**: Forward slash `/`

Both scripts handle this automatically.

### Line Endings

- **Windows**: CRLF (`\r\n`)
- **Mac/Linux**: LF (`\n`)

Git handles this automatically with `.gitattributes`.

### Script Execution

- **Windows**: `& script.ps1`
- **Mac/Linux**: `bash script.sh` or `./script.sh`

---

## Testing Cross-Platform

### On Windows

```powershell
# Test PowerShell script
cd test-project
& ..\cursor-rules-central\scripts\setup-project.ps1
& ..\cursor-rules-central\scripts\verify-safety.ps1
```

### On Mac/Linux

```bash
# Test Bash script
cd test-project
bash ../cursor-rules-central/scripts/setup-project.sh
bash ../cursor-rules-central/scripts/verify-safety.sh
```

---

## Recommendation

**For teams with mixed platforms**:

- Keep both `.ps1` and `.sh` versions
- Document which to use in README
- Pre-commit hook works for everyone (no changes needed)

**For Windows-only teams**:

- Use `.ps1` scripts only
- Pre-commit hook still works

**For Mac/Linux-only teams**:

- Use `.sh` scripts only
- Pre-commit hook still works

---

## Summary

| Component       | Windows | Mac/Linux | Notes                       |
| --------------- | ------- | --------- | --------------------------- |
| Setup script    | `.ps1`  | `.sh`     | Platform-specific           |
| Verify script   | `.ps1`  | `.sh`     | Platform-specific           |
| Pre-commit hook | Works   | Works     | Same file, works everywhere |
| Rules files     | Works   | Works     | Same files, work everywhere |
| Git commands    | Works   | Works     | Identical across platforms  |

**Bottom line**: We provide both PowerShell and Bash versions. The pre-commit hook and rules work everywhere without changes.
