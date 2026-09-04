# Runtime ABI

Generated `roc_platform_abi.zig` is authoritative for host-visible Roc values and custom functions. The fixed direct runtime ABI is maintained in [`src/builtins/host_abi.zig`](https://github.com/roc-lang/roc/blob/main/src/builtins/host_abi.zig). Compiled Roc resolves these six linker symbols directly; none receives a `RocHost` or `RocOps` parameter:

```zig
export fn roc_alloc(length: usize, alignment: usize) callconv(.c) ?*anyopaque
export fn roc_dealloc(ptr: *anyopaque, alignment: usize) callconv(.c) void
export fn roc_realloc(
    ptr: ?*anyopaque,
    new_length: usize,
    alignment: usize,
) callconv(.c) ?*anyopaque
export fn roc_dbg(bytes: [*]const u8, len: usize) callconv(.c) void
export fn roc_expect_failed(bytes: [*]const u8, len: usize) callconv(.c) void
export fn roc_crashed(bytes: [*]const u8, len: usize) callconv(.c) void
```

`roc_alloc` returns storage aligned to `alignment`; `roc_dealloc` must accept the same alignment. `roc_realloc` preserves the old prefix and returns storage using the requested alignment. Deallocation receives no allocation length, so the allocator must retain metadata sufficient to recover it. [`basic-webserver/src/roc_alloc.rs`](https://github.com/roc-lang/basic-webserver/blob/main/src/roc_alloc.rs) is a robust example with allocation-origin checks, alignment validation, canaries, and finalizers.

`roc_dbg` and `roc_expect_failed` receive a byte pointer and length, not a C string. Report the exact slice. `roc_crashed` reports the slice and terminates through the host's fatal path; it must not return to Roc.

The generated `RocHost` is separate: it is a host-side helper context for generated constructors and release helpers, not part of compiled Roc's direct calls. Its callbacks should share the direct exports' allocator and diagnostics policy:

```zig
var roc_host = abi.RocHost{
    .env = @ptrCast(&env),
    .roc_alloc = &hostAlloc,
    .roc_dealloc = &hostDealloc,
    .roc_realloc = &hostRealloc,
    .roc_dbg = &hostDbg,
    .roc_expect_failed = &hostExpectFailed,
    .roc_crashed = &hostCrashed,
};
```

Use `roc_host` when generated helpers allocate or release Roc values, for example `abi.RocStr.fromSlice(bytes, &roc_host)` and `value.decref(&roc_host)`. The helper callbacks may delegate to the same allocator implementation as the exported runtime symbols.

The host starts the process and invokes the generated declaration for each needed symbol in `provides`. A platform may provide multiple lifecycle hooks. Release a returned value only when its generated type is refcounted; scalar results such as an `I32` exit code require no release. For a refcounted result:

```zig
const result = abi.roc_main(args);
defer result.decref(&roc_host);
```

Build the Zig host as the artifact named in `targets.*.inputs`; the final Roc build links that artifact and the app object. Verify the final link rather than only compiling the host, because this is where missing direct symbols are detected.
