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
- Derive an observable definition-of-done checklist and identify every affected layer.
- Complete the smallest coherent end-to-end change that satisfies the task.
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
Use the loop Observe -> Decide -> Act -> Check -> Repeat. Every iteration must produce new evidence or measurable progress. If a check fails, inspect the error, identify the likely cause, make a targeted fix, and rerun it. Never rerun an unchanged failure. Stop after 3 failed attempts for the same failure or 2 consecutive no-progress iterations and report the blocker.

Final response format:
- Summary
- Files changed
- Definition of done: completed items and any unmet item
- Checks run
- Remaining risks or follow-ups
```

## Short Version

```text
Follow AGENTS.md. Derive definition of done, inspect the affected layers, and use Observe -> Decide -> Act -> Check -> Repeat until the complete outcome is verified. Do not rerun unchanged failures or ask for routine confirmation. Stop after 3 attempts on the same failure or 2 no-progress iterations. Final response: summary, files changed, definition-of-done status, checks, and remaining risks.

Task: <task>
Context: <context>
Checks: <commands>
```
