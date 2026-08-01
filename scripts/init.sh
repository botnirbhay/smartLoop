#!/bin/sh
set -eu

dry_run=0
target='.'

usage() {
  cat <<'EOF'
SmartLoop initializer
Usage: init.sh [--dry-run] [--target PATH]
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run) dry_run=1; shift ;;
    --target) [ "$#" -ge 2 ] || exit 64; target=$2; shift 2 ;;
    --help|-h) usage; exit 0 ;;
    *) echo "error: unknown option: $1" >&2; usage >&2; exit 64 ;;
  esac
done

[ -d "$target" ] || { echo "error: target directory does not exist: $target" >&2; exit 66; }
target=$(cd "$target" && pwd)
output="$target/AGENTS.md"

if [ -e "$output" ] && [ "$dry_run" -eq 0 ]; then
  echo "error: $output already exists; SmartLoop will not overwrite it." >&2
  echo 'Run with --dry-run to preview a newly detected policy.' >&2
  exit 2
fi

project=$(basename "$target")
stacks=''
checks=''
boundaries=''
notes=''

add_stack() {
  case ",$stacks," in
    *",$1,"*) ;;
    *) [ -n "$stacks" ] && stacks="$stacks, $1" || stacks=$1 ;;
  esac
}

add_check() { checks="${checks}- $1: \`$2\` (source: \`$3\`; run from: \`$4\`).\n"; }
add_boundary() {
  boundary_line="- \`$1\`"
  case "$boundaries" in
    *"$boundary_line"*) ;;
    *) boundaries="${boundaries}${boundary_line}\n" ;;
  esac
}
add_note() { notes="${notes}- $1\n"; }

has_package_script() {
  command -v node >/dev/null 2>&1 || return 1
  node -e '
    const fs = require("node:fs");
    const data = JSON.parse(fs.readFileSync(process.argv[1], "utf8"));
    process.exit(data.scripts && Object.prototype.hasOwnProperty.call(data.scripts, process.argv[2]) ? 0 : 1);
  ' "$1" "$2"
}

package_manager_for() {
  if [ -f "$1/pnpm-lock.yaml" ]; then printf '%s' 'pnpm'
  elif [ -f "$1/yarn.lock" ]; then printf '%s' 'yarn'
  elif [ -f "$1/bun.lockb" ] || [ -f "$1/bun.lock" ]; then printf '%s' 'bun'
  else printf '%s' 'npm'
  fi
}

inspect_node_manifest() {
  manifest=$1
  [ -f "$manifest" ] || return 0
  add_stack 'Node.js'
  package_dir=$(dirname "$manifest")
  relative_manifest=${manifest#"$target/"}
  relative_dir=${package_dir#"$target"}
  relative_dir=${relative_dir#/}
  [ -n "$relative_dir" ] || relative_dir='.'
  package_manager=$(package_manager_for "$package_dir")

  for package_file in package-lock.json pnpm-lock.yaml yarn.lock bun.lock bun.lockb .env .env.local node_modules .next coverage
  do
    [ -e "$package_dir/$package_file" ] || continue
    if [ "$relative_dir" = '.' ]; then
      boundary_path=$package_file
    else
      boundary_path="$relative_dir/$package_file"
    fi
    case "$package_file" in
      *lock*) add_boundary "$boundary_path (change only for intentional dependency work)" ;;
      *) add_boundary "$boundary_path" ;;
    esac
  done

  if command -v node >/dev/null 2>&1; then
    for script_name in test lint typecheck build format:check check
    do
      has_package_script "$manifest" "$script_name" || continue
      case "$script_name" in
        test) label='Tests' ;;
        lint) label='Lint' ;;
        typecheck) label='Typecheck' ;;
        build) label='Build' ;;
        format:check) label='Format check' ;;
        check) label='Repository check' ;;
      esac
      add_check "$label" "$package_manager run $script_name" "$relative_manifest" "$relative_dir"
    done
  else
    add_note "Node.js manifest found at \`$relative_manifest\`, but Node.js was unavailable; inspect its scripts manually."
  fi
}

