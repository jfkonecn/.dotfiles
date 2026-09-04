# Data And Errors

## Values and tags

Records use `{ field: value }`; derive an updated record with `{ ..record, field: value }` and destructure with `{ field } = record`. Lists use `[value]` and require compatible element types.

Tags model alternatives and may carry values:

```roc
event = Connected("127.0.0.1")
status = match event {
    Connected(address) => "connected: ${address}"
    Disconnected => "disconnected"
}
```

## Recoverable failure

Use `Try(ok, err)` with `Ok(value)` and `Err(error)`, and model distinct errors as tags. Match specific errors at a recovery boundary.

```roc
increment_first = |strings| {
    first = strings.first()?
    number = I64.from_str(first)?
    Ok(number + 1)
}
```

Postfix `?` unwraps `Ok` or returns its `Err` from the current function. When mapping an error, use the nightly's locally established `? |err| NewError(err)` form or confirm its syntax in the installed compiler and nearby code.

Roc has no null-like value. Use tags, `Try`, or a project-defined data type to represent absence and failure. Avoid converting recoverable errors to `crash`.
