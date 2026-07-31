# Default Working Loop

Use this section in `AGENTS.md` to define the normal coding-agent loop.

```md
## Working Loop

1. Understand the task and restate the intended outcome when useful.
2. Inspect relevant files before editing.
3. Make the smallest safe change that satisfies the task.
4. Add or update tests when behavior changes.
5. Run the most relevant available checks.
6. If a check fails, inspect the error, fix the likely cause, and rerun.
7. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.
8. In the final response, include summary, files changed, checks run, and remaining risks.
```
