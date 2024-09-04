#!/bin/bash

# Check if the user has provided a query string
if [ -z "$1" ]; then
    echo "Usage: find-string-json.sh <search_string>"
    exit 1
fi

# Read from stdin and search for the string passed as the argument
jq --arg query "$1" 'paths(scalars) as $p | select(getpath($p) | tostring | contains($query)) | $p | join(".")'
