#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SIGNER="$SCRIPT_DIR/sign_ios_archive_for_export.sh"

TEST_DIR="$(mktemp -d "${TMPDIR:-/tmp}/eqmonitor-ios-signing-test.XXXXXX")"
trap 'rm -rf "$TEST_DIR"' EXIT

RUNNER_APP="$TEST_DIR/Runner.app"
FCM_EXTENSION="$RUNNER_APP/Extensions/FcmServiceExtension.appex"
mkdir -p "$FCM_EXTENSION"
cp /usr/bin/true "$RUNNER_APP/Runner"
cp /usr/bin/true "$FCM_EXTENSION/FcmServiceExtension"

plutil -create xml1 "$RUNNER_APP/Info.plist"
plutil -insert CFBundleExecutable -string Runner "$RUNNER_APP/Info.plist"
plutil -insert CFBundleIdentifier -string net.yumnumm.eqmonitor "$RUNNER_APP/Info.plist"
plutil -create xml1 "$FCM_EXTENSION/Info.plist"
plutil -insert CFBundleExecutable -string FcmServiceExtension "$FCM_EXTENSION/Info.plist"
plutil -insert CFBundleIdentifier \
  -string net.yumnumm.eqmonitor.FcmServiceExtension \
  "$FCM_EXTENSION/Info.plist"

"$SIGNER" \
  --app "$RUNNER_APP" \
  --ios-dir "$ROOT_DIR/app/ios"

RUNNER_ENTITLEMENTS="$TEST_DIR/runner-entitlements.plist"
FCM_EXTENSION_ENTITLEMENTS="$TEST_DIR/fcm-service-extension-entitlements.plist"
codesign -d --entitlements :- "$RUNNER_APP" \
  > "$RUNNER_ENTITLEMENTS" 2>/dev/null
codesign -d --entitlements :- "$FCM_EXTENSION" \
  > "$FCM_EXTENSION_ENTITLEMENTS" 2>/dev/null

EXPECTED_APP_GROUP="group.net.yumnumm.eqmonitor"
runner_app_group="$(/usr/libexec/PlistBuddy \
  -c 'Print :com.apple.security.application-groups:0' \
  "$RUNNER_ENTITLEMENTS")"
fcm_extension_app_group="$(/usr/libexec/PlistBuddy \
  -c 'Print :com.apple.security.application-groups:0' \
  "$FCM_EXTENSION_ENTITLEMENTS")"

if [[ "$runner_app_group" != "$EXPECTED_APP_GROUP" ]]; then
  echo "Runner is missing the expected App Group entitlement" >&2
  exit 1
fi

if [[ "$fcm_extension_app_group" != "$EXPECTED_APP_GROUP" ]]; then
  echo "FcmServiceExtension is missing the expected App Group entitlement" >&2
  exit 1
fi

echo "iOS archive signing preserves the shared App Group entitlement"
