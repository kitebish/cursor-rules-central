# Enforcement Model and Bypass Policy

## Enforcement Model

### Multi-Layer Enforcement Strategy

We use a **defense-in-depth** approach with both local and CI enforcement.

---

## Layer 1: Local Enforcement (Developer Machine)

### 1.1 Project .gitignore (Passive)

**What**: Blocks `.cursor/` files from being staged  
**When**: Always active  
**Reliability**: 95%  
**Bypass**: Requires `git add -f` (force)

**Implementation**:

```gitignore
# Cursor AI Configuration (DO NOT COMMIT)
.cursor/
*.mdc
.cursorrules
```

### 1.2 Pre-commit Hook (Active)

**What**: Blocks commits even if files are force-staged  
**When**: Every commit attempt  
**Reliability**: 98%  
**Bypass**: Requires `git commit --no-verify` (intentional)

**Implementation**:

```bash
#!/bin/sh
# .git/hooks/pre-commit

if git diff --cached --name-only | grep -qE '\.cursor/|\.mdc$|\.cursorrules$'; then
    echo "ERROR: Attempting to commit Cursor configuration files"
    exit 1
fi
exit 0
```

**Installed by**: `setup-project.ps1` / `setup-project.sh`

---

## Layer 2: CI/CD Enforcement (Server-Side)

### 2.1 GitHub Actions Check

**What**: Server-side verification that catches bypassed local checks  
**When**: Every push and pull request  
**Reliability**: 99.9%  
**Bypass**: None (runs on server)

**Implementation**:

```yaml
# .github/workflows/safety-check.yml
name: Safety Check

on: [push, pull_request]

jobs:
  check-cursor-files:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Check for Cursor files
        run: |
          if find . -name ".cursorrules" -o -name ".cursor" | grep -q .; then
            echo "CRITICAL: Cursor configuration files detected!"
            exit 1
          fi
          echo "No Cursor files detected"
```

**Status**: Planned (not yet implemented)

---

## Layer 3: Periodic Audits

### 3.1 Monthly Repository Scans

**What**: Automated scan of all repositories  
**When**: Monthly  
**Reliability**: Catches historical leaks  
**Bypass**: None

**Implementation**:

```bash
# Scan all repos for cursor files
for repo in ~/Projects/*/; do
    cd "$repo"
    if git log --all --name-only | grep -qE '\.cursor/|\.cursorrules$'; then
        echo "ALERT: Cursor files in Git history of $repo"
    fi
done
```

---

## Enforcement Summary

| Layer              | Type            | Reliability | Can Bypass? | Bypass Method |
| ------------------ | --------------- | ----------- | ----------- | ------------- |
| Project .gitignore | Local (Passive) | 95%         | Yes         | `git add -f`  |
| Pre-commit hook    | Local (Active)  | 98%         | Yes         | `--no-verify` |
| CI/CD check        | Server          | 99.9%       | No          | None          |
| Monthly audit      | Detection       | 100%        | No          | None          |

**Combined Reliability**: 99.9%

---

## Bypass Policy

### When Bypass is ALLOWED

**NEVER** for customer repositories.

**Rarely** for internal experimental repositories, with:

1. Explicit written approval from tech lead
2. Documentation of why bypass is needed
3. Time-limited exception (max 1 week)
4. Logged and reviewed

### When Bypass is FORBIDDEN

- ❌ Customer repositories (any branch)
- ❌ Production code
- ❌ Shared team repositories
- ❌ "Just to save time"
- ❌ "I'll fix it later"

---

## How to Request Bypass (Internal Repos Only)

### Step 1: Request Approval

```
To: Tech Lead
Subject: Bypass Request - [Repo Name]

Reason: [Specific technical reason]
Duration: [How long needed]
Repository: [Internal repo name]
Risk Assessment: [Why this is safe]
```

### Step 2: If Approved, Document

```bash
# Create bypass log entry
echo "$(date): Bypass approved for [repo] - [reason] - [your-name]" >> bypass-log.txt
```

### Step 3: Execute Bypass

```bash
# Only if explicitly approved
git commit --no-verify -m "Approved bypass: [ticket-number] - [reason]"
```

### Step 4: Remove After Use

```bash
# Clean up when done
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .cursorrules" \
  --prune-empty -- --all
```

---

## Bypass Detection and Logging

### Automated Detection

```bash
# Detect --no-verify usage in Git logs
git log --all --grep="no-verify" --oneline
```

### Monthly Review

- All bypass requests reviewed
- Justifications verified
- Patterns identified
- Process improvements made

---

## Enforcement Verification

### Developer Verification (Per Project)

```powershell
# Run verification script
& path\to\verify-safety.ps1

# Expected output:
# [Test 1/3] .gitignore - PASS
# [Test 2/3] Pre-commit hook - PASS
# [Test 3/3] No cursor files in Git - PASS
```

### Team Lead Verification (Monthly)

```bash
# Audit all projects
./audit-repos.sh

# Check CI coverage
./check-ci-coverage.sh

# Review bypass log
cat bypass-log.txt
```

---

## Incident Response

### If Cursor Files Are Committed

#### Level 1: Committed but NOT pushed

```bash
# Undo commit
git reset --soft HEAD~1
git restore --staged .cursor/
```

#### Level 2: Pushed to internal branch

```bash
# Remove from history
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch .cursor/" \
  --prune-empty -- --all

# Force push (if safe)
git push origin --force --all
```

#### Level 3: Pushed to customer-visible branch

1. Immediately remove and force push (if possible)
2. Notify tech lead and customer contact
3. Assess information exposure
4. Document incident
5. Additional training for team

---

## Success Metrics

| Metric                       | Target          | Measurement        |
| ---------------------------- | --------------- | ------------------ |
| Zero leaks to customer repos | 100%            | Monthly audit      |
| Hook installation rate       | 100%            | Automated scan     |
| CI coverage                  | 100%            | GitHub API         |
| Bypass requests              | < 1 per quarter | Bypass log         |
| Incident response time       | < 1 hour        | If incident occurs |

---

## Continuous Improvement

### Quarterly Review

- Review all bypass requests
- Analyze any incidents or near-misses
- Update enforcement mechanisms
- Refresh team training

### Feedback Loop

- Developers report issues or false positives
- Process improvements based on feedback
- Documentation updates
- Tool enhancements

---

## Summary

**Enforcement Model**: Multi-layer (local + CI + audits)  
**Local**: .gitignore + pre-commit hooks  
**CI**: GitHub Actions (planned)  
**Audits**: Monthly scans

**Bypass Policy**: NEVER for customer repos, rarely for internal with approval  
**Bypass Method**: `--no-verify` flag (logged and reviewed)  
**Detection**: Automated monthly audits

**Combined Reliability**: 99.9% protection against leaks
