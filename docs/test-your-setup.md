# Test Your Setup

Run this smoke test after adding or changing `AGENTS.md`. It is read-only and should not require project dependencies.

## Smoke-Test Prompt

```text
Follow the repository agent instructions.

Do not modify files and do not run commands.

Inspect the repository instructions and report:
1. The normal working loop.
2. The focused and broad checks you would use.
3. Files or directories you should avoid editing by hand.
4. Actions that require human approval.
5. The retry limit and stop conditions.
6. The required final response structure.
7. Any placeholder, contradiction, missing command, or ambiguous rule you found.
```

## Pass Conditions

The setup passes when the response:

- Identifies actual repository commands without inventing replacements.
- Distinguishes routine actions from ask-first actions.
- Finds protected paths and project-specific boundaries.
- States the retry limit.
- Includes the required final handoff.
- Calls out unresolved placeholders or ambiguity.

## Failure Signals

Revise `AGENTS.md` when the agent:

- Guesses commands.
- Cannot tell which checks are focused or broad.
- Misses generated, sensitive, or migration paths.
- Treats risky changes as routine.
- Cannot determine when to stop.
- Reports conflicting instructions without identifying the conflict.

After revision, run the smoke test again. Then use a small real task to confirm that the documented checks work in practice.
