---
name: me-roc-writing
description: Write, edit, or debug Roc for the rewritten nightly compiler. Use for Roc source changes, nightly-compiler diagnostics, revised Roc syntax, Try errors, types, app/package/platform headers, or Roc verification.
---

# Roc Nightly Writing

Target the rewritten nightly compiler, not documented alpha4/old-Roc APIs.

1. Inspect the project before editing: read its root instructions, `.roc-version` when present, app/package/platform headers, imports, and nearby Roc. Run `roc version`; use `roc --help` and subcommand help to confirm available commands and current syntax. Treat the project and installed compiler as the API source of truth.
2. Make the smallest idiomatic change consistent with the local nightly and project conventions.
3. Verify at the narrowest useful scope: format changed Roc with `roc fmt`; run affected `expect`s with `roc test`; run or build the changed app with `roc <file>` or the project command. Use `roc repl` for isolated expressions or a minimal reproduction. Report any unavailable command or environment blocker.

Read `reference/tooling.md` before choosing Roc commands, diagnosing compiler-version/API drift, or using the REPL.
Read `reference/syntax-and-control-flow.md` when writing functions, blocks, mutation, conditionals, loops, matches, tests, or debugging statements.
Read `reference/data-and-errors.md` when modeling records, lists, tags, `Try`, recoverable errors, or `?` propagation.
Read `reference/types-and-apps.md` when adding annotations, generic constraints, nominal types, imports, or app/package/platform declarations.
