#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
ROOT_DIR=$(cd "$SCRIPT_DIR/../.." && pwd)
RESOLVER="$SCRIPT_DIR/resolve_deploy_app_policy.sh"
WORKFLOW="$ROOT_DIR/.github/workflows/deploy-app.yaml"
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
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=true\nandroid-track=external\nis-beta-testing=true\n' \
  EVENT_NAME=push \
  REF_TYPE=tag \
  REF_NAME=v3.0.0-beta.2 \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=false

assert_policy \
  develop \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=false\nandroid-track=internal\nis-beta-testing=false\n' \
  EVENT_NAME=push \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[{"message":"fix: ordinary push"}]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=false

assert_policy \
  develop-external \
  $'deploy-ios=true\ndeploy-android=true\ndeploy-ios-external=true\nandroid-track=internal\nis-beta-testing=false\n' \
  EVENT_NAME=push \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[{"message":"feat: distribute [external]"}]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=false

assert_policy \
  workflow-dispatch \
  $'deploy-android=true\ndeploy-ios-external=true\nandroid-track=internal\nis-beta-testing=false\n' \
  EVENT_NAME=workflow_dispatch \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=true \
  INPUT_EXTERNAL=true \
  INPUT_IS_BETA_TESTING=false

assert_policy \
  workflow-dispatch-beta \
  $'deploy-ios=true\ndeploy-ios-external=false\nandroid-track=internal\nis-beta-testing=true\n' \
  EVENT_NAME=workflow_dispatch \
  REF_TYPE=branch \
  REF_NAME=develop \
  COMMITS_JSON='[]' \
  INPUT_IOS=true \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=true

if env \
  EVENT_NAME=push \
  REF_TYPE=tag \
  REF_NAME=v3.0.0 \
  COMMITS_JSON='[]' \
  INPUT_IOS=false \
  INPUT_ANDROID=false \
  INPUT_EXTERNAL=false \
  INPUT_IS_BETA_TESTING=false \
  "$RESOLVER" > "$TEST_DIR/unsupported.stdout" 2> "$TEST_DIR/unsupported.stderr"; then
  echo "unsupported ref unexpectedly succeeded" >&2
  exit 1
fi

grep -Fx "Unsupported deployment event/ref: push tag v3.0.0" \
  "$TEST_DIR/unsupported.stderr"

checkout_index=$(mise exec -- yq -r \
  '.jobs.define-matrix.steps | to_entries | map(select(.value.uses == "actions/checkout@3d3c42e5aac5ba805825da76410c181273ba90b1")) | .[0].key // ""' \
  "$WORKFLOW")
resolver_index=$(mise exec -- yq -r \
  '.jobs.define-matrix.steps | to_entries | map(select((.value.run // "") | contains("scripts/ci/resolve_deploy_app_policy.sh"))) | .[0].key // ""' \
  "$WORKFLOW")

if [[ -z "$checkout_index" || -z "$resolver_index" || "$checkout_index" -ge "$resolver_index" ]]; then
  echo "define-matrix must checkout the repository before invoking the deploy policy resolver" >&2
  exit 1
fi

echo "deploy app policy tests passed"
