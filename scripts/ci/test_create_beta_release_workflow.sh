#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
WORKFLOW="$ROOT_DIR/.github/workflows/create-beta-release.yaml"

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

assert_null() {
  local actual=$1
  local description=$2
  if [[ "$actual" != "null" ]]; then
    echo "$description: expected null, got '$actual'" >&2
    exit 1
  fi
}

issue_comment=$(mise exec -- yq -r '.on.issue_comment' "$WORKFLOW")
assert_null "$issue_comment" "issue_comment trigger removed"

version_required=$(mise exec -- yq -r \
  '.on.workflow_dispatch.inputs.version.required' "$WORKFLOW")
assert_equal true "$version_required" "version input required"

repair_type=$(mise exec -- yq -r \
  '.on.workflow_dispatch.inputs.repair_existing_release.type' "$WORKFLOW")
assert_equal boolean "$repair_type" "repair input type"

create_release_condition=$(mise exec -- yq -r \
  '.jobs.create-beta.steps[] | select(.name == "Create GitHub pre-release") | .if' "$WORKFLOW")
assert_contains "$create_release_condition" '!inputs.repair_existing_release' \
  "create release repair guard"

create_release_command=$(mise exec -- yq -r \
  '.jobs.create-beta.steps[] | select(.name == "Create GitHub pre-release") | .run' "$WORKFLOW")
assert_contains "$create_release_command" 'sanitize_release_notes.py' \
  "create release sanitizer"
assert_contains "$create_release_command" '--notes-file' \
  "create release notes file"
if [[ "$create_release_command" == *'--generate-notes'* ]]; then
  echo "create release must not use --generate-notes" >&2
  exit 1
fi

repair_condition=$(mise exec -- yq -r \
  '.jobs.create-beta.steps[] | select(.name == "Repair existing GitHub pre-release") | .if' "$WORKFLOW")
assert_contains "$repair_condition" 'inputs.repair_existing_release' \
  "repair mode condition"

repair_command=$(mise exec -- yq -r \
  '.jobs.create-beta.steps[] | select(.name == "Repair existing GitHub pre-release") | .run' "$WORKFLOW")
assert_contains "$repair_command" 'sanitize_release_notes.py' \
  "repair release sanitizer"
assert_contains "$repair_command" 'gh release edit' \
  "repair release edit"

echo "create beta release workflow tests passed"
