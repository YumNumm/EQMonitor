#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
ENSURE_TRACK="$ROOT_DIR/scripts/release/ensure_google_play_track.sh"
WORKFLOW="$ROOT_DIR/.github/workflows/deploy-app.yaml"
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

mkdir -p "$TEST_DIR/bin"
ln -s "$ROOT_DIR/scripts/ci/fixtures/fake_google_play_curl.sh" \
  "$TEST_DIR/bin/curl"

run_ensure_track() {
  local track_exists=$1
  local log_file=$2
  PATH="$TEST_DIR/bin:$PATH" \
    FAKE_CURL_LOG="$log_file" \
    FAKE_TRACK_EXISTS="$track_exists" \
    GOOGLE_PLAY_ACCESS_TOKEN=test-token \
    PACKAGE_NAME=net.yumnumm.eqmonitor \
    TRACK_NAME=external \
    "$ENSURE_TRACK"
}

missing_log="$TEST_DIR/missing.log"
run_ensure_track false "$missing_log"
grep -F -- '--request POST' "$missing_log" | grep -F '/tracks'
grep -F -- '"type":"CLOSED_TESTING"' "$missing_log"
grep -F -- '/edits/edit-1:commit' "$missing_log"
if grep -F -- '--request DELETE' "$missing_log"; then
  echo "missing track edit must not be deleted before commit" >&2
  exit 1
fi

existing_log="$TEST_DIR/existing.log"
run_ensure_track true "$existing_log"
grep -F -- '--request DELETE' "$existing_log"
if grep -F -- '"type":"CLOSED_TESTING"' "$existing_log"; then
  echo "existing track must not be created again" >&2
  exit 1
fi
if grep -F -- '/edits/edit-1:commit' "$existing_log"; then
  echo "unchanged edit must not be committed" >&2
  exit 1
fi

token_format=$(mise exec -- yq -r \
  '.jobs.deploy-android-google-play.steps[] | select(.id == "auth") | .with.token_format' \
  "$WORKFLOW")
if [[ "$token_format" != "access_token" ]]; then
  echo "Google Play auth must expose an access token" >&2
  exit 1
fi

ensure_condition=$(mise exec -- yq -r \
  '.jobs.deploy-android-google-play.steps[] | select(.name == "Ensure Google Play track exists") | .if' \
  "$WORKFLOW")
if [[ "$ensure_condition" != *"android-track == 'external'"* ]]; then
  echo "ensure track step must run only for external track" >&2
  exit 1
fi

ensure_command=$(mise exec -- yq -r \
  '.jobs.deploy-android-google-play.steps[] | select(.name == "Ensure Google Play track exists") | .run' \
  "$WORKFLOW")
if [[ "$ensure_command" != *'ensure_google_play_track.sh'* ]]; then
  echo "Deploy App must invoke the track creation script" >&2
  exit 1
fi

echo "ensure Google Play track tests passed"
