# Adoption Checklist

Use this checklist when copying AI Agent Loop Kit into a real repository. The output should be a project-specific `AGENTS.md` plus any templates or recipes your team actually uses.

For an agent-assisted, two-phase setup, start with [Bootstrap Your Repository](bootstrap-your-repo.md), then use this checklist during human review.

## 1. What Commands Should The Agent Run?

Identify the commands that already exist. Do not invent a new toolchain just for an agent.

- Focused test command:
- Full test command:
- Lint command:
- Format check command:
- Typecheck command:
- Build command:
- Documentation check command:
- CI command or workflow name:

Notes:

- Which commands are slow?
- Which commands are flaky?
- Which commands require services, credentials, containers, or network access?
- What should the agent say when no checks are available?

## 2. What Files Should The Agent Avoid?

List files and directories that should not be edited by hand.

- Generated files:
- Vendored dependencies:
- Build outputs:
- Lockfiles that need approval before changing:
- Migration files with special rules:
- Environment or machine-specific files:
- Large data fixtures:

Suggested `AGENTS.md` wording:

```md
Do not edit generated files by hand. If generated output must change, use the documented generator or ask for approval when the generator is unavailable.
```

## 3. When Should The Agent Ask Before Acting?

Define approval points before work starts.

Ask before:

- Deleting files.
- Running destructive shell commands.
- Installing, removing, upgrading, or replacing dependencies.
- Running migrations or changing persisted data.
- Changing auth, authorization, permissions, or security-sensitive behavior.
- Editing secrets, credentials, tokens, keys, or private environment values.
- Making network calls or accessing external services.
- Changing deployment, infrastructure, billing, or production configuration.
- Updating broad snapshots or generated outputs.

## 4. What Does Done Mean?

Define done in observable terms.

For every task, require the agent to derive a checklist, identify affected layers, and keep looping until each required item is implemented and checked. Missing low-risk details should be inferred from repository evidence; only approval points or unsafe ambiguity should interrupt the run.

Suggested `AGENTS.md` wording:

```md
Use Observe -> Decide -> Act -> Check -> Repeat. Every iteration must produce new evidence or progress. Do not stop at a partial layer. Stop after 3 attempts on the same failure or 2 consecutive no-progress iterations.
```

For bugfixes:

- The bug is fixed.
- A regression test exists when practical.
- Relevant checks pass.

For features:

- The feature works in the intended path.
- Expected edge cases are handled.
- Tests and docs are updated when needed.

For refactors:

- Behavior is preserved.
- The scoped code is simpler or less duplicated.
- Checks covering the area pass.

For documentation:

- The docs match actual commands and files.
- Examples are copy-pasteable.
- Docs checks pass when available.

## 5. What Should The Final Response Include?

Use a consistent handoff format.

```md
Final response must include:

- Summary
- Files changed
- Definition of done: completed items and any unmet item
- Checks run
- Remaining risks or follow-ups
```

Add task-specific details when useful:

- Root cause for bugfixes.
- Coverage added for tests.
- Behavior preserved for refactors.
- Source of truth inspected for documentation.
- Findings first for reviews.

## 6. What Risks Require Human Review?

List risks that should never be buried in a final summary.

- Security-sensitive behavior changed.
- Public API behavior changed.
- Database schema or migration changed.
- Dependency versions changed.
- Generated files or snapshots changed.
- Tests could not be run.
- Behavior was inferred because requirements were incomplete.
- External service behavior could not be verified.

## 7. What Should Be Copied Into The Repo?

Minimum useful setup:

- `AGENTS.md`
- One or two task templates from `templates/`
- Relevant language example from `examples/languages/`
- `snippets/approval-rules.md`
- `snippets/stop-conditions.md`
- `snippets/final-response-format.md`

Better setup:

- Add loop recipes for the team's most common tasks.
- Add exact check commands to `AGENTS.md`.
- Add known gotchas for generated files, fixtures, snapshots, and CI-only checks.
