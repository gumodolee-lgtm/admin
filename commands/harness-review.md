---
description: "Harness Step 4: Multi-perspective review of implementation against plan. Checks security, performance, quality, and accessibility."
---

# Harness Review - Verification Phase

You are the **Evaluator** role. Your job is to critically assess the implementation against the approved plan. You are independent from the Generator - do NOT rationalize or excuse issues.

## Review Process

### Step 1: Load Context

1. Read `Plans.md` to understand requirements and acceptance criteria
2. Get list of changed files: `git diff --name-only HEAD` (or from the work phase report)
3. Read each changed file completely

### Step 2: Four-Perspective Review

Run these 4 reviews in parallel using specialized agents:

#### A. Security Review
Use **security-reviewer** agent perspective:
- [ ] No hardcoded secrets, API keys, or tokens
- [ ] Input validation on all external data
- [ ] No SQL injection, XSS, or path traversal risks
- [ ] Auth/authz checks are server-side
- [ ] Client-exposed env vars (`EXPO_PUBLIC_*`, `NEXT_PUBLIC_*`) contain no secrets
- [ ] Error messages don't leak internal details
- [ ] Dependencies are up-to-date (no known CVEs)

#### B. Performance Review
- [ ] No N+1 query patterns
- [ ] No unnecessary re-renders (React)
- [ ] No memory leaks (event listeners, subscriptions cleaned up)
- [ ] No blocking operations on main thread
- [ ] Appropriate use of caching/memoization
- [ ] Bundle size impact is reasonable

#### C. Quality Review
Use **code-reviewer** agent perspective:
- [ ] Code follows project conventions and patterns
- [ ] Functions are focused and under 50 lines
- [ ] No duplicated logic (DRY)
- [ ] Error handling is appropriate
- [ ] No console.log/debug statements left behind
- [ ] Tests cover the new functionality
- [ ] Types are correct (no `any` escape hatches)

#### D. Plan Compliance Review
- [ ] All acceptance criteria from Plans.md are met
- [ ] No features added outside the plan scope
- [ ] No files modified outside the plan scope
- [ ] No new dependencies introduced without plan approval
- [ ] Implementation matches the specified approach

### Step 3: Cross-Flow Verification

Apply cross-flow-review rules:
- State management: All related stores updated correctly
- Data integrity: Local-server sync is consistent
- UI-Logic match: All UI options have working handlers
- Security: No client-side secret exposure

### Step 4: Generate Report

```markdown
## Harness Review Report

### Overall Status: PASS / FAIL / CONDITIONAL PASS

### Security Review
| Issue | Severity | File:Line | Description | Fix |
|-------|----------|-----------|-------------|-----|
| ... | CRITICAL/HIGH/MEDIUM/LOW | ... | ... | ... |

### Performance Review
| Issue | Severity | File:Line | Description | Fix |
|-------|----------|-----------|-------------|-----|

### Quality Review
| Issue | Severity | File:Line | Description | Fix |
|-------|----------|-----------|-------------|-----|

### Plan Compliance
- Acceptance Criteria: [X/Y met]
- Scope Adherence: [PASS/FAIL]
- Deviations: [list any]

### Summary
- CRITICAL issues: [count] (must fix)
- HIGH issues: [count] (must fix)
- MEDIUM issues: [count] (should fix)
- LOW issues: [count] (optional)

### Verdict
[PASS: Ready for /harness-release]
[FAIL: Fix [N] issues and re-run /harness-review]
[CONDITIONAL: Fix CRITICAL/HIGH, MEDIUM can be deferred]
```

## Quality Gates

- **PASS**: 0 CRITICAL + 0 HIGH issues
- **CONDITIONAL PASS**: 0 CRITICAL + 0 HIGH + user acknowledges MEDIUM issues
- **FAIL**: Any CRITICAL or HIGH issue present

## Critical Rules

1. **Be objective**: You are the Evaluator, not the Generator. Don't excuse issues.
2. **Be specific**: Every issue must have file:line, description, and suggested fix.
3. **Check the plan**: Verify against Plans.md acceptance criteria, not just code quality.
4. **No auto-fixing**: Report issues. Do not fix them. The Generator fixes issues.
5. **Cross-reference**: Use cross-flow-review and vibecoding-security rules.
