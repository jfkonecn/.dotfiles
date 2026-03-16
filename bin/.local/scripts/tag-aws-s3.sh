#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: tag-aws-s3.sh <bucket-name-or-file> <key> <value>

Examples:
  tag-aws-s3.sh my-bucket Environment Production
  tag-aws-s3.sh ./buckets.txt Environment Production

The first argument can be:
  - a single S3 bucket name
  - a file containing S3 bucket names separated by newlines, spaces, tabs, or commas

Blank lines and lines starting with # are ignored when reading from a file.
This script preserves existing bucket tags by fetching and merging them.
EOF
}

if [[ $# -ne 3 ]]; then
    usage
    exit 1
fi

source_arg=$1
tag_key=$2
tag_value=$3

if ! command -v aws >/dev/null 2>&1; then
    echo "Error: aws CLI is not installed or not on PATH." >&2
    exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
    echo "Error: jq is not installed or not on PATH." >&2
    exit 1
fi

declare -a buckets=()

if [[ -f $source_arg ]]; then
    while IFS= read -r line || [[ -n $line ]]; do
        line=${line//$'\r'/}
        line=${line%%#*}
        [[ -z ${line//[[:space:],]/} ]] && continue

        line=${line//,/ }
        for token in $line; do
            buckets+=("$token")
        done
    done <"$source_arg"
else
    buckets+=("$source_arg")
fi

if [[ ${#buckets[@]} -eq 0 ]]; then
    echo "Error: no S3 bucket names were provided." >&2
    exit 1
fi

declare -a tagging_payloads=()

for bucket in "${buckets[@]}"; do
    existing_tagging='{"TagSet":[]}'
    if fetched_tagging=$(aws s3api get-bucket-tagging --bucket "$bucket" --output json 2>/dev/null); then
        existing_tagging=$fetched_tagging
    fi

    merged_tagging=$(
        jq -cn \
            --argjson existing "$existing_tagging" \
            --arg key "$tag_key" \
            --arg value "$tag_value" \
            '{
                TagSet: (
                    (($existing.TagSet // []) | map(select(.Key != $key))) +
                    [{Key: $key, Value: $value}]
                )
            }'
    )

    tagging_payloads+=("$merged_tagging")
    printf 'Running command: aws s3api put-bucket-tagging --bucket %q --tagging %q\n' \
        "$bucket" \
        "$merged_tagging"
done

while true; do
    read -r -p "Proceed? (y/n): " confirm
    case "$confirm" in
        y)
            break
            ;;
        n)
            echo "Aborted."
            exit 0
            ;;
        *)
            echo "Please enter only 'y' or 'n'."
            ;;
    esac
done

for i in "${!buckets[@]}"; do
    aws s3api put-bucket-tagging \
        --bucket "${buckets[$i]}" \
        --tagging "${tagging_payloads[$i]}"
done

printf 'Tagged %d S3 bucket(s) with %s=%s\n' \
    "${#buckets[@]}" \
    "$tag_key" \
    "$tag_value"
