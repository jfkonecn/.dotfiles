#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

golangci-lint run "$SCRIPT_DIR/../..."
