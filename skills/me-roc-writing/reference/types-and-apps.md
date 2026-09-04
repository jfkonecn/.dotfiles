# Types And Apps

## Types

Roc infers types; add annotations where they clarify an exported contract, constrain inference, or document a boundary. Annotations precede bindings.

```roc
average : Dec, Dec -> Dec
average = |a, b| (a + b) / 2

read_str! : Path => Try(Str, ReadFileErr)
```

Use `->` for pure functions and `=>` for effectful functions. Parameterized types use parentheses: `List(Str)` and `Try(Str, ReadFileErr)`. Lowercase type variables are generic; constrain required methods with `where`.

```roc
stringify : a -> Str where [a.to_str : a -> Str]
```

Define a nominal tag type with `:=`, for example `Bool := [True, False]`. Preserve open tag unions such as `[Exit(I64), ..]` when a boundary deliberately allows additional errors.

## Modules and application boundaries

Inspect the existing header and imports before changing dependencies or exposed APIs. An application declares one platform and its entrypoints; platforms supply effectful operations, while the standard library has no I/O. Follow the project's current app, package, or platform header shape and pinned `roc:` version rather than copying old tutorial headers.

Use revised nightly forms: `List(U8)`, `Bool.True`/`Bool.False`, `Try`, `Str.inspect(value)`, and method calls such as `value.to_str()`. Verify imported module names and available functions in local source or generated docs for the pinned nightly.
