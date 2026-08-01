# Repository Discovery Patterns

These patterns capture common problems found while turning an existing repository into reliable coding-agent instructions. They are stack-neutral and apply whether the project uses one language, several packages, generated assets, local services, or existing instruction files.

Use them during the read-only discovery phase in [Bootstrap Your Repository](bootstrap-your-repo.md).

## 1. Existing Instructions May Be Incomplete

Finding `AGENTS.md` or another instruction file does not mean repository onboarding is complete.

An existing file may only:

- Connect a memory or orchestration tool.
- Apply to one subdirectory.
- Describe a narrow workflow.
- Contain generated context.
- Serve as an example or product artifact.

Discovery should classify the file's purpose, preserve valid rules, and report missing checks, boundaries, approvals, stop conditions, and handoff requirements.

Do not replace an existing integration bridge when it can be extended or referenced safely.

## 2. Commands Need A Working Directory

Multi-package and mixed-stack repositories often place commands in nested manifests.

A useful command record includes:

| Field | Example |
| --- | --- |
| Purpose | Frontend tests |
| Command | `npm test` |
| Working directory | `web/` |
| Source | `web/package.json` |
| Prerequisites | Dependencies installed |
| Side effects | Test cache or coverage output |

Do not list a command without saying where it must run. Prefer repository wrapper commands when they coordinate several packages.

## 3. Command Names Do Not Reveal Side Effects

Inspect helper scripts before recommending them.

A script named `check`, `start`, `stop`, `reset`, or `e2e` may:

- Delete runtime directories.
- Prune worktrees or branches.
- Create or overwrite environment files.
- Truncate logs.
- Start long-running services.
- Stop matching processes.
- Initialize repositories or modify external state.

Classify commands as:

- Routine validation.
- Formatting or source mutation.
- Long-running development process.
- External-service operation.
- Destructive or state-changing operation.

Only routine validation belongs in the default finish loop. Other classes need explicit handling or approval.

## 4. Runtime State Is Not Source Code

Repositories often contain local state alongside source files:

- Uploaded files and local databases.
- Search indexes and generated metadata.
- Logs, caches, coverage, and build output.
- Compiled binaries.
- Process ID files and lock files.
- Local environment files.
- Managed worktrees or task directories.

Use `.gitignore`, runtime code, scripts, and project docs to identify these paths. State whether an agent should avoid them, regenerate them, preserve them, or ask before clearing them.

Never infer that an ignored file is disposable. It may contain valuable local state.

## 5. Instruction Files Can Be Product Artifacts

Some repositories store multiple `AGENTS.md` files because those files are templates, examples, generated assets, or the product itself.

Classify each instruction file as one of:

- Active root policy.
- Scoped subdirectory policy.
- Tool integration bridge.
- Generated context.
- Example or template.
- Product artifact.

Apply policy according to scope. Do not merge every file into root instructions based only on its filename.

## 6. Checks May Depend On Services

Tests and builds can require:

- Databases, containers, browsers, or emulators.
- Local model servers.
- Credentials or private environment values.
- Network access.
- Platform-specific tools.
- Particular feature flags or build tags.

Record prerequisites next to the command. If a required service is unavailable, the agent should report the check as unavailable rather than claim success or silently substitute a different check.

## 7. Focused And Broad Checks Serve Different Roles

Repository instructions should distinguish:

- A focused test for the changed package, module, or behavior.
- A broad test suite for shared or cross-cutting changes.
- Static checks such as lint and typecheck.
- Builds that validate packaging or compilation.
- Integration or end-to-end checks with additional risk or cost.

Run the smallest relevant check first. Escalate to broad checks when the change affects shared APIs, configuration, generated output, or multiple packages.

## Discovery Output Standard

For every proposed command, report:

- Purpose.
- Exact command.
- Source file.
- Working directory.
- Prerequisites.
- Side effects.
- Whether human approval is required.

For every instruction file, report:

- Scope.
- Purpose.
- Whether it should be preserved, extended, referenced, or ignored during root-policy creation.

For every important non-source path, report:

- What creates it.
- Whether it is safe to edit or remove.
- How changes should be made.
- Whether approval is required.

These details make the resulting policy portable across repositories without assuming that a familiar filename or command behaves the same everywhere.
