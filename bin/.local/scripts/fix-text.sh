#!/usr/bin/env bash

MODEL="deepseek-r1"   # Change if needed

usage() {
    echo "Usage: $0 [file]"
    echo "       Provide a file OR pipe text via stdin."
    echo
    echo "Examples:"
    echo "  $0 myfile.txt"
    echo "  echo \"text to fix\" | $0"
    exit 1
}

# No arguments AND no stdin → incorrect usage
if [ $# -eq 0 ] && [ -t 0 ]; then
    usage
fi

# Read from file if given
if [ $# -eq 1 ]; then
    if [ ! -f "$1" ]; then
        echo "Error: File '$1' does not exist."
        usage
    fi
    INPUT="$(cat "$1")"
# Otherwise read from stdin
else
    INPUT="$(cat)"
fi

# Strict prompt to suppress explanations
PROMPT=$(cat <<EOF
You are a text-correction engine.
Fix ONLY grammar, spelling, and punctuation in the text below.

Return ONLY the corrected text.
Do NOT explain, comment, apologize, or add anything extra.
Do NOT wrap the output in quotes or code blocks.

Text to correct:
$INPUT
EOF
)

# Run Ollama
echo "$PROMPT" | ollama run "$MODEL"

