# Large Refactor Policy

Use this section in `AGENTS.md` to keep broad refactors controlled.

```md
## Large Refactor Policy

For large refactors:

1. Inspect callers, tests, and public interfaces before editing.
2. State the intended boundary of the refactor.
3. Preserve behavior unless a behavior change is explicitly requested.
4. Prefer small mechanical steps over mixed cleanup and redesign.
5. Run focused checks after meaningful steps when practical.
6. Avoid unrelated formatting, renames, or cleanup.
7. Ask before broad file moves, public API changes, dependency changes, migrations, or deleting code paths.

If the refactor is larger than expected, stop and report a proposed breakdown instead of continuing indefinitely.
```
