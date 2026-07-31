# Golden Prompt

Use this as a strong default prompt for most coding-agent implementation tasks. Replace bracketed text with concrete details.

```text
Follow AGENTS.md.

Task:
[Describe the exact change or investigation.]

Context:
[Relevant files, commands, logs, issue links, user reports, constraints, or prior decisions.]

Constraints:
- Inspect relevant files before editing.
- Make the smallest safe change that satisfies the task.
- Follow existing project patterns.
- Add or update tests when behavior changes.
- Do not introduce dependencies unless explicitly approved.
- Ask before deleting files, running destructive commands, changing auth/security behavior, editing secrets, running migrations, making network calls, or changing deployment/infrastructure config.

Definition of done:
- [Observable outcome 1]
- [Observable outcome 2]
- Relevant tests or docs are updated.
- Available checks pass, or unavailable checks are reported clearly.

Checks:
- [Focused test command]
- [Lint/typecheck/build command]
- If no check command exists, say that no checks were available.

Retry behavior:
If a check fails, inspect the error, identify the likely cause, make a targeted fix, and rerun the relevant check. Stop after 3 failed attempts for the same failure and report the blocker.

Final response format:
- Summary
- Files changed
- Checks run
- Remaining risks or follow-ups
```

## Short Version

```text
Follow AGENTS.md. Inspect first, make the smallest safe change, add or update tests for behavior changes, run available checks, fix check failures by reading the error, and stop when checks pass, blocked, or after 3 failed attempts. Final response: summary, files changed, checks run, remaining risks.

Task: <task>
Context: <context>
Checks: <commands>
```
