---
name: me-roc-zig-platform
description: Roc Zig platform authoring. Use when creating or changing a Roc platform's Zig host, platform header, generated Zig glue, host ABI symbols, linking targets, or platform integration tests.
---

# Roc Zig Platforms

Use generated Zig glue as the ABI authority. The Roc header declares the contract; generated glue maps that contract to the direct C ABI; the Zig host implements it and starts the Roc entrypoint.

1. Establish the contract before writing host code. Read the repository instructions and platform design, then inspect `platform/main.roc`, its imported Roc API modules, target inputs, and the host build. Keep `requires` as the application contract, `exposes` as the public API, `provides` as Roc entrypoints the host calls, and `hosted` as host symbols Roc calls. Every symbol must have one matching declaration, implementation, and linkable export.
2. Generate the boundary after every `hosted` or `provides` change. Use the pinned compiler's Zig glue script, normally `roc glue "$ROC_ZIG_GLUE" ./platform/main.roc --output-dir ./platform`; if that variable is absent, use the matching compiler checkout's `src/glue/src/ZigGlue.roc`. Import the generated file from the host. Treat its signatures, layout assertions, constructors, and ownership helpers as the source of truth.
3. Implement the host's direct ABI. Export `roc_alloc`, `roc_dealloc`, `roc_realloc`, `roc_dbg`, `roc_expect_failed`, and `roc_crashed`, plus each generated hosted symbol, with the generated `callconv(.c)` signature. The host owns process startup and calls generated declarations for the `provides` entrypoints. Link the host artifact in the platform header's `targets` inputs.
4. Settle ownership at every crossing. A hosted function receives owned refcounted arguments: release each exactly once using the generated helper, or move it into storage or a returned value. A provided entrypoint yields owned refcounted results: release them after use. Allocate values returned to Roc with generated constructors and the same Roc allocator. Keep an ownership path for every `Str`, `List`, `Box`, tag payload, and callable that crosses or remains stored across the boundary.
5. Prove the loop end-to-end. Build the Zig host, generate glue in a clean output location, build a minimal app against the platform, and run it through one provided entrypoint and one hosted call. Run the repository's focused platform tests and Zig tests. Completion requires generated glue to be current, all required symbols to link, and every new ownership path to execute without leaks or invalid releases.

Read `/home/jfkonecn/oss/roc/src/glue/README.md` before changing ABI-boundary code, ownership, allocator behavior, generated glue, or target support.
Read `/home/jfkonecn/oss/roc/src/glue/src/ZigGlue.roc` when diagnosing generated declarations or helper behavior.
Read `reference/runtime-abi.md` before implementing the Roc runtime symbols, allocator, host startup, or provided-entrypoint calls.
Read `reference/hosted-functions.md` before adding or changing a Roc-to-Zig operation in `hosted` or its Zig implementation.
Read `/home/jfkonecn/oss/basic-webserver/platform/main.roc` when designing `requires`, `provides`, `hosted`, or `targets`; read its `AGENTS.md` and `design.md` before using it as an architectural example.
Read `me-roc-writing` when changing Roc source or using Roc compiler commands beyond glue generation.
