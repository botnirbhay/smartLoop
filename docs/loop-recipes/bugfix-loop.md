# Bugfix Loop

## When To Use It

Use this when behavior is wrong, reproducible, and should be corrected without broad redesign.

## Loop Steps

1. Restate the bug and expected behavior.
2. Inspect the smallest relevant area first: tests, error logs, caller, implementation.
3. Reproduce the bug with an existing or temporary check when possible.
4. Make the smallest safe fix.
5. Add or update a regression test.
6. Run the focused check, then broader checks if shared code changed.
7. If checks fail, inspect the error, fix the cause, and rerun.
8. Stop when checks pass, blocked, or after 3 failed attempts on the same issue.

## Agent Prompt

```text
Follow AGENTS.md and use docs/loop-recipes/bugfix-loop.md.

Bug: <describe observed behavior>
Expected: <describe expected behavior>
Context: <files, logs, route, component, issue link>
Constraints: Make the smallest safe change. Preserve unrelated behavior.
Checks: <commands to run, or say no checks are known>
```

## Checks To Run

- The smallest test that reproduces the bug.
- Related unit or integration tests.
- Lint/typecheck/build if touched code affects shared behavior.

## Stop Conditions

- Regression test fails before the fix and passes after the fix, when practical.
- Relevant checks pass.
- No check exists and the change has been manually inspected.
- Blocked by missing reproduction, permissions, or required external service.
- Same failure persists after 3 targeted attempts.

## Human Approval Points

- Data migrations.
- Auth or permission changes.
- Dependency upgrades.
- Deleting files or test fixtures.
- Network calls or production service access.

## Expected Final Response

- Summary
- Files changed
- Regression coverage
- Checks run
- Remaining risks or follow-ups
