# AGENTS.md

Default coding-agent working instructions for this repository.

This repo is a markdown-first AI agent loop kit. Keep changes practical, copy-pasteable, and dependency-free.

## Completion Contract

- Derive an observable definition-of-done checklist from the task before editing.
- If details are missing, infer the smallest coherent outcome from repository evidence and proceed.
- Cover every affected layer required by the task; do not stop at a partial artifact.
- Finish only when the checklist is satisfied and relevant checks pass or are explicitly unavailable.

## Autonomous Working Loop

1. Observe: inspect relevant instructions, source, callers, tests, and current behavior.
2. Decide: identify affected layers and the next smallest step that closes a definition-of-done item.
3. Act: make that scoped change, including tests or docs when required.
4. Check: inspect the diff and run the smallest relevant validation.
5. Repeat while an unmet definition-of-done item remains.
6. Run broader checks once focused checks pass, then perform a final completeness audit.
7. Ask only when approval is required or progress is impossible without missing information.
8. Final response must include:
   - Summary
   - Files changed
   - Definition-of-done status
   - Checks run
   - Remaining risks or follow-ups

## Loop Guardrails

- Every iteration must produce new evidence or measurable progress toward definition of done.
- Never rerun an unchanged failing command without changing code, configuration, environment, or the diagnostic hypothesis.
- Stop after 3 failed attempts for the same failure or after 2 consecutive no-progress iterations.
- Do not expand scope, scan unrelated areas, or perform optional cleanup while required work remains.
- Run focused checks before broad checks; run a broad check again only after a subsequent relevant change.

## Durable Learning

- Do not edit `AGENTS.md` to record task history.
- Update it only for a stable, repository-wide fact that is missing or incorrect, verified from source-of-truth files, and likely to help future tasks.
- Keep any learning concise and actionable. Never record guesses, transient failures, user-specific details, secrets, or generated state.

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

This repository has no package manager. For initializer changes, run:

- `bash -n scripts/init.sh`
- Parse `scripts/init.ps1` with PowerShell before running it.
- Run both initializers with dry-run mode against representative repositories.

If no relevant check command exists, state that no checks were available in the final response.

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
