# Example Task

Because the working policy now lives in `AGENTS.md`, the task prompt can focus on the requested outcome:

```text
Follow AGENTS.md.

Task:
Fix note updates so omitted optional fields retain their existing values.

Context:
The behavior is in the notes domain. A user reports that updating only the title clears the archived timestamp.

Definition of done:
- Updating one field preserves omitted optional fields.
- A regression test covers the archived timestamp case.
- Relevant checks pass.
```

The prompt does not repeat test commands, approval rules, retry behavior, generated-file rules, or the final response format.
