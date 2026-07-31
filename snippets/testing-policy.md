# Testing Policy

Use this section in `AGENTS.md` to define when an agent should add or update tests.

```md
## Testing Policy

Add or update tests when:

- User-visible behavior changes.
- A bug fix should prevent regression.
- A refactor touches behavior that is not already covered.
- Edge cases or failure modes are part of the requested task.

Prefer focused tests that validate behavior over brittle implementation details.
Follow existing test structure, naming, fixtures, and helper patterns.
Do not rewrite test infrastructure unless explicitly requested.
If no practical test can be added, explain why in the final response.
```
