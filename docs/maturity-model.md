# AI Agent Loop Maturity Model

Use this model to decide what to add next. You do not need every level on day one.

## Level 0: Ad Hoc Prompts

### What It Means

Every task relies on a fresh prompt. Important working rules live in the developer's head.

### What To Add

- A short `AGENTS.md` with the default working loop.
- One or two known check commands.

### Example Prompt

```text
Fix the settings bug.
```

### Risks

- Inconsistent behavior across sessions.
- Repeated instructions.
- Checks and stop conditions are easy to forget.

## Level 1: `AGENTS.md`

### What It Means

The repository has a shared coding-agent working loop and approval rules.

### What To Add

- Default loop.
- Approval rules.
- Final response format.

### Example Prompt

```text
Follow AGENTS.md. Fix the settings bug and run the available checks.
```

### Risks

- Task details may still be vague.
- Check commands may be incomplete.
- Templates may be needed for recurring work types.

## Level 2: Task Templates

### What It Means

Common tasks have reusable briefs with context, constraints, done criteria, and commands.

### What To Add

- Bugfix, feature, refactor, test, and documentation templates.
- Examples of good task prompts.

### Example Prompt

```text
Use templates/bugfix.md. Bug: saving settings drops the timezone field. Expected: timezone persists after save.
```

### Risks

- Templates can become stale.
- Developers may skip filling in constraints and checks.

## Level 3: Checks And Stop Conditions

### What It Means

The agent knows which commands to run and when to stop instead of looping indefinitely.

### What To Add

- Focused test commands.
- Lint, format, typecheck, and build commands.
- Stop-after-3-failed-attempts policy.
- Rules for unavailable checks.

### Example Prompt

```text
Follow AGENTS.md. Use the bugfix loop. Run `npm test -- settings` first, then `npm run typecheck` if source changes.
```

### Risks

- Slow or flaky checks can waste time.
- Some checks may require services or credentials.

## Level 4: CI-Integrated Agent Workflow

### What It Means

The local agent loop aligns with CI. The same checks and policies are documented for both local work and pull requests.

### What To Add

- CI command mapping.
- PR review loop.
- Rules for snapshots, generated files, and migrations.
- Known flaky check notes.

### Example Prompt

```text
Review this PR using docs/loop-recipes/pr-review-loop.md. Focus on failures from the same checks CI runs.
```

### Risks

- CI-only services may not be available locally.
- Agents may need clear instructions for what to do when CI differs from local commands.

## Level 5: Team-Wide Reusable Loop System

### What It Means

The team maintains shared loop recipes, snippets, and repo-specific policies across projects.

### What To Add

- Shared snippet library.
- Language-specific check examples.
- Team approval policy.
- Retrospective process for improving loops after repeated failures.

### Example Prompt

```text
Follow AGENTS.md and the team bugfix loop. Use the repo's documented checks and stop after 3 failed attempts on the same failure.
```

### Risks

- Shared rules can become too generic.
- Teams may copy policies without adapting them to the actual repo.
- Overly broad rules can slow down simple tasks.

