# Local Platform Examples

Use the local examples for architecture, not as a source of manually copied ABI declarations.

## basic-cli

[`roc-lang/basic-cli`](https://github.com/roc-lang/basic-cli) is a Rust `staticlib` host using generated Rust glue. Its platform header has a one-entrypoint CLI contract and extensive custom hosted functions. Read:

- `platform/main.roc` for the header, hosted map, and target inputs.
- `platform/Host.roc` for Roc-side hosted declarations.
- `src/lib.rs` for runtime exports, startup, and simple hosted functions.
- `src/http.rs`, `src/sqlite.rs`, and `src/tcp.rs` for ownership and resource examples.
- `ci/regenerate_glue.sh`, `scripts/build.py`, and `scripts/test.py` for regeneration and verification.

## basic-webserver

[`roc-lang/basic-webserver`](https://github.com/roc-lang/basic-webserver) is also Rust-hosted but demonstrates the same direct-symbol ABI with multiple host-called Roc lifecycle functions, request concurrency, asynchronous native transport, and long-lived opaque resources. Read:

- `platform/main.roc` for `requires`, six `provides` entries, 61 hosted entries, and targets.
- `src/roc_alloc.rs` for a production allocator under the direct ABI.
- `src/stdio.rs` for a compact hosted-argument ownership pattern.
- `src/http_server.rs` for provided calls and owned-result lifecycle wrappers.
- `src/host_resource.rs` and `design.md` for bounded opaque resource ownership.
- `scripts/regenerate_glue.py`, `scripts/build.py`, and `scripts/test.py` for pinned generation and end-to-end testing.

For a current Zig host implementation, use [`test/glue/cli-main/host.zig`](https://github.com/roc-lang/roc/blob/main/test/glue/cli-main/host.zig). It demonstrates generated Zig glue, direct runtime exports, hosted callbacks, and a generated provided call.
