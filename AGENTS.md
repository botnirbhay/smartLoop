# AGENTS.md

Default coding-agent working instructions for this repository.

This repo is a markdown-first AI agent loop kit. Keep changes practical, copy-pasteable, and dependency-free.

## Working Loop

1. Understand the task.
2. Inspect relevant files before editing.
3. Make the smallest safe change.
4. Add or update examples, snippets, recipes, or docs when the behavior of the kit changes.
5. Run available checks.
6. If checks fail, inspect the error, fix the cause, and rerun.
7. Stop when checks pass, when blocked, or after 3 failed attempts.
8. Final response must include:
   - Summary
   - Files changed
   - Checks run
   - Remaining risks or follow-ups

## Repository Rules

- Keep the repo lightweight and markdown-first.
- Do not add dependencies, package managers, generated projects, or fake runnable apps.
- Prefer practical examples over theory.
- Do not invent claims about AI agent internals or tool capabilities.
- Keep examples copy-pasteable into real repositories.
- Use ASCII text unless there is a clear reason not to.

## Approval Rules

Allowed without asking:

- Read files.
- Edit markdown, source, tests, and examples.
- Run lint, format, typecheck, and tests.
- Create new documentation/templates/snippets/recipes.

Ask first:

- Deleting files.
- Destructive shell commands.
- Dependency upgrades.
- Migrations.
- Auth/security changes.
- Secrets or credential changes.
- Network calls.

## Checks

Run the relevant checks that exist in the repository. Prefer the smallest command that validates the changed behavior, then broader checks when the change touches shared behavior.

This repository currently has no package manager or runnable project checks. If no check command exists, state that no checks were available in the final response.

## Failure Handling

When a check fails:

1. Read the error.
2. Identify the likely cause.
3. Make a targeted fix.
4. Rerun the relevant check.

Stop after 3 failed attempts for the same issue and report the blocker clearly.

## Final Response Format

Include:

- Summary
- Files changed
- Checks run
- Remaining risks or follow-ups
