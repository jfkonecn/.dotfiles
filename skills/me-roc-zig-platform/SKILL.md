---
name: me-roc-zig-platform
description: Roc native platform authoring. Use when creating or changing a Roc platform header, Zig host, generated glue, runtime ABI export, hosted function, provided entrypoint, resource lifetime, target link, or platform integration test.
---

# Roc Native Platforms

Use generated glue as the ABI authority. The Roc header declares the contract; generated glue maps it to the direct C ABI; the native host implements runtime and hosted exports, then calls the generated provided entrypoints.

1. Establish the contract before writing host code. Inspect the header, imported Roc API, host build, targets, and local platform design. `requires` is the app contract, `exposes` the public API, `provides` host-called Roc entrypoints, and `hosted` host symbols callable from Roc.
2. Regenerate bindings after every `hosted` or `provides` change, using a glue spec from the exact compiler revision. Implement only the generated signatures, layouts, constructors, and ownership helpers.
3. Export all six direct runtime symbols plus each generated hosted symbol. The host calls generated `provides` declarations, which may represent application lifecycle hooks rather than one `main` function.
4. Settle ownership at every boundary. Release or move every owned refcounted value exactly once; construct returned Roc values through generated helpers; retain explicitly before storing a value past the call.
5. Verify an end-to-end app build and run, including a hosted callback, a provided call/result, resource shutdown, and the final target link. Regenerated glue, host-language tests, and a linkable archive alone are insufficient.

Read `reference/platform-contract.md` before changing `requires`, `exposes`, `provides`, `hosted`, or `targets`.
Read `reference/glue-and-bindings.md` before generating or consuming Zig, Rust, or C glue.
Read `reference/runtime-abi.md` before implementing runtime symbols, allocation, diagnostics, host startup, or provided calls.
Read `reference/hosted-functions.md` before adding a custom Roc-to-host function.
Read `reference/ownership-and-resources.md` before retaining data, returning refcounted values, using `Box`, or starting asynchronous work.
Read `reference/build-and-verification.md` before changing host archives, target inputs, regeneration, CI, or platform tests.
Read `reference/local-examples.md` before using `basic-cli` or `basic-webserver` as an implementation reference.
Read `me-roc-writing` when changing Roc source outside the platform boundary.
