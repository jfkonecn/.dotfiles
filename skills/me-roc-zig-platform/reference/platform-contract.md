# Platform Contract

The platform header is the complete boundary contract. Inspect it and its imported Roc modules before changing native code.

- `requires` specifies the application value or entrypoint shape the platform accepts.
- `exposes` lists the Roc modules available to applications.
- `packages` names shared Roc dependencies when required.
- `provides` maps exported linker symbols to Roc wrappers that the native host calls.
- `hosted` maps exported native linker symbols to effectful Roc declarations the application can call.
- `targets` names per-target link inputs. The host archive and required startup/system libraries must appear here.

Every `hosted` entry requires one Roc declaration, one generated host declaration, one native export, and end-to-end coverage. Every `provides` entry requires one Roc wrapper, one generated host declaration, and a host call path. Preserve header ordering conventions when a project keeps hosted entries append-only to minimize generated-binding churn.

[`basic-cli/platform/main.roc`](https://github.com/roc-lang/basic-cli/blob/main/platform/main.roc) is a compact CLI example with one `roc_main` provided entrypoint and filesystem, process, SQLite, TCP, HTTP, terminal, random, and time hosted functions. [`basic-webserver/platform/main.roc`](https://github.com/roc-lang/basic-webserver/blob/main/platform/main.roc) demonstrates a lifecycle contract with `init`, request response, SSE, and shutdown provided functions plus a broad hosted surface.
