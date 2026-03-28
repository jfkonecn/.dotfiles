#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODEL_DIR="$SCRIPT_DIR/ollama/ollama-modelfiles"

if [[ ! -d "$MODEL_DIR" ]]; then
  echo "Directory not found: $MODEL_DIR"
  exit 1
fi

shopt -s nullglob

for file in "$MODEL_DIR"/*.txt; do
  filename="$(basename "$file")"
  model_name="${filename%.txt}"

  echo "Creating model: $model_name from $file"

  ollama create "$model_name" -f "$file"
done

echo "Done."
