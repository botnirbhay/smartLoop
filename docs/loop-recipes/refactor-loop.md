# Refactor Loop

## When To Use It

Use this when the goal is to improve structure, readability, or duplication while preserving behavior.

## Loop Steps

1. Identify the refactor target and behavior that must not change.
2. Inspect callers, tests, and nearby patterns.
3. Define the smallest boundary for the refactor.
4. Add characterization tests first if behavior is under-tested and risk is meaningful.
5. Make the refactor in small steps.
6. Run focused checks after each meaningful step when practical.
7. Avoid unrelated cleanup.
8. Stop when behavior is preserved and checks pass.

## Agent Prompt

```text
Follow AGENTS.md and use docs/loop-recipes/refactor-loop.md.

Refactor target: <file, module, component, function>
Goal: <reduce duplication, clarify API, isolate logic, improve naming>
Behavior to preserve: <critical behavior>
Constraints: No user-visible behavior changes. Keep scope limited.
Checks: <commands>
```

## Checks To Run

- Existing tests around the refactored area.
- Typecheck or build for API changes.
- Broader tests if shared helpers or public interfaces changed.

## Stop Conditions

- Relevant checks pass and behavior is preserved.
- The refactor requires a larger design change than requested.
- Same check fails after 3 targeted attempts.
- Approval is required for dependency, migration, or broad API changes.

## Human Approval Points

- Public API changes.
- Data model or migration changes.
- Broad file moves.
- Removing code paths that might still be used.
- Dependency changes.

## Expected Final Response

- Summary
- Files changed
- Behavior preserved
- Checks run
- Remaining risks or follow-ups
