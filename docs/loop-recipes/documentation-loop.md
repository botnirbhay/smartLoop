# Documentation Loop

## When To Use It

Use this when creating or updating documentation for a real workflow, API, command, setup path, or decision.

## Loop Steps

1. Identify the audience and task the docs must support.
2. Inspect the source of truth: code, config, scripts, existing docs, or tests.
3. Verify commands and paths when practical.
4. Write concise docs with copy-pasteable examples.
5. Link related docs instead of duplicating large sections.
6. Run docs checks if available.
7. Stop when the docs match the actual project behavior.

## Agent Prompt

```text
Follow AGENTS.md and use docs/loop-recipes/documentation-loop.md.

Document: <topic>
Audience: <new contributor, operator, app developer, maintainer>
Source of truth: <files, commands, code paths>
Constraints: Do not invent behavior. Prefer examples that can be copied.
Checks: <docs checks or none known>
```

## Checks To Run

- Markdown lint, docs build, link checker, or spell checker if available.
- Commands shown in the docs, when safe and local.

## Stop Conditions

- Docs accurately describe current behavior.
- No docs check exists and the markdown was reviewed.
- Verification requires credentials or services that are unavailable.
- The requested docs would require documenting behavior that does not exist.

## Human Approval Points

- Publishing externally.
- Documenting sensitive operational details.
- Adding credential, secret, or production access instructions.
- Changing docs that define compliance or security policy.

## Expected Final Response

- Summary
- Files changed
- Source of truth inspected
- Checks run
- Remaining risks or follow-ups
