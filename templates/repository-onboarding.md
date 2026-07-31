# Repository Onboarding Template

## Task

Inspect this repository and propose a project-specific `AGENTS.md`.

This task has two phases. Complete discovery and receive human approval before creating or editing files.

## Context

Repository purpose:

Primary languages or frameworks, if known:

Existing contribution, architecture, or agent instruction files:

Known commands:

Known protected or generated paths:

## Constraints

- Discovery is read-only.
- Do not invent commands.
- Cite the repository source for each proposed command.
- Do not install dependencies or make network calls.
- Do not run migrations, deployment commands, or destructive commands.
- Surface ambiguity instead of guessing.
- Preserve existing project policies and architecture boundaries.

## Definition Of Done

Phase 1:

- Project structure and source-of-truth files were inspected.
- Supported commands and their sources were reported.
- Protected files, approval points, and unknowns were reported.
- A proposed `AGENTS.md` outline was provided without editing files.

Phase 2, after approval:

- A concise, project-specific `AGENTS.md` exists.
- Commands are exact and scoped by purpose.
- Approval rules, stop conditions, and final response requirements are included.
- The setup passes the read-only smoke test.

## Commands To Run

```sh
# Discovery should not require running project commands.
# Add a harmless repository-specific validation command after approval, if one exists.
```

## Expected Final Response

- Summary
- Files changed
- Checks run
- Remaining risks or follow-ups
- Repository facts that still require human confirmation
