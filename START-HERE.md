# Start Here

Use AI Agent Loop Kit to create project-specific working rules for a coding agent.

Do not copy the whole kit into your project. Start with one of these paths.

## Fastest Path

Run from the target repository.

POSIX shell:

```sh
curl -fsSL https://raw.githubusercontent.com/botnirbhay/smartLoop/main/scripts/init.sh | sh
```

Windows PowerShell:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/botnirbhay/smartLoop/main/scripts/init.ps1)))
```

Review the generated `AGENTS.md`, then paste the read-only smoke-test prompt from [Test Your Setup](docs/test-your-setup.md).

## Manual Path: Existing Repository

1. Open your repository in your coding agent.
2. Paste the discovery prompt from [Bootstrap Your Repository](docs/bootstrap-your-repo.md).
3. Review the commands, protected files, and approval rules the agent discovers.
4. Approve or correct the proposal.
5. Ask the agent to create `AGENTS.md`.
6. Paste the read-only smoke-test prompt from [Test Your Setup](docs/test-your-setup.md).

This path produces rules based on the repository that actually exists.

Review [Repository Discovery Patterns](docs/discovery-patterns.md) for common issues involving nested packages, helper scripts, runtime state, services, and existing instruction files.

## Preset Path: New Repository

Copy one complete preset:

- [Minimal](presets/minimal/AGENTS.md)
- [Node.js](presets/node/AGENTS.md)
- [Python](presets/python/AGENTS.md)
- [Go](presets/go/AGENTS.md)
- [Rust](presets/rust/AGENTS.md)

Replace every placeholder, remove commands the project does not support, and run the setup smoke test.

## Team Path

After the basic setup works:

1. Add the team's most common workflows from [Loop Recipes](docs/loop-recipes/).
2. Use [Task Templates](templates/) in issues or task descriptions.
3. Record security and large-refactor rules from [Snippets](snippets/).
4. Evaluate the result with the [Quality Checklist](docs/quality-checklist.md).
5. Keep the documented local checks aligned with CI.

## First Task

Once setup is validated, task prompts can stay small:

```text
Follow AGENTS.md.

Task: <specific change>
Definition of done: <observable result>
```

The task says what to do. The repository policy says how work is done.
