# AGENTS.md

Working instructions for coding agents in this repository.

## Repository Context

- Purpose: <describe the project>
- Primary source: <source path>
- Tests: <test path>
- Important architecture rules: <rules or source-of-truth document>

Replace every placeholder before using this file.

## Working Loop

1. Understand the task and definition of done.
2. Inspect relevant files and callers before editing.
3. Make the smallest safe change.
4. Add or update tests when behavior changes.
5. Run the smallest relevant checks, then broader checks when required.
6. If a check fails, inspect the error, fix the cause, and rerun.
7. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

- Focused tests: `<focused-test-command>`
- Full tests: `<full-test-command>`
- Lint: `<lint-command>`
- Format check: `<format-check-command>`
- Typecheck: `<typecheck-command>`
- Build: `<build-command>`

Remove unsupported commands. Never invent a replacement for a missing command. If no relevant check exists, say so in the final response.

## Testing Policy

- Add a regression test for a bugfix when practical.
- Add tests for new behavior and meaningful failure cases.
- Preserve existing behavior during refactors.
- Do not change production behavior only to make a weak test pass.

## Editing Boundaries

- Do not edit generated files by hand: `<generated paths or none>`.
- Avoid unrelated cleanup.
- Preserve existing public APIs unless the task requires a change.
- Follow `<contribution or architecture document>`.

## Approval Rules

Allowed without asking:

- Read files and inspect repository structure.
- Edit source, tests, docs, and examples within task scope.
- Run existing focused and broad checks.

Ask first:

- Delete files or run destructive commands.
- Add, remove, or upgrade dependencies.
- Run migrations or alter persisted data.
- Change authentication, authorization, or security-sensitive behavior.
- Edit secrets, credentials, or private environment values.
- Make network calls or access external services.
- Change deployment, infrastructure, billing, or production configuration.

## Final Response

Include:

- Summary
- Files changed
- Checks run and their outcomes
- Remaining risks or follow-ups
