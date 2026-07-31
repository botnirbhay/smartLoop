# AGENTS.md

Working instructions for coding agents in this Node.js repository.

## Repository Discovery

- Inspect `package.json`, the lockfile, workspace configuration, CI workflows, and contribution docs before choosing commands.
- Use the package manager established by the lockfile and project docs.
- Run only scripts that exist in the relevant `package.json`.
- In a workspace, identify the affected package before running broad root commands.

## Working Loop

1. Understand the task and inspect relevant source, tests, and callers.
2. Make the smallest safe change and follow existing JavaScript or TypeScript patterns.
3. Add or update tests when behavior changes.
4. Run a focused test when the repository supports one.
5. Run relevant package scripts for lint, typecheck, and build.
6. Inspect and fix check failures, then rerun.
7. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

Use only scripts present in the repository:

- Focused tests: `npm test -- <test-pattern>`, or the documented runner equivalent.
- Full tests: `npm test`.
- Lint: `npm run lint`.
- Format check: `npm run format:check`.
- Typecheck: `npm run typecheck`.
- Build: `npm run build`.

Replace `npm` with the established package manager. If a script is absent, report that it was unavailable instead of inventing it.

## Testing Policy

- Add regression coverage for bugfixes.
- Cover new behavior, important edge cases, and failure paths.
- Treat snapshot changes as behavior changes that require review.
- Do not update broad snapshots merely to make tests pass.

## Editing Boundaries

- Do not edit `node_modules/`, build output, coverage output, or generated clients by hand.
- Do not change lockfiles unless an approved dependency change requires it.
- Avoid broad formatter changes outside touched files.
- Preserve package boundaries and public exports unless the task requires a change.

## Approval Rules

Allowed without asking:

- Read files; edit scoped source, tests, docs, and examples; run existing checks.

Ask first:

- Delete files or run destructive commands.
- Install, remove, upgrade, or replace dependencies.
- Change lockfiles without an approved dependency change.
- Run migrations or change persisted data.
- Change auth, security, secrets, network access, deployment, or infrastructure.

## Final Response

Include summary, files changed, checks run with outcomes, and remaining risks or follow-ups.
