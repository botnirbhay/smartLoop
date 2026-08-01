# AGENTS.md Quality Checklist

Use this rubric after creating or reviewing a repository's agent instructions. Score each area from 0 to 2.

- 0: Missing or unsafe.
- 1: Present but generic or incomplete.
- 2: Specific, actionable, and verified against the repository.

## 1. Repository Context

- The project purpose and important directories are clear.
- Architecture boundaries or ownership rules are stated when relevant.
- Existing contribution and policy files are referenced rather than contradicted.
- Existing instruction files are classified by scope and purpose before reuse.

Score:

## 2. Commands

- Focused and broad test commands are distinguished.
- Lint, format-check, typecheck, build, and docs commands are exact.
- Each command exists in a manifest, task runner, CI file, or project document.
- Commands from nested packages state the required working directory.
- Slow, flaky, service-dependent, credential-dependent, or network-dependent checks are labeled.
- Helper scripts with destructive, state-changing, or process-control behavior are not treated as routine checks.

Score:

## 3. Editing Boundaries

- Generated, vendored, build-output, migration, fixture, and snapshot paths are identified.
- Runtime state, caches, logs, local environment files, and compiled artifacts are identified when relevant.
- Rules explain how generated output should be changed.
- Broad cleanup and unrelated refactors are discouraged.

Score:

## 4. Testing Policy

- Behavior changes require tests when practical.
- Bugfixes call for regression tests.
- Refactors require behavior-preserving checks.
- The policy explains what to report when tests cannot run.

Score:

## 5. Approval Rules

- Routine read, edit, and check actions are clearly allowed.
- Deletion, destructive commands, dependency changes, migrations, security changes, secrets, network calls, and deployment changes require approval.
- Project-specific high-risk actions are included.

Score:

## 6. Failure And Stop Conditions

- The task is converted into observable definition-of-done items before editing.
- Required layers are identified so a feature cannot stop at a partial artifact.
- Check failures trigger inspection and targeted fixes.
- Retries are bounded.
- An unchanged failure cannot be rerun without a new implementation, environment, or diagnostic hypothesis.
- Consecutive no-progress iterations have a stop limit.
- Missing context, permissions, services, or approval produces a clear blocker.
- Completion requires either passing checks or an explicit report of unavailable checks.

Score:

## 7. Final Handoff

- The final response requires a summary.
- Important files changed are listed.
- Completed and unmet definition-of-done items are visible.
- Commands and outcomes are reported.
- Unverified behavior, remaining risks, and follow-ups are visible.

Score:

## Result

Add the seven section scores.

- 12-14: Strong. Ready for routine use.
- 9-11: Usable. Improve the lowest-scoring sections.
- 5-8: Generic. The agent will still need repeated prompting.
- 0-4: Unsafe or incomplete. Revisit repository discovery.

## Hard Failures

Do not consider the setup ready when:

- Commands were guessed.
- Destructive or security-sensitive actions lack approval rules.
- Generated or sensitive files are known but undocumented.
- The agent can loop without a retry limit.
- The policy allows repeated scans or unchanged command retries without new evidence.
- The agent may stop before all required layers and definition-of-done items are complete.
- Unrun checks can be presented as passing.
- Task history, transient failures, secrets, or machine-specific state can be written into `AGENTS.md` as learning.
- The policy conflicts with a stronger repository rule.
