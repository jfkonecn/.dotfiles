# Build And Verification

Build the native host as the static artifact named by `targets.*.inputs`, copy it to the target input directory, and verify the final Roc application link. A host library compiling alone does not prove that all direct runtime and hosted symbols are extractable from the archive or compatible with the app ABI.

For every boundary change:

1. Regenerate bindings with the pinned compiler and matching glue spec.
2. Run the glue freshness check and host-language formatter, lint, and unit tests.
3. Run `roc fmt --check platform` and `roc test platform/main.roc` or the repository equivalent.
4. Build an application against a locally built platform bundle for each affected target.
5. Run a compiled app through a hosted call and every affected provided lifecycle path, including result and resource cleanup.
6. Run memory checking where supported. This must exercise allocator activity and invalid-release paths, not only report a clean empty run.

[`basic-cli` build and test scripts](https://github.com/roc-lang/basic-cli/tree/main/scripts) cover a CLI static host. [`basic-webserver` build, test, and glue-regeneration scripts](https://github.com/roc-lang/basic-webserver/tree/main/scripts) cover a lifecycle-oriented platform, cross-target builds, and memcheck. For compiler glue changes, run `zig build run-check-glue-abi` from a [Roc source checkout](https://github.com/roc-lang/roc).
