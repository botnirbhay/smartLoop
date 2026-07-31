# PR Review Loop

## When To Use It

Use this to review a branch or diff for bugs, regressions, missing tests, and risky changes.

## Loop Steps

1. Inspect the diff before proposing changes.
2. Identify changed behavior, public interfaces, migrations, and config changes.
3. Review tests and checks related to the changed area.
4. Prioritize findings by severity and confidence.
5. Suggest concrete fixes with file references.
6. If asked to apply fixes, make the smallest safe changes and run checks.
7. Stop when findings are reported or requested fixes are verified.

## Agent Prompt

```text
Follow AGENTS.md and use docs/loop-recipes/pr-review-loop.md.

Review scope: <branch, diff, files, PR link, or commit range>
Focus: Bugs, regressions, missing tests, security risks, and unclear behavior.
Do not make changes unless explicitly asked after the review.
```

## Checks To Run

- For review-only work, checks are optional unless the user asks.
- If applying fixes, run focused tests and relevant lint/typecheck/build commands.

## Stop Conditions

- Findings are reported with severity and file references.
- No issues are found and residual risks are stated.
- Review is blocked by missing diff or unavailable files.
- Fixes require approval beyond the review scope.

## Human Approval Points

- Applying review fixes.
- Changing public behavior.
- Updating snapshots.
- Modifying migrations, auth, secrets, or deployment config.

## Expected Final Response

- Findings first, ordered by severity
- Open questions or assumptions
- Checks run, if any
- Summary of applied fixes, only if changes were made
