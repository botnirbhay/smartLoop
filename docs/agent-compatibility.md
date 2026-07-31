# Agent Compatibility

The loop in this repository is vendor-neutral. The exact way an agent receives repository instructions is not.

## Portable Parts

These parts can be reused with almost any coding agent:

- Task briefs with context, constraints, and a definition of done.
- Check commands that already exist in the repository.
- Approval rules for risky or irreversible actions.
- Retry limits and stop conditions.
- A consistent final response format.
- Recipes for bugfixes, refactors, reviews, tests, and documentation.

## Tool-Specific Parts

Agents differ in how they discover instructions, invoke tools, request approval, retain context, and report results. Do not assume that a file name or feature supported by one agent works in another.

Before adopting the kit:

1. Check how your agent accepts repository-level instructions.
2. Use this kit's `AGENTS.md` as the canonical policy.
3. If needed, copy or link the policy into the agent's supported instruction file or settings.
4. Keep task-specific details in the current prompt or task template.
5. Verify the agent can run the documented commands in its actual environment.

## Minimal Portable Prompt

```text
Follow the repository working instructions provided with this task.

Inspect relevant files before editing. Make the smallest safe change. Add or update tests when behavior changes. Run the documented checks. If a check fails, inspect the cause, make a targeted fix, and rerun. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

Task: <task>
Context: <context>
Definition of done: <observable result>
Checks: <commands, or say none are known>

Final response: summary, files changed, checks run, and remaining risks or follow-ups.
```

## Compatibility Checklist

- Does the agent automatically read `AGENTS.md`, or must the policy be pasted or configured elsewhere?
- Can it edit files and run shell commands?
- Does it ask for approval before risky actions?
- Can it access required services, credentials, containers, or network resources?
- Does it preserve repository scope and ignore unrelated changes?
- Can it return the required handoff format?

Treat unsupported capabilities as explicit constraints. The workflow remains useful even when a human runs the checks or applies the suggested patch.
