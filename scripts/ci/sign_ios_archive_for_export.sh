#!/usr/bin/env bash

set -euo pipefail

APP_PATH=""
IOS_DIR=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --app)
      APP_PATH="$2"
      shift 2
      ;;
    --ios-dir)
      IOS_DIR="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [[ ! -d "$APP_PATH" ]]; then
  echo "Runner app does not exist: $APP_PATH" >&2
  exit 1
fi

if [[ ! -d "$IOS_DIR" ]]; then
  echo "iOS source directory does not exist: $IOS_DIR" >&2
  exit 1
fi

while IFS= read -r -d '' framework; do
  codesign --force --sign "-" "$framework"
done < <(find "$APP_PATH" -depth -name "*.framework" -type d -print0)

while IFS= read -r -d '' extension; do
  extension_name="$(basename "$extension")"
  case "$extension_name" in
    AppIntentExtension.appex)
      entitlements="$IOS_DIR/AppIntentExtension.entitlements"
      ;;
    AssetDownloader.appex)
      entitlements="$IOS_DIR/AssetDownloader/AssetDownloader.entitlements"
      ;;
    FcmServiceExtension.appex)
      entitlements="$IOS_DIR/FcmServiceExtension/FcmServiceExtension.entitlements"
      ;;
    WidgetExtension.appex)
      entitlements="$IOS_DIR/WidgetExtension.entitlements"
      ;;
    *)
      echo "No entitlement mapping for embedded extension: $extension_name" >&2
      exit 1
      ;;
  esac

  codesign \
    --entitlements "$entitlements" \
    --force \
    --sign "-" \
    "$extension"
done < <(find "$APP_PATH" -depth -name "*.appex" -type d -print0)

codesign \
  --entitlements "$IOS_DIR/Runner/Runner.entitlements" \
  --force \
  --sign "-" \
  "$APP_PATH"
