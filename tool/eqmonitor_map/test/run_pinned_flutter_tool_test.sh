#!/usr/bin/env bash

set -euo pipefail

test_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
tool_dir="$(cd "$test_dir/.." && pwd -P)"
runner_source="$tool_dir/run_pinned_flutter_tool"
guard_source="$tool_dir/flutter_sdk_guard.sh"
expected_pinned_revision=de01d5daa62dcb2fd0378d55206c91e4cf008923

fail() {
  echo "FAIL: $1" >&2
  exit 1
}

assert_failed_with() {
  local expected_text="$1"
  shift
  local output

  if output="$("$@" 2>&1)"; then
    fail "command unexpectedly succeeded: $*"
  fi
  case "$output" in
    *"$expected_text"*) ;;
    *) fail "output did not contain '$expected_text': $output" ;;
  esac
}

temporary_dir="$(mktemp -d)"
trap 'rm -rf "$temporary_dir"' EXIT

test_tool_dir="$temporary_dir/project/tool/eqmonitor_map"
mkdir -p "$test_tool_dir"
cp "$runner_source" "$guard_source" "$test_tool_dir"
runner="$test_tool_dir/run_pinned_flutter_tool"
guard="$test_tool_dir/flutter_sdk_guard.sh"

output="$($runner flutter --version 2>&1)" && fail "missing SDK unexpectedly succeeded"
case "$output" in
  *"$expected_pinned_revision"*"mise bootstrap repos apply --yes"*) ;;
  *) fail "missing SDK diagnostic did not identify the pinned bootstrap: $output" ;;
esac

for command in upgrade downgrade channel; do
  assert_failed_with "refuses self-update command: flutter $command" \
    "$runner" flutter "$command"
done

missing_checkout="$temporary_dir/missing"
assert_failed_with "Flutter SDK checkout is missing" \
  "$guard" "$missing_checkout" "$expected_pinned_revision" flutter

non_git_checkout="$temporary_dir/non-git"
mkdir -p "$non_git_checkout/bin"
touch "$non_git_checkout/bin/flutter"
chmod +x "$non_git_checkout/bin/flutter"
assert_failed_with "not a git checkout" \
  "$guard" "$non_git_checkout" "$expected_pinned_revision" flutter

sdk_checkout="$temporary_dir/flutter"
git init -q "$sdk_checkout"
git -C "$sdk_checkout" config user.email test@example.com
git -C "$sdk_checkout" config user.name "Pinned Flutter Test"
mkdir -p "$sdk_checkout/bin"
printf '#!/usr/bin/env bash\nprintf "fake flutter: %%s\\n" "$*"\n' \
  >"$sdk_checkout/bin/flutter"
chmod +x "$sdk_checkout/bin/flutter"
git -C "$sdk_checkout" add bin/flutter
git -C "$sdk_checkout" commit -qm "test SDK"
valid_revision="$(git -C "$sdk_checkout" rev-parse HEAD)"
wrong_revision=0000000000000000000000000000000000000000

assert_failed_with "must be $wrong_revision" \
  "$guard" "$sdk_checkout" "$wrong_revision" flutter
assert_failed_with "40-character lowercase hexadecimal" \
  "$guard" "$sdk_checkout" INVALID flutter

printf '# dirty\n' >>"$sdk_checkout/bin/flutter"
assert_failed_with "tracked files must be clean" \
  "$guard" "$sdk_checkout" "$valid_revision" flutter
git -C "$sdk_checkout" restore bin/flutter

valid_output="$($guard "$sdk_checkout" "$valid_revision" flutter alpha beta)"
[[ "$valid_output" == "fake flutter: alpha beta" ]] || \
  fail "valid checkout did not execute its SDK tool: $valid_output"

assert_failed_with "unsupported pinned Flutter tool" \
  "$guard" "$sdk_checkout" "$valid_revision" pub

echo "PASS: pinned Flutter runner and SDK guard"
