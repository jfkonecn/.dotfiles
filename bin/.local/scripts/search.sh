#!/usr/bin/env bash
set -euo pipefail

OPEN_CMD="open"          # macOS
# OPEN_CMD="xdg-open"    # Linux

DEBOUNCE=0.20
MIN_CHARS=2

selected="$(
  fzf --prompt="Search> " \
      --print-query \
      --disabled \
      --bind "start:reload(sleep $DEBOUNCE; q={q}; [ \${#q} -lt $MIN_CHARS ] && exit 0; \
        curl -sG 'https://suggestqueries.google.com/complete/search' \
          --data-urlencode client=firefox \
          --data-urlencode q=\"\$q\" | jq -r '.[1][]')" \
      --bind "change:reload(sleep $DEBOUNCE; q={q}; [ \${#q} -lt $MIN_CHARS ] && exit 0; \
        curl -sG 'https://suggestqueries.google.com/complete/search' \
          --data-urlencode client=firefox \
          --data-urlencode q=\"\$q\" | jq -r '.[1][]')" \
      --bind "enter:accept"
)"

query="$(printf "%s\n" "$selected" | sed -n '1p')"
choice="$(printf "%s\n" "$selected" | sed -n '2p')"

final="${choice:-$query}"

if [ -n "$final" ]; then
  encoded="$(jq -rn --arg s "$final" '$s|@uri')"
  "$OPEN_CMD" "https://www.google.com/search?q=$encoded" >/dev/null 2>&1 || true
fi

