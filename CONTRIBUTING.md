# Contributing

AI Agent Loop Kit should remain small, vendor-neutral, and useful without installing anything.

## Good Contributions

- A loop recipe for a recurring repository task.
- A language or framework example with real commands and caveats.
- A reusable policy snippet with clear approval or stop conditions.
- A task template that improves context, constraints, or verification.
- A correction that makes an example safer or more portable.

## Contribution Rules

- Keep changes Markdown-first and dependency-free.
- Use generic terms such as agent or coding agent unless a section is explicitly tool-specific.
- Do not claim that all agents support the same instruction files, tools, permissions, or context behavior.
- Use placeholders for project-specific paths, commands, and credentials.
- Never include real secrets, tokens, private URLs, or proprietary source.
- Prefer commands already common to the documented ecosystem.
- Explain when a command formats files in place, needs network access, or depends on external services.

## Adding A Recipe

A recipe should include:

- When to use it.
- Loop steps.
- Agent prompt.
- Checks to run.
- Stop conditions.
- Human approval points.
- Expected final response.

## Adding A Language Example

A language example should include:

- Typical aggregate check command.
- Lint command.
- Format or format-check command.
- Test command.
- Sample `AGENTS.md` snippet.
- Common gotchas.

Commands are examples, not universal defaults. Note important alternatives instead of presenting one toolchain as mandatory.

## Review Checklist

- Links point to files that exist.
- Examples are copy-pasteable after replacing obvious placeholders.
- Approval rules cover destructive or security-sensitive actions.
- Stop conditions prevent unlimited retries.
- No vendor-specific wording appears outside an intentional compatibility note.
- No dependency or fake runnable project was added.

This repository has no configured automated checks. Review Markdown structure, links, terminology, and changed examples before submitting.
