# Security Guardrails

Use this section in `AGENTS.md` for repositories with sensitive code or configuration.

```md
## Security Guardrails

Treat the following as approval-required:

- Authentication or authorization behavior changes.
- Permission checks, roles, policies, session handling, or token handling.
- Secrets, credentials, keys, signing material, or private environment variables.
- Encryption, hashing, audit logging, or security monitoring changes.
- Network calls to external systems.
- Production, deployment, infrastructure, or billing configuration.

Never print secrets in logs or final responses.
If a task touches security-sensitive behavior, call it out in the final response and list what was verified.
```
