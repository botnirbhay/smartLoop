# Approval Rules

Use this section in `AGENTS.md` to separate routine work from actions that need human approval.

```md
## Approval Rules

Allowed without asking:

- Read files and inspect repository structure.
- Edit source, tests, docs, examples, and markdown files.
- Create new tests, documentation, and task templates.
- Run existing lint, format, typecheck, test, and build commands.
- Make small scoped fixes required by the task.

Ask first:

- Delete files or large blocks of code.
- Run destructive shell commands.
- Install, remove, upgrade, or replace dependencies.
- Run database migrations or alter persisted data.
- Change authentication, authorization, or security-sensitive behavior.
- Edit secrets, credentials, tokens, keys, or private environment values.
- Make network calls or access external services.
- Change deployment, infrastructure, billing, or production configuration.
```
