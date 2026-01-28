# Bypass Policy

## Rule

**NEVER bypass for customer repositories.**

## When Bypass is Allowed

Only for internal experimental repositories with:

- Written approval from tech lead
- Documented reason
- Time limit (max 1 week)

## How to Bypass

```bash
git commit --no-verify -m "Approved bypass: [ticket-number]"
```

## Logging

All bypasses are logged and reviewed monthly.

## Consequences

Unauthorized bypass to customer repo:

- Immediate incident response
- Mandatory retraining
- Process review
