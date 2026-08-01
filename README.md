# AI Agent Loop Kit

> Create reliable, repository-specific working rules for coding agents without repeating the same operational prompt on every task.

AI Agent Loop Kit provides a bootstrap workflow, complete `AGENTS.md` presets, task recipes, approval guardrails, check policies, and validation tools. It is Markdown-first, vendor-neutral, and dependency-free.

The bootstrap workflow includes reusable guidance for nested packages, side-effectful scripts, runtime state, service-dependent checks, and scoped instruction files. See [Repository Discovery Patterns](docs/discovery-patterns.md).

## The Promise

Define once per repository:

- How agents inspect, edit, test, retry, and stop.
- Which commands validate a change.
- Which files and actions require human approval.
- What every final handoff must report.

The loop is vendor-neutral. `AGENTS.md` is the canonical policy used by this kit; if your agent uses another instruction filename or configuration surface, adapt the same content there. See [Agent Compatibility](docs/agent-compatibility.md).

## Quick Start

| Your situation | Start here |
| --- | --- |
| Existing repository | [Bootstrap Your Repository](docs/bootstrap-your-repo.md) |
| New repository | [Complete AGENTS.md Presets](presets/) |
| Evaluating the kit | [Worked Adoption Example](examples/adoption/) |
| Team rollout | [Adoption Checklist](docs/adoption-checklist.md) |
| Existing setup needs review | [Quality Checklist](docs/quality-checklist.md) |

## Start With Your Own Repository

The recommended setup uses the agent to inspect the target repository before creating any policy:

1. Open the target repository in your coding agent.
2. Run the read-only discovery prompt in [Bootstrap Your Repository](docs/bootstrap-your-repo.md).
3. Review the discovered commands, protected files, approval points, and unknowns.
4. Approve or correct the proposal.
5. Ask the agent to create a project-specific `AGENTS.md`.
6. Paste the read-only prompt from [Test Your Setup](docs/test-your-setup.md).

Start with [START-HERE.md](START-HERE.md) for the compact version.

The target repository normally keeps only:

```text
your-project/
|-- AGENTS.md
|-- src/
|-- tests/
+-- ...
```

Copy selected workflows into the project only when the team will maintain and use them. Do not copy this entire kit by default.

## What Changes After Adoption

Before:

```text
Inspect the code first. Keep the change small. Add tests. Run npm test and
npm run typecheck. Do not change migrations or dependencies. Retry failures,
but stop after three attempts. Report files changed and anything unverified.

Fix the settings bug.
```

After:

```text
Follow AGENTS.md.

Fix the settings bug.
Definition of done: the timezone persists and a regression test covers it.
```

The repository owns stable working rules. Each prompt supplies only the task-specific outcome and context.

## Copy This Prompt Into Your Agent

```text
Follow AGENTS.md.

Task: <describe the change>
Context: <files, logs, issue links, constraints, or examples>
Definition of done: <observable result>
Checks: <commands to run, or say none are known>

Inspect relevant files before editing. Make the smallest safe change. Add or update tests when behavior changes. If checks fail, inspect the error, fix the cause, and rerun. Stop when checks pass, blocked, or after 3 failed attempts. Final response: summary, files changed, checks run, remaining risks.
```

For the full version, use `docs/golden-prompt.md`.

## What Is Included

| Directory | Purpose |
| --- | --- |
| [presets/](presets/) | Complete minimal, Node.js, Python, Go, and Rust policies |
| [docs/loop-recipes/](docs/loop-recipes/) | Bugfix, failing-test, refactor, review, docs, and test workflows |
| [templates/](templates/) | Structured task briefs and repository onboarding |
| [snippets/](snippets/) | Reusable testing, security, approval, and stop policies |
| [examples/languages/](examples/languages/) | Stack-specific commands and gotchas |
| [examples/adoption/](examples/adoption/) | End-to-end discovery, policy, task, and handoff |
| [docs/discovery-patterns.md](docs/discovery-patterns.md) | Generic repository discovery risks and responses |

See [START-HERE.md](START-HERE.md) for adoption steps and [Agent Compatibility](docs/agent-compatibility.md) when a tool uses a different instruction mechanism.

## Who This Is For

- Developers who use coding agents repeatedly in the same repositories.
- Teams that want more consistent AI-assisted development workflows.
- Maintainers who want agents to run checks and stop safely.
- Reviewers who want predictable final responses and clear risk reporting.
- Anyone tired of pasting the same operational prompt into every task.

## What This Is Not

- Not a framework.
- Not a package or CLI.
- Not a general-purpose agent orchestration system; it is focused on agents that work in code repositories.
- Not a replacement for tests, CI, code review, or human judgment.
- Not a claim that every agent supports the same files, tools, permissions, or level of autonomy.
- Not a fake sample app with dependencies you have to maintain.

It is a lightweight set of practical Markdown files you can copy, edit, and improve.

## Contributing

Contributions should stay practical and dependency-free. Prefer a copy-pasteable recipe, policy, check command, or real-world gotcha over abstract guidance. See [CONTRIBUTING.md](CONTRIBUTING.md).

## Core Idea

**The task prompt says what to do. The repository policy says how work is done.**
