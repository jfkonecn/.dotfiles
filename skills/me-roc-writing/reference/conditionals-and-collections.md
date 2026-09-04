# Conditionals And Collections

`if` is an expression. Use inline branches for short cases or blocks for branches with statements:

```roc
name = if str.is_empty() "n/a" else str

record = if str.is_empty() {
    { name: "n/a", has_name: Bool.False }
} else {
    { name: str, has_name: Bool.True }
}
```

Records use `{ field: value }`; derive a changed record with `{ ..record, field: value }`; destructure fields with `{ field } = record`. Lists use `["bird", "crab", "lizard"]` and all their elements need compatible types.

Method syntax such as `animals.len()` is shorthand for a type-associated function such as `List.len(animals)`. The compiler resolves this from the receiver type.

Use `match` for structural and tag patterns. List patterns may be exact, partial with `..`, nested, or ignored with `_`:

```roc
points = match animals {
    ["bird", "crab", "lizard"] => 10
    ["bird", "crab", ..] => 5
    ["bird", ..] => 1
    [first, second, "lizard", ..] => count_points(first, second)
    _ => 0
}
```

Use tags to model alternatives where bare values would have incompatible types:

```roc
birds_or_numbers = [Bird("eagle"), Number(1)]

label = match birds_or_numbers {
    [Bird(bird), Number(num)] => "${bird} number ${num.to_str()}"
    _ => ""
}
```

Roc has no null-like value. Model absence and failure with `Try`: `Ok(value)` indicates success and `Err(tag)` carries a typed failure. Match explicit errors such as `Err(ListWasEmpty)` and `Err(BadNumStr)` at a recovery boundary. Prefer explicit variants over `_` when the possible cases are known. Exhaustiveness checking is intended to reject unreachable defaults and missing cases, but was not yet ported to the new compiler as of December 1, 2025.

`Try.ok_or(fallback)` returns the `Ok` value or a fallback for any `Err`; use `Err(_)` when the error payload is deliberately irrelevant. Postfix `?` unwraps `Ok` and immediately returns the `Err` from the current function:

```roc
increment_first = |strings| {
    first_str = strings.first()?
    first_num = I64.from_str(first_str)?
    Ok(first_num + 1)
}
```
