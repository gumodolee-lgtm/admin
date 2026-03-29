---
description: "Harness Step 5: Commit, changelog, and release after review passes."
---

# Harness Release - Release Phase

Finalize the harness workflow by creating a clean commit, updating changelog, and optionally creating a PR.

## Pre-flight Check

1. **Verify review passed**: Confirm `/harness-review` resulted in PASS or CONDITIONAL PASS
2. **Verify no CRITICAL/HIGH issues remain**: Check the review report
3. **Verify build passes**: Run build command
4. **Verify tests pass**: Run test command

If any pre-flight check fails, STOP and direct user to fix issues first.

## Release Process

### Step 1: Update CHANGELOG (if exists)

If a CHANGELOG.md exists, add an entry:

```markdown
## [Unreleased]

### Added
- [feature description from Plans.md]

### Changed
- [modifications description]

### Fixed
- [bug fixes description]
```

### Step 2: Stage and Commit

1. Run `git status` to see all changes
2. Run `git diff` to review staged/unstaged changes
3. Run `git log --oneline -5` for commit message style reference
4. Stage relevant files (NOT .env, credentials, etc.)
5. Create commit with conventional commit format:

```
<type>: <description from Plans.md summary>

- [key change 1]
- [key change 2]
- [key change N]

Plan: Plans.md
Review: PASS
```

### Step 3: Confirm Next Steps

Ask the user:

> **Commit created successfully.**
>
> Next steps (choose one):
> 1. **Push to remote**: `git push`
> 2. **Create PR**: I'll create a pull request with summary from Plans.md
> 3. **Tag release**: Create a version tag
> 4. **Done**: No further action needed
>
> Also: Should I clean up Plans.md? (archive to docs/plans/ or delete)

### Step 4: Clean Up (with user approval)

- Move Plans.md to `docs/plans/[date]-[feature].md` for history
- Or delete Plans.md if user prefers
- Update any TODO items that were completed

## Rules

1. **Never push without asking** - always confirm before `git push`
2. **Never force push** - especially not to main/master
3. **Don't skip the pre-flight** - review must pass before release
4. **Include plan reference** - link the commit to the Plans.md for traceability
5. **Respect git workflow** - follow the project's branching strategy

## Workflow Complete

After release:

```
## Harness Workflow Complete

Feature: [name]
Plan: [created date] → Review: [PASS date] → Released: [now]
Commit: [hash]
Files: [count] modified, [count] created

Next: Start a new feature with `/harness-plan <feature>`
```
