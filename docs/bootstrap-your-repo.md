# Bootstrap Your Repository

Use this workflow to create a project-specific `AGENTS.md` from an existing repository. It deliberately separates discovery from editing so a human can review inferred commands and guardrails first.

## Phase 1: Discover

Open the target repository in your coding agent and paste:

```text
Inspect this repository to prepare a project-specific AGENTS.md.

This is a read-only discovery step. Do not edit, create, move, or delete files. Do not install dependencies, make network calls, or run migrations.

Inspect the repository structure and relevant source-of-truth files, including root and nested package manifests, task runners, helper scripts, CI workflows, test configuration, contribution docs, architecture docs, and existing agent instructions.

Report:
1. Languages, frameworks, package managers, and major project areas.
2. Focused and full test commands that are explicitly supported.
3. Lint, format-check, typecheck, build, and documentation commands.
4. The required working directory for every command found in a nested package or workspace.
5. Commands and helper scripts that are slow, destructive, state-changing, network-dependent, process-controlling, or require services or credentials.
6. Generated, vendored, sensitive, migration, fixture, snapshot, runtime-state, cache, log, and build-output files.
7. Existing instruction files, classified as active repository policy, scoped subdirectory policy, generated bridge, example, template, or product artifact.
8. Existing repository conventions that agents should follow.
9. Actions that should require human approval.
10. Missing or ambiguous information that must not be guessed.

For every proposed command, cite the repository file where it was found, state its working directory, and note important side effects or prerequisites. Do not invent commands or policies.

Return a proposed AGENTS.md outline, but do not write it yet.
```

## Human Review

Before approving the proposal, verify:

- Commands exist in manifests, scripts, task files, CI, or project docs.
- Commands from nested packages include the correct working directory.
- Format commands will not rewrite unrelated files.
- Helper scripts were inspected before being recommended.
- Integration tests and broad checks are clearly labeled.
- Generated and vendored paths are correct.
- Runtime state, logs, caches, local environment files, and process-control scripts are classified.
- Existing instruction files were classified by scope and purpose instead of merged blindly.
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
- Include required working directories and prerequisites for nested-project commands.
- Distinguish focused checks from broad checks.
- Identify files or directories that should not be edited by hand.
- Preserve existing instruction bridges and scoped policies; do not promote examples, templates, or product artifacts into root policy.
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

See [Repository Discovery Patterns](discovery-patterns.md) for reusable guidance on incomplete existing policies, nested package commands, helper-script side effects, runtime state, service prerequisites, and instruction files that are artifacts rather than active policy.
