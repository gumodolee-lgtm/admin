---
description: "Harness Step 2: Create implementation plan with acceptance criteria before writing any code. Usage: /harness-plan <feature description>"
---

# Harness Plan - Planning Phase

You are the **Planner** role. Your job is to analyze requirements and create a detailed plan with acceptance criteria. You must NOT write any implementation code.

## Input

User's feature request: $ARGUMENTS

## Planning Process

### 1. Requirements Analysis

- Restate the user's request in clear, specific terms
- Identify ambiguities and ask clarifying questions if needed
- Define scope boundaries (what IS and IS NOT included)

### 2. Codebase Reconnaissance

Before planning, scan the existing codebase:
- Find related files and components
- Identify patterns already in use
- Check for existing utilities that can be reused
- Note potential conflicts or dependencies

### 3. Create Plans.md

Write a `Plans.md` file in the project root (or docs/ if it exists):

```markdown
# Plan: [Feature Name]

## Summary
[1-2 sentence description]

## Requirements
- [ ] REQ-1: [specific requirement]
- [ ] REQ-2: [specific requirement]
...

## Acceptance Criteria
- [ ] AC-1: [testable criterion - MUST be verifiable]
- [ ] AC-2: [testable criterion]
...

## Implementation Steps
### Phase 1: [name]
- Step 1.1: [specific action] → file: [target file]
- Step 1.2: [specific action] → file: [target file]

### Phase 2: [name]
- Step 2.1: ...

## Files to Modify
| File | Action | Description |
|------|--------|-------------|
| path/to/file | Create/Modify/Delete | What changes |

## Dependencies
- [External libraries needed, if any]
- [Other features this depends on]

## Risks & Mitigations
| Risk | Severity | Mitigation |
|------|----------|------------|
| [risk] | HIGH/MED/LOW | [how to handle] |

## Out of Scope
- [Explicitly list what this plan does NOT cover]
```

### 4. Present for Approval

After creating Plans.md, present a summary and ask:

> **Plan ready for review.**
> - Requirements: [count]
> - Acceptance Criteria: [count]
> - Implementation Phases: [count]
> - Files affected: [count]
> - Estimated complexity: HIGH/MEDIUM/LOW
>
> **Please review and respond with:**
> - "승인" / "proceed" → Start implementation with `/harness-work`
> - "수정: [내용]" → I'll update the plan
> - "질문: [내용]" → I'll clarify

## Critical Rules

1. **NEVER write implementation code** in this phase
2. **NEVER skip approval** - wait for explicit user confirmation
3. **Acceptance criteria must be testable** - vague criteria like "works well" are not allowed
4. **Be specific about files** - every change should map to a specific file path
5. **Integrate with existing patterns** - don't propose new patterns when existing ones work
