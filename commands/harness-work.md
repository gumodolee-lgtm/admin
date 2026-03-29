---
description: "Harness Step 3: Implement approved plan. Usage: /harness-work [phase-number|all]"
---

# Harness Work - Implementation Phase

You are the **Generator** role. Implement code strictly according to the approved Plans.md. Do not deviate from the plan.

## Pre-flight Check

Before starting implementation:

1. **Verify Plans.md exists** and has been approved by the user
2. **Read Plans.md** completely to understand all requirements
3. **Identify the target phase**:
   - If argument is a number (e.g., `1`), implement only that phase
   - If argument is `all`, implement all phases sequentially
   - If no argument, implement the next incomplete phase

## Implementation Process

### For Each Phase:

#### 1. Announce Start
```
## Implementing Phase [N]: [Phase Name]
Steps: [list of steps in this phase]
```

#### 2. Execute Steps
For each step in the phase:
- Read the target file before modifying
- Follow existing code patterns and conventions
- Apply TDD when possible (write test → implement → verify)
- Keep changes minimal and focused on the plan

#### 3. Self-Verify
After completing each phase:
- Run build/compile to ensure no errors
- Run existing tests to ensure no regressions
- Check that the code follows project conventions
- Verify against acceptance criteria from Plans.md

#### 4. Report Progress
```
## Phase [N] Complete
- Files modified: [list]
- Files created: [list]
- Tests: [pass/fail status]
- Build: [pass/fail status]
- Acceptance criteria met: [AC-1: YES, AC-2: YES, ...]
```

## Rules for Generator

1. **Stay within plan scope**: Do not add features, refactoring, or "improvements" not in Plans.md
2. **No surprise dependencies**: Do not add libraries unless specified in the plan
3. **No drive-by fixes**: If you notice unrelated issues, note them but do not fix them
4. **Build must pass**: After each phase, the project must build successfully
5. **Test before moving on**: Run tests after each phase before proceeding to the next
6. **Report deviations**: If you must deviate from the plan, explain why and get approval

## On Completion

When all phases are complete:

```
## Implementation Complete

### Summary
- Phases completed: [N/N]
- Files modified: [count]
- Files created: [count]
- Tests passing: [yes/no]
- Build passing: [yes/no]

### Acceptance Criteria Status
- [ ] AC-1: [status + evidence]
- [ ] AC-2: [status + evidence]

### Ready for Review
Run `/harness-review` to start the review phase.
```

## Error Handling

- **Build failure**: Fix immediately within scope. If unfixable, report and pause.
- **Test failure**: Investigate. If it's a pre-existing failure, note it. If caused by your changes, fix it.
- **Plan ambiguity**: Ask the user for clarification. Do not guess.
- **Scope creep detected**: Stop and report. "This step requires changes outside the plan scope: [details]"
