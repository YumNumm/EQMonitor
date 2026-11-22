#!/usr/bin/env bash
set -euo pipefail

FIXTURE_DIR="${STORE_SCREENSHOT_FIXTURE_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/fixtures}"
KEY_NAME=STORE_SCREENSHOT_FIXTURE_AGE_KEY

allow_empty=false
if [[ "${1:-}" == --allow-empty ]]; then
  allow_empty=true
  shift
fi
if [[ $# -ne 1 ]]; then
  echo "usage: $0 [--allow-empty] <output-dir>" >&2
  exit 2
fi

output_dir="$1"
shopt -s nullglob
encrypted=("$FIXTURE_DIR"/*.age)
if [[ ${#encrypted[@]} -eq 0 ]]; then
  if [[ "$allow_empty" == true ]]; then
    mkdir -p "$output_dir"
    echo "warning: no encrypted fixtures in $FIXTURE_DIR" >&2
    exit 0
  fi
  echo "error: no encrypted fixtures in $FIXTURE_DIR. Run setup_fixture_key.sh and encrypt_fixture.sh first." >&2
  exit 1
fi
if [[ -z "${!KEY_NAME:-}" ]]; then
  echo "error: $KEY_NAME is not set. Run through 'mise exec --' so .env.json is decrypted." >&2
  exit 1
fi

umask 077
mkdir -p "$output_dir"
for file in "${encrypted[@]}"; do
  name="$(basename "$file" .age)"
  age --decrypt --identity - --output "$output_dir/$name" "$file" <<<"${!KEY_NAME}"
  echo "decrypted: $name"
done
