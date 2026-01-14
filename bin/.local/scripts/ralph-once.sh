#!/bin/bash

set -e

PRD_FILE_PATH="$1"

if [ -z "$PRD_FILE_PATH" ]; then
  echo "Error: missing PRD file path argument."
  echo "Usage: $0 <path-to-prd-file>"
  exit 1
fi

if [ ! -f "$PRD_FILE_PATH" ]; then
  echo "Error: file not found: $PRD_FILE_PATH"
  exit 1
fi

codex --full-auto "@$PRD_FILE_PATH @progress.txt \
1. Read the PRD and progress file. \
2. Find the next incomplete task and implement it. \
3. Commit your changes. \
4. Update progress.txt with what you did. \
ONLY DO ONE TASK AT A TIME."

