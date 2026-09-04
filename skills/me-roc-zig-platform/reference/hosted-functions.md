# Hosted Functions

A platform header's `hosted` block maps arbitrary linker-symbol strings to effectful Roc declarations. The mapping, rather than a naming convention, is the contract:

```roc
hosted {
    "roc_cli_log": CliHost.log!,
    "roc_cli_read": CliHost.read!,
}
```

The mapped module declares matching effectful functions; Roc calls these functions normally:

```roc
log! : Str => {}

read! : {} => Str
```

After regenerating `roc_platform_abi.zig`, implement each generated declaration by its exact exported name, argument order, result type, and `callconv(.c)`. Generated signatures use the natural target C ABI, including target-specific aggregate, vector, and indirect-result behavior. Do not derive a signature, layout, hidden argument, or result convention from Roc syntax.

```zig
const abi = @import("roc_platform_abi.zig");

export fn roc_cli_read() callconv(.c) abi.RocStr {
    return abi.RocStr.fromSlice("input", &roc_host);
}

export fn roc_cli_log(message: abi.RocStr) callconv(.c) void {
    defer message.decref(&roc_host);
    writeLog(message.asSlice());
}
```

Roc transfers ownership of every refcounted hosted argument. On every return path, release each owned argument once with the generated type-specific helper, or move its ownership into retained host state or the returned value. A value retained by the host needs an explicit generated retain/incref first; release it when that state is destroyed. Consume or copy input before releasing it, and settle it before returning either a success or error result. [`basic-webserver/src/stdio.rs`](https://github.com/roc-lang/basic-webserver/blob/main/src/stdio.rs) demonstrates this error-safe `RocStr` pattern.

Use the generated helper named in the hosted declaration's ownership comment. Containers with refcounted elements need their generated recursive helper, not the container's shallow release:

```zig
export fn roc_cli_checksum(items: abi.RocList(abi.RocStr)) callconv(.c) u64 {
    defer abi.decrefListOfStr(items, &roc_host);

    var sum: u64 = 0;
    for (items.items()) |item| for (item.asSlice()) |byte| sum += byte;
    return sum;
}
```

For a refcounted result returned to Roc, create exactly one owned Roc value with the generated constructors. For records and tags, use generated types and constructors. Never invent field layout, discriminants, allocation headers, or release behavior. Regenerate glue whenever the `hosted` or `provides` contract changes.

For the reverse direction, `provides` maps a Roc wrapper to a generated declaration that the Zig host calls:

```roc
provides { "roc_main": main_for_host! }
```

The host calls the generated `provides` declaration and settles a refcounted result after use. This keeps host-to-Roc entrypoints distinct from Roc-to-host hosted exports.
