# Expected Final Response

This illustrates the handoff shape. It does not claim that commands were actually run in this kit repository.

```text
Summary

Updated the note merge logic so omitted optional fields preserve their stored values. Added a regression test covering an update that changes the title without clearing archivedAt.

Files changed

- src/notes/update-note.ts
- test/notes/update-note.test.ts

Checks run

- npm run test:notes - passed
- npm run lint - passed
- npm run typecheck - passed

Remaining risks or follow-ups

- The full test suite and build were not required for this isolated notes-domain change.
- Integration tests were not run because no database service was available.
```

The important property is traceability: the response separates completed work, changed files, verified checks, and unverified risk.
