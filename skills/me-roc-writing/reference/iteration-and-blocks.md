# For, Fold, And Blocks

Use top-level `expect` statements for lightweight tests. `roc test` runs top-level expectations in the file and its imports. `roc fmt` applies Roc's fixed, non-configurable formatting style.

Imperative iteration uses `for` and a mutable `var`:

```roc
digits_to_num = |digits| {
    var $num = 0

    for digit in digits {
        $num = ($num * 10) + digit
    }

    $num
}
```

`$num` can be reassigned only in the function where it was declared. A callback such as `for_each!` is another function, so it cannot reassign an outer function's `var`. Prefer `for` when local mutation makes the logic clearer; prefer the functional alternative when it does not.

```roc
digits_to_num = |digits| digits.fold(0, |num, digit| (num * 10) + digit)
```

Every function has one expression after its arguments. A block is an expression in braces; its final expression is the block's value. Everything before that final expression is a statement and has no value. Thus declarations and `for` loops cannot be passed as arguments, but a block can incorporate them where an expression is required.

`return value` immediately exits the current function. `crash "message"` terminates the running application. Both can make later block code unreachable. Do not use `crash` for recoverable error handling: model recoverable failure with regular types such as `Try`; reserve it for impossible states or situations where graceful recovery is infeasible.

An `expect` in a block checks an assumption during testing or debug builds, and is skipped by `--opt=speed`; it is not a production assertion. Use `dbg value` for temporary printline debugging. Pure constant-folded code can emit `dbg` at compile time, and runtime output depends on the target, so do not assume when or where it runs.
