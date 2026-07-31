# Stop Conditions

Use this section in `AGENTS.md` to keep an agent from looping indefinitely.

```md
## Stop Conditions

Stop successfully when:

- The requested task is complete and relevant checks pass.
- The requested task is complete and no check command exists.
- Documentation-only changes are complete and no documentation check exists.

Stop as blocked when:

- Required context is missing and cannot be inferred safely.
- Required files, commands, services, credentials, or permissions are unavailable.
- The next action requires approval and approval has not been granted.
- A check depends on an unavailable external service.

Stop after 3 failed attempts for the same failing check or error. Report the command, recurring error, what was tried, and the likely next step.
```
