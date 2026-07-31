# Node.js Example

Use this as a starting point for JavaScript or TypeScript repositories. Keep only the commands your repo actually supports.

## Typical Check Command

```sh
npm test
```

## Lint Command

```sh
npm run lint
```

## Format Command

```sh
npm run format
```

## Test Command

```sh
npm test
```

## Sample `AGENTS.md` Snippet

```md
## Node Checks

Run the smallest relevant test first.

Preferred commands:

- `npm test` for tests.
- `npm run lint` for linting when configured.
- `npm run typecheck` for TypeScript type checks when configured.
- `npm run build` when public APIs, bundling, or framework configuration changes.

If a script is missing from `package.json`, report it instead of inventing a replacement.
```

## Common Gotchas

- `npm run` scripts vary by repo; inspect `package.json` first.
- TypeScript repos may require both tests and `npm run typecheck`.
- Snapshot updates should be treated as behavior changes and reviewed.
- Frontend tests may need browser or DOM setup that is not available locally.
- Lockfile changes usually require extra scrutiny.
