# Stop Conditions

Stop conditions define when a coding agent should finish, report a blocker, or avoid further changes.

## Stop Successfully When

- The requested task is complete and relevant checks pass.
- The requested task is complete and no check command exists.
- Documentation-only changes are complete and no documentation check exists.

## Stop As Blocked When

- Required context is missing and cannot be inferred safely.
- Required files, commands, services, credentials, or permissions are unavailable.
- The change requires approval and approval has not been granted.
- A check depends on an unavailable external service.

## Stop After Failed Attempts

Stop after 3 failed attempts for the same failing check or error.

When stopping after failed attempts, report:

- The command that failed.
- The recurring error.
- What was tried.
- The likely next step.

## Suggested Prompt Text

```text
If checks fail, inspect the error, fix the likely cause, and rerun.
Stop when checks pass, when blocked, or after 3 failed attempts for the same issue.
```