for relative in package.json web/package.json frontend/package.json client/package.json server/package.json
do
  inspect_node_manifest "$target/$relative"
done

for container in apps packages
do
  [ -d "$target/$container" ] || continue
  for package_dir in "$target/$container"/*
  do
    [ -d "$package_dir" ] || continue
    inspect_node_manifest "$package_dir/package.json"
  done
done

python_files=''
for file in "$target/pyproject.toml" "$target/requirements.txt" "$target/requirements-dev.txt" "$target/setup.cfg" "$target/tox.ini" "$target/pytest.ini"
do
  [ -f "$file" ] || continue
  python_files="$python_files $file"
done

if [ -n "$python_files" ]; then
  add_stack 'Python'
  python_command='python'
  if [ -x "$target/.venv/bin/python" ]; then
    python_command='.venv/bin/python'
    add_note '- Python checks use the detected `.venv` interpreter; recreate the environment if it is stale.'
  fi
  grep -Eiq 'pytest' $python_files && add_check 'Tests' "$python_command -m pytest" 'Python project configuration' '.'
  if grep -Eiq '(^|[^[:alnum:]_])ruff([^[:alnum:]_]|$)' $python_files; then
    ruff_command=''
    if [ -x "$target/.venv/bin/ruff" ]; then
      ruff_command='.venv/bin/ruff'
    elif command -v ruff >/dev/null 2>&1; then
      ruff_command='ruff'
    fi
    if [ -n "$ruff_command" ]; then
      add_check 'Lint' "$ruff_command check ." 'Python project configuration and detected executable' '.'
      add_check 'Format check' "$ruff_command format --check ." 'Python project configuration and detected executable' '.'
    else
      add_note '- Ruff is configured, but no Ruff executable was detected. Install the project dev tools or document the repository runner before adding Ruff checks.'
    fi
  fi
  if grep -Eiq '(^|[^[:alnum:]_])mypy([^[:alnum:]_]|$)' $python_files; then
    mypy_command=''
    if [ -x "$target/.venv/bin/mypy" ]; then
      mypy_command='.venv/bin/mypy'
    elif command -v mypy >/dev/null 2>&1; then
      mypy_command='mypy'
    fi
    if [ -n "$mypy_command" ]; then
      add_check 'Typecheck' "$mypy_command ." 'Python project configuration and detected executable' '.'
    else
      add_note '- mypy is configured, but no mypy executable was detected. Install the project dev tools or document the repository runner before adding mypy checks.'
    fi
  fi
fi

if [ -f "$target/go.mod" ]; then
  add_stack 'Go'
  add_check 'Tests' 'go test ./...' 'go.mod and standard Go tooling' '.'
  add_check 'Static checks' 'go vet ./...' 'go.mod and standard Go tooling' '.'
  add_check 'Format check' 'gofmt -l <changed-go-files>' 'go.mod and standard Go tooling' '.'
fi

if [ -f "$target/Cargo.toml" ]; then
  add_stack 'Rust'
  add_check 'Tests' 'cargo test' 'Cargo.toml' '.'
  add_check 'Compile check' 'cargo check' 'Cargo.toml' '.'
  add_check 'Lint' 'cargo clippy' 'Cargo.toml' '.'
  add_check 'Format check' 'cargo fmt --check' 'Cargo.toml' '.'
fi

[ -n "$stacks" ] || stacks='Unknown; inspect repository documentation before adding commands'

for relative_path in .env .env.local .venv node_modules .next dist build out coverage target __pycache__ data/uploads data/logs data/vector_index generated src/generated prisma/migrations migrations
do
  [ -e "$target/$relative_path" ] && add_boundary "$relative_path"
done

for lockfile in go.sum Cargo.lock
do
  [ -f "$target/$lockfile" ] && add_boundary "$lockfile (change only for intentional dependency work)"
done

[ -n "$checks" ] || checks='- No supported check command was discovered. Inspect project documentation and CI before adding one.\n'
[ -n "$boundaries" ] || boundaries='- No project-specific generated or local-state paths were detected. Review .gitignore and helper scripts.\n'
[ -n "$notes" ] || notes='- Review helper scripts, CI, and nested instruction files before treating this generated policy as complete.\n'

render() {
  cat <<'EOF'
# AGENTS.md

Working instructions for coding agents in this repository.

## Repository Context

EOF
  printf '%s\n' "- Project: $project"
  printf '%s\n\n' "- Detected stack: $stacks"
  cat <<'EOF'
This file was generated from local repository evidence. Review it before routine use.

## Completion Contract

- Before editing, derive an observable definition-of-done checklist from the request and repository evidence.
- If details are missing, infer the smallest coherent outcome and proceed. Ask only when approval is required or a safe decision is impossible.
- Identify every affected layer, such as user interface, API, domain logic, persistence, tests, and documentation. Include only layers the task actually requires.
- Do not stop after producing one artifact when the requested behavior requires integration across layers.
- The task is complete only when every checklist item is satisfied and relevant checks pass or are explicitly unavailable.

## Autonomous Working Loop

1. Observe: inspect relevant instructions, source, callers, tests, configuration, and current behavior.
2. Decide: choose the next smallest coherent step that closes a definition-of-done item.
3. Act: make the scoped change, including tests or documentation required by that step.
4. Check: inspect the diff and run the smallest relevant validation.
5. Repeat while an unmet checklist item remains.
6. After focused checks pass, run required broader checks once and audit the result against the full checklist.

## Loop Guardrails

- Every iteration must produce new evidence or measurable progress. Stop after 2 consecutive no-progress iterations and report the blocker.
- Never rerun an unchanged failing command without changing code, configuration, environment, or the diagnostic hypothesis.
- Stop after 3 failed attempts for the same failure. Report the command, error, attempted fixes, and next useful action.
- Prefer targeted reads and focused checks. Do not repeatedly scan the repository after the relevant area is known.
- Do not expand into unrelated cleanup, speculative features, or architectural rewrites.
- Respect approval boundaries and host tool, time, and token limits. Never claim an unrun check passed.

## Durable Learning

- Do not edit this file to record task history.
- Update it only when the task reveals a stable repository-wide command, boundary, convention, or prerequisite that is missing or incorrect.
- Verify the fact from source-of-truth files and keep the update concise. Never record guesses, transient failures, secrets, personal data, or generated state.

## Checks

EOF
  printf '%b\n' "$checks"
  cat <<'EOF'
Run commands from the documented working directory. Do not invent replacements for missing commands. Report unavailable checks in the final response.

## Testing Policy

- Add regression coverage for bugfixes when practical.
- Add tests for new behavior and meaningful failure paths.
- Preserve behavior during refactors.
- Do not weaken tests merely to make them pass.

## Detected Editing Boundaries

Do not edit generated, vendored, build, cache, runtime-state, or local environment files by hand:

EOF
  printf '%b\n' "$boundaries"
  cat <<'EOF'
Inspect .gitignore, helper scripts, and project documentation before deleting or regenerating local state.

## Approval Rules

Allowed without asking:

- Read files and inspect repository structure.
- Edit scoped source, tests, docs, and examples.
- Run existing routine validation commands.

Ask first:

- Delete files or run destructive or state-changing commands.
- Install, remove, or upgrade dependencies.
- Change lockfiles, migrations, generated output, or persisted data.
- Start or stop services and processes.
- Change authentication, authorization, or security-sensitive behavior.
- Edit secrets, credentials, or private environment values.
- Make network calls or access external services.
- Change deployment, infrastructure, billing, or production configuration.

## Discovery Notes

EOF
  printf '%b\n' "$notes"
  cat <<'EOF'
## Final Response

Include:

- Summary
- Files changed
- Definition of done: completed items and any unmet item
- Checks run and outcomes
- Remaining risks or follow-ups
EOF
}

if [ "$dry_run" -eq 1 ]; then
  [ -e "$output" ] && echo "warning: $output already exists; showing a detection preview only." >&2
  render
  exit 0
fi

umask 022
set -C
if ! render > "$output"; then
  echo "error: could not create $output without overwriting an existing file." >&2
  exit 1
fi
set +C

echo "Created $output"
echo "Detected stack: $stacks"
echo 'Review the generated commands and boundaries before routine agent work.'
