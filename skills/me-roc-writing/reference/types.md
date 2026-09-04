# Types

Roc is statically checked with sound, decidable, principal type inference. Annotations are optional, but inferred types are still checked. Values are semantically immutable and therefore free of data races.

Place annotations above a binding:

```roc
name : Str
name = "Sam"

is_empty : Bool
is_empty = name.is_empty()
```

Parameterized types use parentheses:

```roc
strings : List(Str)
strings = ["a", "b", "c"]
```

Function annotations use `->` for pure functions and `=>` for effectful functions:

```roc
average : Dec, Dec -> Dec
average = |a, b| (a + b) / 2

read_str! : Path => Try(Str, ReadFileErr)
```

Lowercase type variables are generic. Constrain a required method with `where`:

```roc
stringify : a -> Str where [a.to_str : a -> Str]
stringify = |value| value.to_str()
```

Tags form structural tag unions. Errors commonly use a tag-union error type so operations can combine their possible failures. Define a nominal enumeration-like tag type with `:=`, for example `Bool := [True, False]`.
