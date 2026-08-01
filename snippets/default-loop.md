# Default Working Loop

Use this section in `AGENTS.md` to define a bounded autonomous coding-agent loop.

```md
## Completion Contract

- Derive an observable definition-of-done checklist before editing.
- Infer missing low-risk details from repository evidence and proceed.
- Identify all affected layers and complete every layer the requested outcome requires.
- Finish only when every checklist item is satisfied and checks pass or are explicitly unavailable.

## Autonomous Working Loop

1. Observe relevant instructions, source, callers, tests, configuration, and current behavior.
2. Decide the next smallest coherent step that closes a checklist item.
3. Act by making that scoped change, including required tests or docs.
4. Check the diff and run the smallest relevant validation.
5. Repeat until no definition-of-done item remains.
6. Run required broad checks once, then audit the complete result.

## Loop Guardrails

- Every iteration must add evidence or measurable progress.
- Never rerun an unchanged failure without a changed implementation, environment, or hypothesis.
- Stop after 3 attempts on the same failure or 2 consecutive no-progress iterations.
- Do not expand scope or repeat broad repository scans.
- Ask only for required approval or information that cannot be inferred safely.
```
