#!/bin/bash

# Create a temp file
TMPFILE=$(mktemp)

# Save clipboard contents into the temp file, properly JSON-escaped
pbpaste > "$TMPFILE"

# Launch node, read the file content into a `data` variable
node --eval "const data = require('fs').readFileSync('$TMPFILE', 'utf8'); const parsedData = JSON.parse(data); console.log('Variable \"parsedData\" is loaded.');" --interactive

# Cleanup temp file afterwards
rm "$TMPFILE"

