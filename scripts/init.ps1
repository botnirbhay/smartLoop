[CmdletBinding()]
param(
    [switch]$DryRun,
    [string]$Target = '.'
)

$ErrorActionPreference = 'Stop'
$targetPath = (Resolve-Path -LiteralPath $Target).Path
$outputPath = Join-Path $targetPath 'AGENTS.md'

if ((Test-Path -LiteralPath $outputPath) -and -not $DryRun) {
    [Console]::Error.WriteLine("$outputPath already exists; SmartLoop will not overwrite it. Use -DryRun to preview a newly detected policy.")
    exit 2
}

$projectName = Split-Path -Leaf $targetPath
$stacks = [System.Collections.Generic.List[string]]::new()
$checks = [System.Collections.Generic.List[string]]::new()
$boundaries = [System.Collections.Generic.List[string]]::new()
$notes = [System.Collections.Generic.List[string]]::new()

function Add-Stack {
    param([string]$Name)
    if (-not $stacks.Contains($Name)) {
        $stacks.Add($Name)
    }
}

function Add-Check {
    param(
        [string]$Label,
        [string]$Command,
        [string]$Source,
        [string]$WorkingDirectory
    )
    $checks.Add("- ${Label}: ``$Command`` (source: ``$Source``; run from: ``$WorkingDirectory``).")
}

function Get-PackageManager {
    param([string]$Directory)
    if (Test-Path (Join-Path $Directory 'pnpm-lock.yaml')) { return 'pnpm' }
    if (Test-Path (Join-Path $Directory 'yarn.lock')) { return 'yarn' }
    if ((Test-Path (Join-Path $Directory 'bun.lockb')) -or (Test-Path (Join-Path $Directory 'bun.lock'))) { return 'bun' }
    return 'npm'
}

