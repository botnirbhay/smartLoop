# AGENTS.md

Working instructions for coding agents in Notes API.

## Repository Context

- Node.js and TypeScript API.
- Source code: `src/`.
- Tests: `test/`.
- Notes domain: `src/notes/` and `test/notes/`.
- Authentication code under `src/auth/` is security-sensitive.

## Working Loop

1. Understand the task and inspect relevant source, tests, and callers.
2. Make the smallest safe change.
3. Add or update tests when behavior changes.
4. Run focused checks first, then broader checks when shared behavior changes.
5. Inspect and fix failures, then rerun.
6. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

- Focused notes tests: `npm run test:notes`.
- Full tests: `npm test`.
- Lint: `npm run lint`.
- Typecheck: `npm run typecheck`.
- Build: `npm run build`.

Run the full CI command set when shared APIs, configuration, or cross-domain behavior changes. Integration tests require a database service; report them as unavailable when the service is not present.

## Testing Policy

- Add a regression test for bugfixes when practical.
- Cover new behavior and meaningful error cases.
- Do not weaken assertions merely to make a test pass.

## Editing Boundaries

- Do not edit `src/generated/` by hand. The generator command is currently undocumented, so report a blocker when regeneration is required.
- Ask before creating, changing, or running `prisma/migrations/`.
- Do not change `package-lock.json` without an approved dependency change.
- Avoid unrelated cleanup.

## Approval Rules

Allowed without asking:

- Read files.
- Edit scoped source, tests, and documentation.
- Run existing local checks.

Ask first:

- Delete files or run destructive commands.
- Add, remove, or upgrade dependencies.
- Change the lockfile.
- Change authentication, authorization, migrations, or persisted data.
- Access external services or make network calls.
- Change secrets, deployment, or infrastructure.

## Final Response

Include:

- Summary
- Files changed
- Checks run and outcomes
- Remaining risks or follow-ups
