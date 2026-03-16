#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: tag-aws-eks.sh <eks-arn-or-file> <key> <value>

Examples:
  tag-aws-eks.sh arn:aws:eks:us-east-1:123456789012:cluster/my-cluster Environment Production
  tag-aws-eks.sh ./eks-arns.txt Environment Production

The first argument can be:
  - a single EKS resource ARN
  - a file containing EKS ARNs separated by newlines, spaces, tabs, or commas

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

declare -a resource_arns=()

if [[ -f $source_arg ]]; then
    while IFS= read -r line || [[ -n $line ]]; do
        line=${line//$'\r'/}
        line=${line%%#*}
        [[ -z ${line//[[:space:],]/} ]] && continue

        line=${line//,/ }
        for token in $line; do
            resource_arns+=("$token")
        done
    done <"$source_arg"
else
    resource_arns+=("$source_arg")
fi

if [[ ${#resource_arns[@]} -eq 0 ]]; then
    echo "Error: no EKS resource ARNs were provided." >&2
    exit 1
fi

for resource_arn in "${resource_arns[@]}"; do
    if [[ ! $resource_arn =~ ^arn:[^:]+:eks: ]]; then
        echo "Error: invalid EKS ARN: $resource_arn" >&2
        exit 1
    fi
done

for resource_arn in "${resource_arns[@]}"; do
    printf 'Running command: aws eks tag-resource --resource-arn %q --tags %q\n' \
        "$resource_arn" \
        "${tag_key}=${tag_value}"
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

for resource_arn in "${resource_arns[@]}"; do
    aws eks tag-resource \
        --resource-arn "$resource_arn" \
        --tags "${tag_key}=${tag_value}"
done

printf 'Tagged %d EKS resource(s) with %s=%s\n' \
    "${#resource_arns[@]}" \
    "$tag_key" \
    "$tag_value"
