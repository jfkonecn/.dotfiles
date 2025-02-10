# Go Bins

## Install

- [Go Lang](https://go.dev/doc/install)
- [Linter](https://golangci-lint.run/welcome/install/)

```sh
go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
```

- [Formatter](https://pkg.go.dev/golang.org/x/tools/cmd/goimports)

```sh
go install golang.org/x/tools/cmd/goimports@latest
```

- Install Dependencies

```sh
go mod tidy
```

- [Install Ollama](https://ollama.com/download)

Download the two models:

```sh
ollama pull gemma:2b
ollama pull nomic-embed-text
```
