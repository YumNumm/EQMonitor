#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

expect_failure() {
  local message=$1
  shift
  if "$@" >"$WORK/out.log" 2>&1; then
    echo "FAIL: expected failure: $message" >&2
    exit 1
  fi
}

fixtures="$WORK/fixtures"
mkdir -p "$fixtures"
key="$(age-keygen 2>/dev/null | grep '^AGE-SECRET-KEY-')"
age-keygen -y <<<"$key" >"$fixtures/recipients.txt"
head -c 300000 /dev/urandom >"$WORK/noto.eqrp"

STORE_SCREENSHOT_FIXTURE_DIR="$fixtures" "$SCRIPT_DIR/encrypt_fixture.sh" "$WORK/noto.eqrp" >/dev/null
test -s "$fixtures/noto.eqrp.age"
if cmp -s "$WORK/noto.eqrp" "$fixtures/noto.eqrp.age"; then
  echo "FAIL: ciphertext equals plaintext" >&2
  exit 1
fi

STORE_SCREENSHOT_FIXTURE_DIR="$fixtures" STORE_SCREENSHOT_FIXTURE_AGE_KEY="$key" \
  "$SCRIPT_DIR/decrypt_fixtures.sh" "$WORK/plain" >/dev/null
cmp "$WORK/noto.eqrp" "$WORK/plain/noto.eqrp"
[[ "$(stat -c %a "$WORK/plain/noto.eqrp" 2>/dev/null || stat -f %Lp "$WORK/plain/noto.eqrp")" == 600 ]]

expect_failure "invalid fixture name" env STORE_SCREENSHOT_FIXTURE_DIR="$fixtures" \
  "$SCRIPT_DIR/encrypt_fixture.sh" "$WORK/noto.eqrp" "Noto Peninsula.eqrp"
expect_failure "missing key" env -u STORE_SCREENSHOT_FIXTURE_AGE_KEY STORE_SCREENSHOT_FIXTURE_DIR="$fixtures" \
  "$SCRIPT_DIR/decrypt_fixtures.sh" "$WORK/missing"
grep -q 'STORE_SCREENSHOT_FIXTURE_AGE_KEY is not set' "$WORK/out.log"
other_key="$(age-keygen 2>/dev/null | grep '^AGE-SECRET-KEY-')"
expect_failure "wrong key" env STORE_SCREENSHOT_FIXTURE_DIR="$fixtures" STORE_SCREENSHOT_FIXTURE_AGE_KEY="$other_key" \
  "$SCRIPT_DIR/decrypt_fixtures.sh" "$WORK/wrong"
STORE_SCREENSHOT_FIXTURE_DIR="$WORK/empty" "$SCRIPT_DIR/decrypt_fixtures.sh" --allow-empty "$WORK/allowed" 2>/dev/null
test -d "$WORK/allowed"
expect_failure "no fixtures" env STORE_SCREENSHOT_FIXTURE_DIR="$WORK/empty" \
  "$SCRIPT_DIR/decrypt_fixtures.sh" "$WORK/not-allowed"
expect_failure "missing recipients" env STORE_SCREENSHOT_FIXTURE_DIR="$WORK/empty" \
  "$SCRIPT_DIR/encrypt_fixture.sh" "$WORK/noto.eqrp"

if ! command -v sops >/dev/null; then
  echo "SKIP: sops is not installed; setup_fixture_key.sh was not tested"
  echo "OK"
  exit 0
fi

repo="$WORK/repo"
mkdir -p "$repo/tool/store_screenshots/fixtures" "$repo/.config/age"
git -C "$repo" init -q
cp "$SCRIPT_DIR"/{setup_fixture_key,encrypt_fixture,decrypt_fixtures}.sh "$repo/tool/store_screenshots/"
age-keygen -o "$repo/.config/age/age.txt" 2>/dev/null
repo_recipient="$(age-keygen -y "$repo/.config/age/age.txt")"
printf '{"EXISTING":"value"}\n' >"$repo/plain.json"
sops encrypt --age "$repo_recipient" --input-type json --output-type json "$repo/plain.json" >"$repo/.env.json"
export SOPS_AGE_KEY_FILE="$repo/.config/age/age.txt"

(cd "$repo" && tool/store_screenshots/setup_fixture_key.sh >/dev/null)
fixture_key="$(sops decrypt --extract '["STORE_SCREENSHOT_FIXTURE_AGE_KEY"]' "$repo/.env.json")"
[[ "$(sops decrypt --extract '["EXISTING"]' "$repo/.env.json")" == value ]]
[[ "$(age-keygen -y <<<"$fixture_key")" == "$(cat "$repo/tool/store_screenshots/fixtures/recipients.txt")" ]]
expect_failure "setup twice without --rotate" bash -c "cd '$repo' && tool/store_screenshots/setup_fixture_key.sh"

(cd "$repo" && tool/store_screenshots/encrypt_fixture.sh "$WORK/noto.eqrp" >/dev/null)
(cd "$repo" && tool/store_screenshots/setup_fixture_key.sh --rotate >/dev/null)
rotated_key="$(sops decrypt --extract '["STORE_SCREENSHOT_FIXTURE_AGE_KEY"]' "$repo/.env.json")"
[[ "$rotated_key" != "$fixture_key" ]]
STORE_SCREENSHOT_FIXTURE_DIR="$repo/tool/store_screenshots/fixtures" STORE_SCREENSHOT_FIXTURE_AGE_KEY="$rotated_key" \
  "$SCRIPT_DIR/decrypt_fixtures.sh" "$WORK/rotated" >/dev/null
cmp "$WORK/noto.eqrp" "$WORK/rotated/noto.eqrp"

echo "OK"
