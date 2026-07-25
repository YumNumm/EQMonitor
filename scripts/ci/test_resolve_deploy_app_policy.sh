#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
RESOLVER="$SCRIPT_DIR/resolve_deploy_app_policy.sh"
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

assert_policy() {
  local name=$1
  local expected=$2
  shift 2
  local actual="$TEST_DIR/$name.actual"
  local expected_file="$TEST_DIR/$name.expected"

  env "$@" "$RESOLVER" > "$actual"
  printf '%s' "$expected" > "$expected_file"
  diff -u "$expected_file" "$actual"
}

assert_policy \
  beta-tag \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=true\nandroid-track=external\n' \
  EVENT_NAME=push \
  REF_TYPE=tag \
  REF_NAME=v3.0.0-beta.2 \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false

assert_policy \
  develop \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=false\nandroid-track=internal\n' \
  EVENT_NAME=push \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[{"message":"fix: ordinary push"}]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false

assert_policy \
  develop-external \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=true\nandroid-track=internal\n' \
  EVENT_NAME=push \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[{"message":"feat: distribute [external]"}]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false

assert_policy \
  workflow-dispatch \
  $'deploy-android=true\ndeploy-ios-external=true\nandroid-track=internal\n' \
  EVENT_NAME=workflow_dispatch \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=true \
  INPUT_EXTERNAL=true

if env \
  EVENT_NAME=push \
  REF_TYPE=tag \
  REF_NAME=v3.0.0 \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  "$RESOLVER" > "$TEST_DIR/unsupported.stdout" 2> "$TEST_DIR/unsupported.stderr"; then
  echo "unsupported ref unexpectedly succeeded" >&2
  exit 1
fi

grep -Fx "Unsupported deployment event/ref: push tag v3.0.0" \
  "$TEST_DIR/unsupported.stderr"

echo "deploy app policy tests passed"
