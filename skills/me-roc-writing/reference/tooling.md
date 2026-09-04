# Tooling

## Establish the target

Run `roc version` from the project. Read `.roc-version`, headers' `roc:` entries, project scripts, and CI before selecting a compiler or command. A project can pin a nightly; do not infer its API from an older Roc installation or public old-compiler documentation.

Use `roc --help` and `roc <subcommand> --help` when command arguments or availability matter. Inspect imported modules and local definitions before inventing an API.

## Tight loop

- `roc fmt` formats source using Roc's fixed formatter; restrict it to the changed scope if the installed CLI supports paths.
- `roc test` runs top-level `expect`s in the target and its imports. Use the project's test command when it covers platform setup or generated inputs.
- `roc <file>` runs an application; `roc build <file>` builds one when a binary is the useful artifact.
- `roc repl` evaluates expressions and persistent definitions. Pipe input for a scriptable probe; use `--no-color` or `NO_COLOR` when parsing diagnostics.

Compile errors, warnings, and failing expectations are evidence. Reduce a version-sensitive failure to the smallest local reproduction, then check the installed nightly's help, source, and project examples before changing code.