function Get-RelativePath {
    param([string]$Path)
    if ($Path -eq $targetPath) { return '.' }
    return $Path.Substring($targetPath.Length).TrimStart('\', '/').Replace('\', '/')
}

$manifestCandidates = [System.Collections.Generic.List[string]]::new()
foreach ($relative in @('package.json', 'web/package.json', 'frontend/package.json', 'client/package.json', 'server/package.json')) {
    $candidate = Join-Path $targetPath $relative
    if (Test-Path -LiteralPath $candidate) {
        $manifestCandidates.Add($candidate)
    }
}

foreach ($container in @('apps', 'packages')) {
    $containerPath = Join-Path $targetPath $container
    if (-not (Test-Path -LiteralPath $containerPath -PathType Container)) { continue }
    Get-ChildItem -LiteralPath $containerPath -Directory | ForEach-Object {
        $candidate = Join-Path $_.FullName 'package.json'
        if (Test-Path -LiteralPath $candidate) {
            $manifestCandidates.Add($candidate)
        }
    }
}

foreach ($manifestPath in $manifestCandidates | Select-Object -Unique) {
    Add-Stack 'Node.js'
    $packageDirectory = Split-Path -Parent $manifestPath
    $relativeManifest = Get-RelativePath $manifestPath
    $relativeDirectory = Get-RelativePath $packageDirectory
    $packageManager = Get-PackageManager $packageDirectory

    foreach ($packageFile in @('package-lock.json', 'pnpm-lock.yaml', 'yarn.lock', 'bun.lock', 'bun.lockb', '.env', '.env.local', 'node_modules', '.next', 'coverage')) {
        if (-not (Test-Path -LiteralPath (Join-Path $packageDirectory $packageFile))) { continue }
        $boundaryPath = if ($relativeDirectory -eq '.') { $packageFile } else { "$relativeDirectory/$packageFile" }
        if ($packageFile -match 'lock') {
            $boundaries.Add("- ``$boundaryPath`` (change only for intentional dependency work)")
        }
        else {
            $boundaries.Add("- ``$boundaryPath``")
        }
    }

    try {
        $package = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
        $scriptNames = @()
        if ($null -ne $package.scripts) {
            $scriptNames = @($package.scripts.PSObject.Properties.Name)
        }
        foreach ($scriptName in @('test', 'lint', 'typecheck', 'build', 'format:check', 'check')) {
            if ($scriptName -notin $scriptNames) { continue }
            $label = switch ($scriptName) {
                'test' { 'Tests' }
                'lint' { 'Lint' }
                'typecheck' { 'Typecheck' }
                'build' { 'Build' }
                'format:check' { 'Format check' }
                'check' { 'Repository check' }
            }
            Add-Check $label "$packageManager run $scriptName" $relativeManifest $relativeDirectory
        }
    }
    catch {
        $notes.Add("- Could not parse ``$relativeManifest``; inspect its scripts manually.")
    }
}

$pythonConfigFiles = @(
    'pyproject.toml', 'requirements.txt', 'requirements-dev.txt',
    'setup.cfg', 'tox.ini', 'pytest.ini'
) | ForEach-Object { Join-Path $targetPath $_ } | Where-Object { Test-Path -LiteralPath $_ }

if ($pythonConfigFiles.Count -gt 0) {
    Add-Stack 'Python'
    $pythonConfig = ($pythonConfigFiles | ForEach-Object { Get-Content -Raw -LiteralPath $_ }) -join [Environment]::NewLine
    if ($pythonConfig -match '(?i)pytest') {
        Add-Check 'Tests' 'python -m pytest' 'Python project configuration' '.'
    }
    if ($pythonConfig -match '(?i)(^|[^a-z0-9_])ruff([^a-z0-9_]|$)') {
        Add-Check 'Lint' 'ruff check .' 'Python project configuration' '.'
        Add-Check 'Format check' 'ruff format --check .' 'Python project configuration' '.'
    }
    if ($pythonConfig -match '(?i)(^|[^a-z0-9_])mypy([^a-z0-9_]|$)') {
        Add-Check 'Typecheck' 'mypy .' 'Python project configuration' '.'
    }
}

if (Test-Path -LiteralPath (Join-Path $targetPath 'go.mod')) {
    Add-Stack 'Go'
    Add-Check 'Tests' 'go test ./...' 'go.mod and standard Go tooling' '.'
    Add-Check 'Static checks' 'go vet ./...' 'go.mod and standard Go tooling' '.'
    Add-Check 'Format check' 'gofmt -l <changed-go-files>' 'go.mod and standard Go tooling' '.'
}

if (Test-Path -LiteralPath (Join-Path $targetPath 'Cargo.toml')) {
    Add-Stack 'Rust'
    Add-Check 'Tests' 'cargo test' 'Cargo.toml' '.'
    Add-Check 'Compile check' 'cargo check' 'Cargo.toml' '.'
    Add-Check 'Lint' 'cargo clippy' 'Cargo.toml' '.'
    Add-Check 'Format check' 'cargo fmt --check' 'Cargo.toml' '.'
}

foreach ($relativePath in @(
    '.env', '.env.local', '.venv', 'node_modules', '.next', 'dist', 'build', 'out',
    'coverage', 'target', '__pycache__', 'data/uploads', 'data/logs',
    'data/vector_index', 'generated', 'src/generated', 'prisma/migrations', 'migrations'
)) {
    if (Test-Path -LiteralPath (Join-Path $targetPath $relativePath)) {
        $boundaries.Add("- ``$relativePath``")
    }
}

foreach ($lockfile in @('go.sum', 'Cargo.lock')) {
    if (Test-Path -LiteralPath (Join-Path $targetPath $lockfile)) {
        $boundaries.Add("- ``$lockfile`` (change only for intentional dependency work)")
    }
}

if ($stacks.Count -eq 0) {
    $stacks.Add('Unknown; inspect repository documentation before adding commands')
}
if ($checks.Count -eq 0) {
    $checks.Add('- No supported check command was discovered. Inspect project documentation and CI before adding one.')
}
if ($boundaries.Count -eq 0) {
    $boundaries.Add('- No project-specific generated or local-state paths were detected. Review .gitignore and helper scripts.')
}
if ($notes.Count -eq 0) {
    $notes.Add('- Review helper scripts, CI, and nested instruction files before treating this generated policy as complete.')
}

$stackText = $stacks -join ', '
$boundaryLines = @($boundaries | Select-Object -Unique)
$content = @"
# AGENTS.md

Working instructions for coding agents in this repository.

## Repository Context

- Project: $projectName
- Detected stack: $stackText

This file was generated from local repository evidence. Review it before routine use.

## Working Loop

1. Understand the task and definition of done.
2. Inspect relevant files, callers, tests, and repository instructions before editing.
3. Make the smallest safe change.
4. Add or update tests when behavior changes.
5. Run the smallest relevant checks, then broader checks when required.
6. If a check fails, inspect the error, fix the cause, and rerun.
7. Stop when checks pass, when blocked, or after 3 failed attempts on the same issue.

## Checks

$($checks -join [Environment]::NewLine)

Run commands from the documented working directory. Do not invent replacements for missing commands. Report unavailable checks in the final response.

## Testing Policy

- Add regression coverage for bugfixes when practical.
- Add tests for new behavior and meaningful failure paths.
- Preserve behavior during refactors.
- Do not weaken tests merely to make them pass.

## Detected Editing Boundaries

Do not edit generated, vendored, build, cache, runtime-state, or local environment files by hand:

$($boundaryLines -join [Environment]::NewLine)

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

$($notes -join [Environment]::NewLine)

## Final Response

Include:

- Summary
- Files changed
- Checks run and outcomes
- Remaining risks or follow-ups
"@

if ($DryRun) {
    if (Test-Path -LiteralPath $outputPath) {
        Write-Warning "$outputPath already exists; showing a detection preview only."
    }
    $content
    exit 0
}

$utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$bytes = $utf8NoBom.GetBytes($content.TrimEnd() + [Environment]::NewLine)
$stream = [System.IO.File]::Open($outputPath, [System.IO.FileMode]::CreateNew, [System.IO.FileAccess]::Write, [System.IO.FileShare]::None)
try {
    $stream.Write($bytes, 0, $bytes.Length)
}
finally {
    $stream.Dispose()
}

Write-Output "Created $outputPath"
Write-Output "Detected stack: $stackText"
Write-Output 'Review the generated commands and boundaries before routine agent work.'
