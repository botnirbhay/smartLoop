# Before Vs After

Loop-driven prompts turn vague requests into bounded workflows. The goal is not longer prompts for their own sake. The goal is to make the work reproducible, checkable, and easier to stop safely.

## Bugfix

Before:

```text
Fix this bug.
```

After:

```text
Reproduce the bug, inspect relevant files, make the smallest safe change, add a regression test, run checks, fix failures, and stop when green or after 3 failed attempts.

Bug: <observed behavior>
Expected: <expected behavior>
Checks: <commands>
```

## Feature

Before:

```text
Add export support.
```

After:

```text
Inspect the existing export/import paths, implement the smallest useful export feature, follow existing UI/API patterns, add tests for the new behavior, run checks, and summarize risks.

Feature: <specific capability>
Constraints: <formats, permissions, compatibility>
Definition of done: <observable result>
```

## Refactor

Before:

```text
Clean this up.
```

After:

```text
Refactor only the selected module to reduce duplication. Preserve behavior, inspect callers first, avoid unrelated cleanup, run focused tests, and stop if the change requires a broader design decision.

Target: <file or module>
Behavior to preserve: <critical behavior>
Checks: <commands>
```

## Tests

Before:

```text
Add tests.
```

After:

```text
Inspect existing test patterns, add focused tests for the listed behavior and edge cases, avoid production changes unless a clear bug is found, run the focused test command, and report any coverage gaps.

Behavior: <what to protect>
Cases: <normal, edge, failure>
Checks: <test command>
```

## Documentation

Before:

```text
Document setup.
```

After:

```text
Inspect the actual setup files and scripts, document the shortest working setup path for a new developer, include copy-pasteable commands, do not invent unsupported behavior, and run docs checks if available.

Audience: <new developer, operator, maintainer>
Source of truth: <files>
```

## PR Cleanup

Before:

```text
Clean up this PR.
```

After:

```text
Inspect the diff, identify unrelated changes, missing tests, risky behavior changes, and check failures. Make only scoped cleanup changes, run relevant checks, and list anything that still needs human review.

Scope: <branch, diff, or files>
Do not: <forbidden changes>
Checks: <commands>
```
