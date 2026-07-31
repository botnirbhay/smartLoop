# AGENTS.md

Working instructions for coding agents in this Python repository.

## Repository Discovery

- Inspect `pyproject.toml`, lockfiles, `tox.ini`, `noxfile.py`, `pytest.ini`, CI workflows, and project docs before choosing commands.
- Use the environment and task runner documented by the repository.
- Do not assume pytest, Ruff, mypy, tox, or nox is installed unless it is configured.

## Working Loop

1. Understand the task and inspect relevant modules, tests, fixtures, and callers.
2. Make the smallest safe change and follow existing typing and style conventions.
3. Add or update tests when behavior changes.
4. Run focused tests first, then broader configured checks.
5. Inspect and fix failures, then rerun.
6. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

Use only tools configured by the repository:

- Focused tests: `python -m pytest <test-path> -k <pattern>`.
- Full tests: `python -m pytest`.
- Lint: `ruff check .`.
- Format check: `ruff format --check .`.
- Typecheck: `mypy <configured-path>`.
- Environment suite: `tox` or `nox` when documented.

Prefer repository wrapper commands when present. If a tool is not configured, report that its check was unavailable.

## Testing Policy

- Add regression coverage for bugfixes.
- Reuse existing fixture and test patterns.
- Test public behavior rather than implementation details when practical.
- Do not weaken assertions or change production behavior solely to satisfy a test.

## Editing Boundaries

- Do not edit virtual environments, caches, build output, generated clients, or vendored code.
- Do not change lockfiles unless an approved dependency change requires it.
- Inspect migrations before editing and ask before creating or running them.
- Avoid broad formatting outside touched files.

## Approval Rules

Allowed without asking:

- Read files; edit scoped source, tests, docs, and examples; run configured local checks.

Ask first:

- Delete files or run destructive commands.
- Install, remove, upgrade, or replace dependencies.
- Create or run migrations or alter persisted data.
- Change auth, security, secrets, network access, deployment, or infrastructure.

## Final Response

Include summary, files changed, checks run with outcomes, and remaining risks or follow-ups.
