# AGENTS.md

Working instructions for coding agents in this Rust repository.

## Repository Discovery

- Inspect `Cargo.toml`, `Cargo.lock`, workspace configuration, feature flags, build scripts, CI workflows, and project docs.
- Identify the affected crate before running workspace-wide commands.
- Preserve the repository's minimum supported Rust version and feature policy when documented.

## Working Loop

1. Understand the task and inspect relevant crates, modules, traits, tests, and callers.
2. Make the smallest safe change and follow existing ownership and error-handling patterns.
3. Add or update tests when behavior changes.
4. Run crate-focused checks first, then workspace checks when appropriate.
5. Inspect and fix failures, then rerun.
6. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

- Focused tests: `cargo test -p <crate> <test-pattern>`.
- Full tests: `cargo test --workspace`.
- Fast compile check: `cargo check --workspace`.
- Lint: `cargo clippy --workspace --all-targets`.
- Format check: `cargo fmt --all --check`.

Use documented feature flags and target options. If a command requires unavailable toolchains, targets, services, or credentials, report the gap.

## Testing Policy

- Add regression coverage for bugfixes.
- Test public behavior and meaningful error paths.
- Preserve API behavior during refactors unless a breaking change is explicit.
- Do not silence Clippy or compiler warnings without understanding the cause.

## Editing Boundaries

- Do not edit `target/`, generated bindings, or vendored crates by hand.
- Do not change `Cargo.lock` without an intentional dependency change.
- Avoid broad formatting or warning cleanup outside task scope.
- Treat unsafe code and public API changes as high-risk.

## Approval Rules

Allowed without asking:

- Read files; edit scoped source, tests, docs, and examples; run local Cargo checks.

Ask first:

- Delete files or run destructive commands.
- Add, remove, or upgrade dependencies.
- Change unsafe code, security-sensitive behavior, or public APIs beyond task scope.
- Run migrations or alter persisted data.
- Change secrets, network access, deployment, or infrastructure.

## Final Response

Include summary, files changed, checks run with outcomes, and remaining risks or follow-ups.
