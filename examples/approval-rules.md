# Approval Rules

Use this file as a starter policy for what a coding agent may do without asking and what needs approval.

## Allowed Without Asking

- Read files.
- Inspect repository structure.
- Edit markdown, source, tests, and examples.
- Create new documentation/templates.
- Run existing lint, format, typecheck, test, and build commands.
- Make small, scoped fixes required by the task.

## Ask First

- Delete files.
- Run destructive shell commands.
- Upgrade or replace dependencies.
- Run database migrations.
- Change authentication or authorization behavior.
- Change security-sensitive code.
- Edit secrets, credentials, tokens, keys, or environment-specific private values.
- Make network calls.
- Change deployment, infrastructure, billing, or production configuration.

## Suggested Prompt Text

```text
Follow AGENTS.md. You may read files, edit source/tests/docs, and run existing checks without asking.
Ask before deleting files, running destructive commands, upgrading dependencies, running migrations, changing auth/security behavior, editing secrets, or making network calls.
```

## Notes

Approval rules should be stricter for production systems, regulated environments, and repositories that manage infrastructure or credentials.
