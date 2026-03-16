#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: tag-aws-ec2.sh <resource-id-or-file> <key> <value>

Examples:
  tag-aws-ec2.sh i-0123456789abcdef0 Environment Production
  tag-aws-ec2.sh ./resources.txt Environment Production

The first argument can be:
  - a single EC2 resource ID
  - a file containing EC2 resource IDs separated by newlines, spaces, tabs, or commas

Blank lines and lines starting with # are ignored when reading from a file.
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

declare -a resource_ids=()

if [[ -f $source_arg ]]; then
    while IFS= read -r line || [[ -n $line ]]; do
        line=${line//$'\r'/}
        line=${line%%#*}
        [[ -z ${line//[[:space:],]/} ]] && continue

        line=${line//,/ }
        for token in $line; do
            resource_ids+=("$token")
        done
    done <"$source_arg"
else
    resource_ids+=("$source_arg")
fi

if [[ ${#resource_ids[@]} -eq 0 ]]; then
    echo "Error: no EC2 resource IDs were provided." >&2
    exit 1
fi

printf 'Running command: aws ec2 create-tags --resources'
printf ' %q' "${resource_ids[@]}"
printf ' --tags %q\n' "Key=${tag_key},Value=${tag_value}"

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

aws ec2 create-tags \
    --resources "${resource_ids[@]}" \
    --tags "Key=${tag_key},Value=${tag_value}"

printf 'Tagged %d EC2 resource(s) with %s=%s\n' \
    "${#resource_ids[@]}" \
    "$tag_key" \
    "$tag_value"
