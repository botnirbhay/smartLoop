# Discovery Report

This is the proposal the agent returns before editing files.

## Project

- Node.js and TypeScript API.
- Application source is under `src/`.
- Tests are under `test/`.
- Database migrations are under `prisma/migrations/`.

## Proposed Checks

- Focused notes tests: `npm run test:notes`, from `package.json`.
- Full tests: `npm test`, from `package.json` and CI.
- Lint: `npm run lint`, from `package.json` and CI.
- Typecheck: `npm run typecheck`, from `package.json` and CI.
- Build: `npm run build`, from `package.json` and CI.

## Proposed Editing Boundaries

- Do not edit `src/generated/` by hand.
- Ask before creating or changing `prisma/migrations/`.
- Treat `src/auth/` changes as security-sensitive.
- Do not change `package-lock.json` without an approved dependency change.

## Proposed Approval Points

Ask before:

- Dependency or lockfile changes.
- Migration creation or execution.
- Authentication or authorization changes.
- Commands requiring external services or network access.
- Deleting files or running destructive commands.

## Unknowns

- The repository does not document the generator command for `src/generated/`.
- Integration-test setup is not documented.

These unknowns should be recorded instead of guessed.
