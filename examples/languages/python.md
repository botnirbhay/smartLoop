# Python Example

Use this as a starting point for Python repositories. Keep only the commands your repo actually supports.

## Typical Check Command

```sh
pytest
```

## Lint Command

```sh
ruff check .
```

## Format Command

```sh
ruff format .
```

## Test Command

```sh
pytest
```

## Sample `AGENTS.md` Snippet

```md
## Python Checks

Inspect `pyproject.toml`, `tox.ini`, `noxfile.py`, or project docs before choosing commands.

Preferred commands:

- `pytest` for tests.
- `ruff check .` for linting when Ruff is configured.
- `ruff format --check .` for format validation when Ruff format is used.
- `mypy .` or the repo-specific typecheck command when configured.

If the project uses tox or nox, prefer the documented environment for broad validation.
```

## Common Gotchas

- Test commands may require environment variables or local services.
- Avoid changing generated lockfiles unless dependency changes were approved.
- Some repos use `python -m pytest` instead of `pytest`.
- Fixtures can hide important behavior; inspect them before changing tests.
- Type checking may be partial and configured for specific packages only.
