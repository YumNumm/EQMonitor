#!/usr/bin/env bash
set -euo pipefail

ROOT="$(git rev-parse --show-toplevel)"
FIXTURE_DIR="$ROOT/tool/store_screenshots/fixtures"
RECIPIENTS="$FIXTURE_DIR/recipients.txt"
ENV_FILE="$ROOT/.env.json"
KEY_NAME=STORE_SCREENSHOT_FIXTURE_AGE_KEY

rotate=false
case "${1:-}" in
  "") ;;
  --rotate) rotate=true ;;
  *)
    echo "usage: $0 [--rotate]" >&2
    exit 2
    ;;
esac

for command in age age-keygen sops; do
  if ! command -v "$command" >/dev/null; then
    echo "error: $command is required. Run through 'mise exec --'." >&2
    exit 1
  fi
done
if [[ -z "${SOPS_AGE_KEY_FILE:-}" || ! -s "$SOPS_AGE_KEY_FILE" ]]; then
  echo "error: SOPS_AGE_KEY_FILE does not point to the repository age key. Run through 'mise exec --'." >&2
  exit 1
fi
shopt -s nullglob
encrypted=("$FIXTURE_DIR"/*.age)
if [[ "$rotate" == false && (-s "$RECIPIENTS" || ${#encrypted[@]} -gt 0) ]]; then
  echo "error: a fixture key already exists. Use --rotate to replace it and re-encrypt every fixture." >&2
  exit 1
fi

work_dir="$(mktemp -d)"
trap 'rm -rf "$work_dir"' EXIT
chmod 700 "$work_dir"

if [[ ${#encrypted[@]} -gt 0 ]]; then
  STORE_SCREENSHOT_FIXTURE_AGE_KEY="$(sops decrypt --extract "[\"$KEY_NAME\"]" "$ENV_FILE")" \
    STORE_SCREENSHOT_FIXTURE_DIR="$FIXTURE_DIR" \
    "$ROOT/tool/store_screenshots/decrypt_fixtures.sh" "$work_dir/plain"
fi

secret="$(age-keygen 2>/dev/null | grep '^AGE-SECRET-KEY-')"
public="$(age-keygen -y <<<"$secret")"
printf '"%s"' "$secret" | sops set --value-stdin "$ENV_FILE" "[\"$KEY_NAME\"]"
mkdir -p "$FIXTURE_DIR"
printf '%s\n' "$public" >"$RECIPIENTS"

for file in ${encrypted[@]+"${encrypted[@]}"}; do
  name="$(basename "$file" .age)"
  STORE_SCREENSHOT_FIXTURE_DIR="$FIXTURE_DIR" \
    "$ROOT/tool/store_screenshots/encrypt_fixture.sh" "$work_dir/plain/$name" "$name"
done

echo "public key: $public"
echo "updated: $ENV_FILE ($KEY_NAME), $RECIPIENTS"
