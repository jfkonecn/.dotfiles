# Runtime ABI

Generated `roc_platform_abi.zig` is authoritative. Regenerate it from the exact platform header and import it into the Zig host. Its runtime section declares the symbols compiled Roc calls directly:

```zig
export fn roc_alloc(length: usize, alignment: usize) callconv(.c) ?*anyopaque
export fn roc_dealloc(ptr: ?*anyopaque, alignment: usize) callconv(.c) void
export fn roc_realloc(
    ptr: ?*anyopaque,
    new_length: usize,
    alignment: usize,
) callconv(.c) ?*anyopaque
export fn roc_dbg(bytes: [*]const u8, len: usize) callconv(.c) void
export fn roc_expect_failed(bytes: [*]const u8, len: usize) callconv(.c) void
export fn roc_crashed(bytes: [*]const u8, len: usize) callconv(.c) void
```

`roc_alloc` returns storage aligned to `alignment`; `roc_dealloc` must accept the same alignment. `roc_realloc` preserves the prefix of the old allocation and returns storage using the requested alignment. These calls do not receive the old allocation length, so the allocator needs sufficient metadata to recover it.

`roc_dbg` and `roc_expect_failed` receive a byte pointer and length, not a C string. Report the exact slice. `roc_crashed` reports the slice and terminates the running program through the host's fatal path.

The generated `RocHost` is a host-side helper context for generated constructors and release helpers. Compiled Roc does not receive it. Construct one whose allocator and diagnostic callbacks share the direct runtime symbols' allocator policy:

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

The host has the executable's `main`. It invokes the generated declaration for a symbol in the platform header's `provides` block, then releases any owned refcounted result with its generated helper:

```zig
const result = abi.roc_main(args);
defer result.decref(&roc_host);
```

Build the Zig host as the artifact named in `targets.*.inputs`; the final Roc build links that artifact and the app object. Verify the final link rather than only compiling the host, because this is where missing direct symbols are detected.
