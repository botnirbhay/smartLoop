# Test Generation Loop

## When To Use It

Use this when the goal is to add meaningful coverage for existing behavior.

## Loop Steps

1. Identify the behavior to protect.
2. Inspect existing tests and local conventions.
3. Inspect implementation only enough to understand inputs, outputs, and side effects.
4. Add focused tests for normal cases, edge cases, and failure cases.
5. Avoid changing production code unless a real bug is discovered.
6. Run the focused test command.
7. Fix test issues or report product bugs clearly.
8. Run broader checks if shared helpers or fixtures changed.

## Agent Prompt

```text
Follow AGENTS.md and use docs/loop-recipes/test-generation-loop.md.

Add tests for: <module, component, behavior>
Important cases: <cases>
Constraints: Follow existing test style. Do not change production behavior unless there is a clear bug.
Checks: <test command>
```

## Checks To Run

- The focused test command for the new tests.
- Related test file or package commands.
- Typecheck/build if tests require shared fixtures or types.

## Stop Conditions

- New tests pass and cover the requested behavior.
- A real product bug is found and needs separate approval to fix.
- Test environment is unavailable.
- Same failure persists after 3 targeted attempts.

## Human Approval Points

- Changing production behavior.
- Rewriting test infrastructure.
- Updating broad snapshots.
- Adding dependencies.

## Expected Final Response

- Summary
- Files changed
- Coverage added
- Checks run
- Remaining risks or follow-ups
