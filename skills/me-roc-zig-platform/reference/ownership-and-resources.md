# Ownership And Resources

At every Roc/native boundary, write an ownership path before implementing code. Hosted calls receive owned refcounted arguments. Generated `provides` calls return owned refcounted results to the host. A return to Roc transfers exactly one owned reference. Scalars have no refcount release path.

Use generated recursive helpers for values containing `Str`, `List`, records, tags, boxes, or callables. A list-spine release can be intentionally shallow; do not recursively free its elements unless the generated ownership helper says to. Never copy an ownership-bearing Roc value as though it were a plain host struct.

For data retained beyond a hosted call or used by asynchronous work, first copy it into independently owned host storage or explicitly retain it with generated helpers. Do not retain borrowed Roc bytes, invocation-local ABI state, or a raw pointer inferred from a Roc layout.

Use an opaque resource contract such as `Box(U64)` for host-owned resources. Back it with a typed, bounded, generation-checked native resource table; route final Roc ARC deallocation to exactly one native close/drop path. Do not expose unconstrained raw pointers or manual public close operations that can race final destruction. See [`basic-webserver/src/host_resource.rs`](https://github.com/roc-lang/basic-webserver/blob/main/src/host_resource.rs) and its [design](https://github.com/roc-lang/basic-webserver/blob/main/design.md).

Keep native concurrency and operating-system state in the host. Treat compiled Roc entrypoints as synchronous, reentrant calls; only cross an invocation boundary with an explicit owned ABI transfer. The [basic-webserver design](https://github.com/roc-lang/basic-webserver/blob/main/design.md) explains bounded execution and resource ownership.
