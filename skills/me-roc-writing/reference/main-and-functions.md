# Main And Functions

`main!` is the application entrypoint; its block runs when the application is run. `|_args| { ... }` is an anonymous function with one argument. Functions are values and can be named, passed, and stored like other values.

Name a function ending in `!` when it can perform side effects. A function without `!` is pure by convention. The convention makes effects visible at call sites; follow the project's established names.

## Constants and strings

Bindings such as `name = "Rocco"` are constants. Reassigning or shadowing a constant in the same scope produces a compile-time warning and exit code 2. A `var` is distinct and begins with `$`; see the iteration reference.

Interpolation accepts any one-line expression, but it requires a `Str`; it does not coerce values automatically:

```roc
echo!("Hello, ${name}!")
echo!("Number of things: ${thing_count.to_str()}")
```

Extract complicated interpolation expressions into a named constant when that improves readability.
