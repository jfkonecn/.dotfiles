#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

go test "$SCRIPT_DIR/../..." "$@"
