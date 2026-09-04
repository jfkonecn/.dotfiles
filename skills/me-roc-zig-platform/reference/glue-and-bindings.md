# Glue And Bindings

Never hand-write Roc ABI types. Generated glue is the compatibility layer for records, tags, `Str`, `List`, `Box`, callables, target pointer widths, alignment, natural C ABI rules, and recursive ownership plans.

Use the glue spec from the same compiler revision as the `roc` executable and platform. Confirm the actual command with `roc glue --help`; the current local compiler uses:

```sh
roc glue [--no-cache] <GLUE_SPEC> <GLUE_DIR> [ROC_FILE]
```

For a Zig host, generate with the matching `ZigGlue.roc`; for a Rust host, use `RustGlue.roc`. Import the generated output rather than recreating its declarations. Regenerate whenever `hosted`, `provides`, or an ABI-visible Roc type changes, then compare generated output in CI.

The same glue source supports 32- and 64-bit pointer layouts; it has no `--target` flag. Build generated bindings for every supported host target. Layout assertions and generated helper APIs must remain enabled.

The [basic-cli regeneration script](https://github.com/roc-lang/basic-cli/blob/main/ci/regenerate_glue.sh) and [basic-webserver regeneration script](https://github.com/roc-lang/basic-webserver/blob/main/scripts/regenerate_glue.py) are authoritative examples. The webserver script also enforces matching compiler and glue-spec revisions before generating its committed Rust bindings.
