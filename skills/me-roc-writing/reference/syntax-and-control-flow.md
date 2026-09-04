# Syntax And Control Flow

## Bindings and functions

Use `name = value` for immutable bindings. A `var` begins with `$` and can be reassigned only within the function where it was declared.

```roc
sum_digits = |digits| {
    var $total = 0
    for digit in digits {
        $total = ($total * 10) + digit
    }
    $total
}
```

Functions use `|args| expression`; a block is an expression whose final expression is its value. `main!` and other effectful functions conventionally end in `!`. Method syntax such as `items.len()` resolves to the corresponding function call.

## Branches and matches

`if` is an expression and uses `if condition value else value`, with blocks when branches need statements. Revised nightly syntax has no `then`.

```roc
label = if name.is_empty() "n/a" else name

points = match animals {
    [first, ..] => score(first)
    _ => 0
}
```

Prefer explicit tag cases over a catch-all where the cases are known; exhaustive matching documents error handling and lets the compiler expose new variants. List patterns can use `..`; `_` ignores a value.

## Early exit, checks, debugging

`return value` exits the current function. Reserve `crash` for impossible states or failures that cannot be handled gracefully; represent recoverable failure in normal data.

Use top-level `expect condition` for focused tests. An `expect` inside a block checks development/test assumptions and is omitted in `--opt=speed`; it is not a production assertion.

Use `dbg value` for a temporary probe. Constant folding can emit it at compile time, so do not assume it runs at runtime. Remove temporary probes before completing the change.
