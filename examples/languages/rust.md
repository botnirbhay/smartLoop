# Rust Example

Use this as a starting point for Rust repositories. Keep only the commands your repo actually supports.

## Typical Check Command

```sh
cargo test
```

## Lint Command

```sh
cargo clippy
```

## Format Command

```sh
cargo fmt --check
```

## Test Command

```sh
cargo test
```

## Sample `AGENTS.md` Snippet

```md
## Rust Checks

Use Cargo commands unless the repo documents a wrapper.

Preferred commands:

- `cargo test` for tests.
- `cargo clippy` for linting when configured.
- `cargo fmt --check` for format validation.
- `cargo check` for fast compile validation when tests are slow.

Run package-specific commands first in workspaces when only one crate changed.
```

## Common Gotchas

- Workspaces may need `-p <crate>` for focused checks.
- Feature flags can change what compiles or tests run.
- Updating dependencies changes `Cargo.lock` and should be intentional.
- Clippy warnings may be denied in CI even if local commands pass without flags.
- Generated code should usually come from the documented generator.
