# Initializer Scripts

SmartLoop provides self-contained initializers for POSIX shells and Windows PowerShell.

## Behavior

Both scripts:

- Inspect only the selected target directory.
- Detect root and common nested Node.js manifests.
- Detect configured Python, Go, and Rust tooling conservatively.
- Use a detected Python `.venv` and report configured tools whose executables are unavailable.
- Record command sources and working directories.
- Detect common local-state and dependency files.
- Generate one `AGENTS.md`.
- Include an autonomous completion loop, bounded retries, no-progress limits, and durable-learning rules.
- Refuse to overwrite an existing `AGENTS.md`.
- Support dry-run mode.
- Do not install dependencies or run project commands.

## Local Usage

POSIX:

```sh
sh scripts/init.sh --dry-run --target /path/to/repository
```

PowerShell:

```powershell
.\scripts\init.ps1 -DryRun -Target C:\path\to\repository
```

Remove dry-run only after reviewing the generated preview.

## Limitations

- The scripts use conservative file detection, not semantic understanding of the whole repository.
- The POSIX initializer needs Node.js to parse `package.json` scripts. Without Node.js, it reports the manifest for manual review.
- Commands hidden only in prose, custom scripts, CI services, or unusual workspace layouts may require manual additions.
- Existing instruction files require manual merging because the initializer never overwrites them.
- Generated policies should be reviewed with `docs/quality-checklist.md`.

For deeper discovery, use `docs/bootstrap-your-repo.md`.
