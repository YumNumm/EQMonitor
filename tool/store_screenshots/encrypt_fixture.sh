#!/usr/bin/env bash
set -euo pipefail

FIXTURE_DIR="${STORE_SCREENSHOT_FIXTURE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/fixtures}"
RECIPIENTS="$FIXTURE_DIR/recipients.txt"

if [[ $# -lt 1 || $# -gt 2 ]]; then
  echo "usage: $0 <input-file> [<fixture-name>]" >&2
  exit 2
fi

input="$1"
name="${2:-$(basename "$input")}"

if [[ ! -f "$input" ]]; then
  echo "error: $input does not exist" >&2
  exit 1
fi
if [[ ! "$name" =~ ^[a-z0-9][a-z0-9._-]*$ ]]; then
  echo "error: fixture name must match ^[a-z0-9][a-z0-9._-]*\$: $name" >&2
  exit 1
fi
if [[ ! -s "$RECIPIENTS" ]]; then
  echo "error: $RECIPIENTS is missing. Run tool/store_screenshots/setup_fixture_key.sh first." >&2
  exit 1
fi

age --encrypt --recipients-file "$RECIPIENTS" --output "$FIXTURE_DIR/$name.age" "$input"
echo "encrypted: $FIXTURE_DIR/$name.age"
