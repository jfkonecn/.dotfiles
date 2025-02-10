#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

goimports -w "$SCRIPT_DIR/.."
