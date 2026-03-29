---
description: "Harness Step 1: Initialize project environment - scan codebase, verify rules, and establish AI working context"
---

# Harness Setup - Project Environment Initialization

You are setting up the harness environment for this project. Follow these steps precisely:

## Step 1: Scan Project Context

1. **Read project CLAUDE.md** (if exists) to understand project-specific rules
2. **Identify tech stack**: Check package.json, requirements.txt, go.mod, Cargo.toml, etc.
3. **Identify folder structure**: Run `ls` on key directories to understand the layout
4. **Check for existing tests**: Find test files and test configuration
5. **Check for CI/CD**: Look for .github/workflows, Dockerfile, etc.

## Step 2: Verify Rules (Guardrails)

Confirm these are in place:
- [ ] CLAUDE.md exists with project-specific instructions
- [ ] Coding style conventions are documented or detectable
- [ ] Git workflow rules are understood
- [ ] Security constraints are identified (API keys, env vars, etc.)

If CLAUDE.md is missing or incomplete, **propose creating/updating it** with:
- Project description and stack
- Key conventions and patterns
- Known limitations and unimplemented features
- Environment variable requirements

## Step 3: Establish Work Context

Generate a **Project Status Report**:

```markdown
## Project Status Report

### Tech Stack
- Framework: [detected]
- Language: [detected]
- Database: [detected]
- Testing: [detected]

### Current State
- Total files: [count]
- Test coverage: [if detectable]
- Open TODOs: [count from grep]
- Last commit: [from git log]

### Rules Applied
- Global: ~/.claude/rules/*.md
- Project: ./CLAUDE.md
- Harness: Active (5-verb workflow)

### Ready for Development
- [ ] Rules verified
- [ ] Stack identified
- [ ] Structure understood
- [ ] Safety hooks active
```

## Step 4: Confirm Readiness

Present the status report to the user and confirm:
> "Harness setup complete. Project context established. Use `/harness-plan` to start planning your next feature."

## Important
- Do NOT write any code during setup
- Do NOT modify existing files unless updating CLAUDE.md with user approval
- This is a READ-ONLY reconnaissance phase
