#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
SIGNER="$SCRIPT_DIR/sign_ios_archive_for_export.sh"

TEST_DIR="$(mktemp -d "${TMPDIR:-/tmp}/eqmonitor-ios-signing-test.XXXXXX")"
trap 'rm -rf "$TEST_DIR"' EXIT

RUNNER_APP="$TEST_DIR/Runner.app"
ASSET_DOWNLOADER="$RUNNER_APP/Extensions/AssetDownloader.appex"
mkdir -p "$ASSET_DOWNLOADER"
cp /usr/bin/true "$RUNNER_APP/Runner"
cp /usr/bin/true "$ASSET_DOWNLOADER/AssetDownloader"

plutil -create xml1 "$RUNNER_APP/Info.plist"
plutil -insert CFBundleExecutable -string Runner "$RUNNER_APP/Info.plist"
plutil -insert CFBundleIdentifier -string net.yumnumm.eqmonitor "$RUNNER_APP/Info.plist"
plutil -create xml1 "$ASSET_DOWNLOADER/Info.plist"
plutil -insert CFBundleExecutable -string AssetDownloader "$ASSET_DOWNLOADER/Info.plist"
plutil -insert CFBundleIdentifier \
  -string net.yumnumm.eqmonitor.AssetDownloader \
  "$ASSET_DOWNLOADER/Info.plist"

"$SIGNER" \
  --app "$RUNNER_APP" \
  --ios-dir "$ROOT_DIR/app/ios"

RUNNER_ENTITLEMENTS="$TEST_DIR/runner-entitlements.plist"
ASSET_DOWNLOADER_ENTITLEMENTS="$TEST_DIR/asset-downloader-entitlements.plist"
codesign -d --entitlements :- "$RUNNER_APP" \
  > "$RUNNER_ENTITLEMENTS" 2>/dev/null
codesign -d --entitlements :- "$ASSET_DOWNLOADER" \
  > "$ASSET_DOWNLOADER_ENTITLEMENTS" 2>/dev/null

EXPECTED_APP_GROUP="group.net.yumnumm.eqmonitor"
runner_app_group="$(/usr/libexec/PlistBuddy \
  -c 'Print :com.apple.security.application-groups:0' \
  "$RUNNER_ENTITLEMENTS")"
asset_downloader_app_group="$(/usr/libexec/PlistBuddy \
  -c 'Print :com.apple.security.application-groups:0' \
  "$ASSET_DOWNLOADER_ENTITLEMENTS")"

if [[ "$runner_app_group" != "$EXPECTED_APP_GROUP" ]]; then
  echo "Runner is missing the expected App Group entitlement" >&2
  exit 1
fi

if [[ "$asset_downloader_app_group" != "$EXPECTED_APP_GROUP" ]]; then
  echo "AssetDownloader is missing the expected App Group entitlement" >&2
  exit 1
fi

echo "iOS archive signing preserves the shared App Group entitlement"
