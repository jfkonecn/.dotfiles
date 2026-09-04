---
name: me-roc-writing
description: Write, edit, or debug Roc for the rewritten nightly compiler. Use for Roc source changes, nightly-compiler diagnostics, revised Roc syntax, Try errors, types, app/package/platform headers, or Roc verification.
---

# Roc Nightly Writing

Target only the rewritten nightly compiler. The installed nightly, project sources, and project conventions are authoritative.

1. Inspect the project before editing: read its root instructions, `.roc-version` when present, app/package/platform headers, imports, and nearby Roc. Run `roc version`; use `roc --help` and subcommand help to confirm available commands and current syntax. Treat the project and installed compiler as the API source of truth.
2. Make the smallest idiomatic change consistent with the local nightly and project conventions.
3. Verify at the narrowest useful scope: format changed Roc with `roc fmt`; run affected `expect`s with `roc test`; run or build the changed app with `roc <file>` or the project command. Use `roc repl` for isolated expressions or a minimal reproduction. Report any unavailable command or environment blocker.

The nightly tutorial is split into these focused references. Read the applicable files before relying on an unfamiliar nightly feature:

- `reference/introduction.md`: compiler maturity, source-of-truth, and support guidance.
- `reference/hello-world.md`: nightly installation check, headerless apps, and running `main.roc`.
- `reference/repl.md`: interactive and piped REPL use, stdout/stderr behavior, and plain diagnostics.
- `reference/main-and-functions.md`: entrypoints, effects, constants, and interpolation.
- `reference/iteration-and-blocks.md`: `expect`, formatting, `for`, `fold`, blocks, `return`, `crash`, and `dbg`.
- `reference/conditionals-and-collections.md`: `if`, records, lists, methods, patterns, tags, `Try`, and `?`.
- `reference/types.md`: inference, annotations, parameterized and function types, generics, and nominal types.
- `reference/dependencies-and-platforms.md`: app headers, dependencies, and the platform boundary.
- `reference/additional-resources.md`: compiler-source and community reference material.
