#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: tag-aws-vpc.sh <vpc-id-or-file> <key> <value>

Examples:
  tag-aws-vpc.sh vpc-0123456789abcdef0 Environment Production
  tag-aws-vpc.sh ./vpcs.txt Environment Production

The first argument can be:
  - a single VPC ID
  - a file containing VPC IDs separated by newlines, spaces, tabs, or commas

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

declare -a vpc_ids=()

if [[ -f $source_arg ]]; then
    while IFS= read -r line || [[ -n $line ]]; do
        line=${line//$'\r'/}
        line=${line%%#*}
        [[ -z ${line//[[:space:],]/} ]] && continue

        line=${line//,/ }
        for token in $line; do
            vpc_ids+=("$token")
        done
    done <"$source_arg"
else
    vpc_ids+=("$source_arg")
fi

if [[ ${#vpc_ids[@]} -eq 0 ]]; then
    echo "Error: no VPC IDs were provided." >&2
    exit 1
fi

for vpc_id in "${vpc_ids[@]}"; do
    if [[ ! $vpc_id =~ ^vpc-[a-zA-Z0-9]+$ ]]; then
        echo "Error: invalid VPC ID: $vpc_id" >&2
        exit 1
    fi
done

printf 'Running command: aws ec2 create-tags --resources'
printf ' %q' "${vpc_ids[@]}"
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
    --resources "${vpc_ids[@]}" \
    --tags "Key=${tag_key},Value=${tag_value}"

printf 'Tagged %d VPC(s) with %s=%s\n' \
    "${#vpc_ids[@]}" \
    "$tag_key" \
    "$tag_value"
