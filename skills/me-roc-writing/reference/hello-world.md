# Hello, World

Install a nightly compiler from the Roc nightlies releases, put `roc` on `PATH`, and confirm the active compiler with:

```bash
roc version
```

The version is a nightly tag, so do not expect a particular date or commit.

```roc
main! = |_args| {
    echo!("Hello, World!")
    Ok({})
}
```

Run an explicit file with `roc main.roc`. When no file path is supplied, `roc` defaults to `main.roc`, so `roc` runs that file from its directory.
