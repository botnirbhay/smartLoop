# Failing Test Loop

## When To Use It

Use this when a test, lint command, typecheck, build, or CI check is failing and the goal is to make it green.

## Loop Steps

1. Run or inspect the failing command.
2. Read the first meaningful error, not just the final summary.
3. Identify whether the failure is product code, test code, fixture data, environment, or command setup.
4. Inspect relevant files before editing.
5. Make one targeted fix.
6. Rerun the same failing command.
7. Repeat only for the same failure up to 3 attempts.
8. Run adjacent checks if the fix touches shared behavior.

## Agent Prompt

```text
Follow AGENTS.md and use docs/loop-recipes/failing-test-loop.md.

Failing command: <command>
Failure output: <paste relevant error>
Context: <recent change, branch, files, CI link>
Constraints: Fix the cause. Do not weaken tests unless the assertion is clearly wrong and explain why.
```

## Checks To Run

- The exact failing command first.
- The narrowest related test command after a code fix.
- Broader checks only after the targeted failure is green.

## Stop Conditions

- The original failing command passes.
- The failure is environmental and cannot be fixed in code.
- The same failure remains after 3 targeted attempts.
- Fixing the failure requires approval for a risky action.

## Human Approval Points

- Removing or weakening assertions.
- Updating snapshots with broad visual or behavioral changes.
- Changing CI configuration.
- Installing or upgrading dependencies.
- Accessing external services.

## Expected Final Response

- Summary
- Root cause
- Files changed
- Checks run
- Remaining risks or follow-ups
