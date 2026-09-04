# Dependencies And Platforms

The simple hello-world file is a headerless application. Other applications commonly declare an app header such as:

```roc
app [main!] { pf: platform "https://github.com/lukewilliamboswell/roc-platform-template-zig/releases/download/1.0.0/AnZoxzoGPtSGQ15EQh6pBeeaHJ7aizP9MQhK81dES3Uq.tar.zst" }
```

`app` declares an executable application. `[main!]` lists entrypoints. The record declares dependencies; here `pf` names the sole platform. Other dependencies can be added as named entries and imported through that name, but verify the project's header syntax and dependency compatibility first.

Every Roc application has exactly one platform. The platform supplies all effectful primitives, such as `pf.Stdout` and `pf.Stdin`; the standard library has no effectful functions. Follow the project's pinned compiler, platform, and local examples.
