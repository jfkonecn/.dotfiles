#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd $SCRIPT_DIR

go run "$SCRIPT_DIR/../../cmd/title-case/title-case.go" "$@"
