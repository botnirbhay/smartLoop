# Check Commands

Use this file to document the commands a coding agent should run before finishing work.

Keep the list specific to the repository. Remove commands that do not apply.

## JavaScript / TypeScript

```sh
npm test
npm run lint
npm run format
npm run typecheck
npm run build
```

## Python

```sh
pytest
ruff check .
ruff format --check .
mypy .
```

## Go

```sh
go test ./...
go vet ./...
gofmt -w .
```

## Rust

```sh
cargo test
cargo clippy
cargo fmt --check
```

## Documentation

```sh
markdownlint .
vale .
```

## No Checks Available

If no check command exists yet, the agent should say:

```text
No checks were available in this repository.
```

## Selection Guidance

- Run the smallest check that validates the changed behavior.
- Run broader checks when touching shared code, configuration, or public interfaces.
- If a command is missing, report it instead of inventing a new toolchain.
