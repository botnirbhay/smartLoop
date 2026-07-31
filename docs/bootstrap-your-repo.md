# Bootstrap Your Repository

Use this workflow to create a project-specific `AGENTS.md` from an existing repository. It deliberately separates discovery from editing so a human can review inferred commands and guardrails first.

## Phase 1: Discover

Open the target repository in your coding agent and paste:

```text
Inspect this repository to prepare a project-specific AGENTS.md.

This is a read-only discovery step. Do not edit, create, move, or delete files. Do not install dependencies, make network calls, or run migrations.

Inspect the repository structure and relevant source-of-truth files, including package manifests, task runners, CI workflows, test configuration, contribution docs, architecture docs, and existing agent instructions.

Report:
1. Languages, frameworks, package managers, and major project areas.
2. Focused and full test commands that are explicitly supported.
3. Lint, format-check, typecheck, build, and documentation commands.
4. Commands that are slow, destructive, network-dependent, or require services or credentials.
5. Generated, vendored, sensitive, migration, fixture, snapshot, and build-output files.
6. Existing repository conventions that agents should follow.
7. Actions that should require human approval.
8. Missing or ambiguous information that must not be guessed.

For every proposed command, cite the repository file where it was found. Do not invent commands or policies.

Return a proposed AGENTS.md outline, but do not write it yet.
```

## Human Review

Before approving the proposal, verify:

- Commands exist in manifests, scripts, task files, CI, or project docs.
- Format commands will not rewrite unrelated files.
- Integration tests and broad checks are clearly labeled.
- Generated and vendored paths are correct.
- Dependency, migration, security, secret, network, and deployment changes require approval.
- Repository-specific architecture boundaries are represented.
- Unknown information remains unknown instead of being filled with assumptions.

Correct the proposal before moving to Phase 2.

## Phase 2: Create

After reviewing the proposal, paste:

```text
Create AGENTS.md from the approved proposal.

Requirements:
- Keep it concise and project-specific.
- Include the normal inspect, edit, test, check, retry, and stop loop.
- Include exact supported commands and when each should run.
- Distinguish focused checks from broad checks.
- Identify files or directories that should not be edited by hand.
- Include allowed actions and ask-first actions.
- Stop after 3 failed attempts on the same issue.
- Require a final response with summary, files changed, checks run, and remaining risks or follow-ups.
- If another instruction file already owns some rules, reference it instead of duplicating conflicting guidance.

After writing the file, verify that every command has a repository source, risky actions require approval, retries are bounded, unrun checks cannot be presented as passing, and unresolved placeholders or ambiguity are reported. Report anything that still requires human input.
```

## Expected Result

The target repository should need only the files it will actively maintain:

```text
target-repository/
|-- AGENTS.md
|-- src/
|-- tests/
`-- ...
```

Teams may also copy selected recipes into `docs/agent-workflows/`, but copying the entire kit is unnecessary.

## Keep It Current

Review `AGENTS.md` when:

- Package scripts or task runners change.
- CI adds or removes required checks.
- Generated paths, migrations, or architecture boundaries change.
- The team repeatedly corrects the same agent behavior.
- A check is consistently unavailable, slow, or flaky.

Treat repeated prompting as evidence that a stable repository rule may be missing.
