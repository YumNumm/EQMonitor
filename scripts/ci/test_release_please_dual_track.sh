#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
WORKFLOW="$ROOT_DIR/.github/workflows/release-please.yaml"
PROD_CONFIG="$ROOT_DIR/release-please-config.json"
BETA_CONFIG="$ROOT_DIR/release-please-config.beta.json"
PROD_MANIFEST="$ROOT_DIR/.release-please-manifest.json"
BETA_MANIFEST="$ROOT_DIR/.release-please-manifest.beta.json"

assert_equal() {
  local expected=$1
  local actual=$2
  local description=$3
  if [[ "$actual" != "$expected" ]]; then
    echo "$description: expected '$expected', got '$actual'" >&2
    exit 1
  fi
}

assert_contains() {
  local value=$1
  local expected=$2
  local description=$3
  if [[ "$value" != *"$expected"* ]]; then
    echo "$description: '$expected' was not found" >&2
    exit 1
  fi
}

python3 -c "import json; json.load(open('$PROD_CONFIG')); json.load(open('$BETA_CONFIG')); json.load(open('$PROD_MANIFEST')); json.load(open('$BETA_MANIFEST'))"

prod_job_config=$(mise exec -- yq -r \
  '.jobs.release-please.steps[] | select(.uses != null and (.uses | test("release-please-action"))) | .with["config-file"]' \
  "$WORKFLOW")
assert_equal release-please-config.json "$prod_job_config" "prod config-file"

prod_job_manifest=$(mise exec -- yq -r \
  '.jobs.release-please.steps[] | select(.uses != null and (.uses | test("release-please-action"))) | .with["manifest-file"]' \
  "$WORKFLOW")
assert_equal .release-please-manifest.json "$prod_job_manifest" "prod manifest-file"

beta_job_config=$(mise exec -- yq -r \
  '.jobs.release-please-beta.steps[] | select(.uses != null and (.uses | test("release-please-action"))) | .with["config-file"]' \
  "$WORKFLOW")
assert_equal release-please-config.beta.json "$beta_job_config" "beta config-file"

beta_job_manifest=$(mise exec -- yq -r \
  '.jobs.release-please-beta.steps[] | select(.uses != null and (.uses | test("release-please-action"))) | .with["manifest-file"]' \
  "$WORKFLOW")
assert_equal .release-please-manifest.beta.json "$beta_job_manifest" "beta manifest-file"

beta_component=$(mise exec -- yq -r '.packages["."].component' "$BETA_CONFIG")
assert_equal eqmonitor-beta "$beta_component" "beta component name"

prod_component=$(mise exec -- yq -r '.packages["."].component // "null"' "$PROD_CONFIG")
if [[ "$prod_component" == "eqmonitor-beta" ]]; then
  echo "prod component must differ from beta component" >&2
  exit 1
fi

include_component=$(mise exec -- yq -r '.packages["."].["include-component-in-tag"]' "$BETA_CONFIG")
assert_equal false "$include_component" "beta include-component-in-tag"

prerelease=$(mise exec -- yq -r '.packages["."].prerelease' "$BETA_CONFIG")
assert_equal true "$prerelease" "beta prerelease"

prerelease_type=$(mise exec -- yq -r '.packages["."].["prerelease-type"]' "$BETA_CONFIG")
assert_equal beta "$prerelease_type" "beta prerelease-type"

versioning=$(mise exec -- yq -r '.packages["."].versioning' "$BETA_CONFIG")
assert_equal prerelease "$versioning" "beta versioning strategy"

changelog=$(mise exec -- yq -r '.packages["."].["changelog-path"]' "$BETA_CONFIG")
assert_equal CHANGELOG.beta.md "$changelog" "beta changelog path"

extra_file=$(mise exec -- yq -r '.packages["."].["extra-files"][0].path' "$BETA_CONFIG")
assert_equal app/pubspec.yaml "$extra_file" "beta extra-files path"

extra_type=$(mise exec -- yq -r '.packages["."].["extra-files"][0].type' "$BETA_CONFIG")
assert_equal generic "$extra_type" "beta extra-files type"

beta_manifest_version=$(mise exec -- yq -r '.["."]' "$BETA_MANIFEST")
assert_contains "$beta_manifest_version" '-beta.' "beta manifest prerelease version"

echo "release please dual track workflow tests passed"
