# REPL

Run `roc repl` to evaluate expressions and retain definitions across inputs:

```roc
x = 1 + 1
x * 2
```

Piped REPL mode emits only evaluation output on stdout. Prompts, the welcome banner, and the goodbye message are omitted. Diagnostics go to stderr, which permits tools to consume successful values from stdout independently.

```powershell
@("x = 1 + 1", "x * 2") | roc repl
```

```bash
printf 'x = 1 + 1\nx * 2\n' | roc repl
```

The example prints `assigned \`x\`` followed by `4.0`. Use `roc repl --no-color` or set `NO_COLOR` when plain diagnostics are needed.
