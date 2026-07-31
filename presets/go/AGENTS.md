# AGENTS.md

Working instructions for coding agents in this Go repository.

## Repository Discovery

- Inspect `go.mod`, workspace files, build scripts, CI workflows, generated-code directives, and project docs.
- Use repository wrapper commands when they exist; otherwise use standard Go tooling.
- Identify build tags, integration suites, and external-service requirements before broad tests.

## Working Loop

1. Understand the task and inspect relevant packages, interfaces, tests, and callers.
2. Make the smallest safe change and follow existing package boundaries.
3. Add or update tests when behavior changes.
4. Run package-level tests first, then broader checks when appropriate.
5. Inspect and fix failures, then rerun.
6. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

- Focused tests: `go test ./path/to/package`.
- Full tests: `go test ./...`.
- Static checks: `go vet ./...`.
- Format check: `gofmt -l <changed-go-files>`; no output means the files are formatted.

Use documented build tags and wrapper commands when required. Do not run integration or network-dependent suites without approval when they affect external state.

## Testing Policy

- Add regression coverage for bugfixes.
- Prefer table-driven tests when they match existing project style.
- Preserve exported behavior during refactors.
- Run race, integration, or platform-specific checks when required and available; otherwise report the gap.

## Editing Boundaries

- Do not edit generated Go files by hand; use the documented generator.
- Do not change `go.mod` or `go.sum` without an approved dependency change.
- Apply formatting only to changed Go files.
- Preserve internal and public package boundaries.

## Approval Rules

Allowed without asking:

- Read files; edit scoped source, tests, docs, and examples; run local standard checks.

Ask first:

- Delete files or run destructive commands.
- Add, remove, or upgrade modules.
- Run generators that make broad changes.
- Run migrations or alter persisted data.
- Change auth, security, secrets, network access, deployment, or infrastructure.

## Final Response

Include summary, files changed, checks run with outcomes, and remaining risks or follow-ups.
