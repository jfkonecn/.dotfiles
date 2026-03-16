#!/usr/bin/env bash
set -euo pipefail

usage() {
    cat <<'EOF'
Usage: tag-aws-elb.sh <elb-arn-or-file> <key> <value>

Examples:
  tag-aws-elb.sh arn:aws:elasticloadbalancing:us-east-1:123456789012:loadbalancer/app/my-alb/50dc6c495c0c9188 Environment Production
  tag-aws-elb.sh ./elb-arns.txt Environment Production

The first argument can be:
  - a single ELBv2 resource ARN
  - a file containing ELBv2 ARNs separated by newlines, spaces, tabs, or commas

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
    echo "Error: no ELB resource ARNs were provided." >&2
    exit 1
fi

for resource_arn in "${resource_arns[@]}"; do
    if [[ ! $resource_arn =~ ^arn:[^:]+:elasticloadbalancing: ]]; then
        echo "Error: invalid ELB ARN: $resource_arn" >&2
        exit 1
    fi
done

printf 'Running command: aws elbv2 add-tags --resource-arns'
printf ' %q' "${resource_arns[@]}"
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

aws elbv2 add-tags \
    --resource-arns "${resource_arns[@]}" \
    --tags "Key=${tag_key},Value=${tag_value}"

printf 'Tagged %d ELB resource(s) with %s=%s\n' \
    "${#resource_arns[@]}" \
    "$tag_key" \
    "$tag_value"
