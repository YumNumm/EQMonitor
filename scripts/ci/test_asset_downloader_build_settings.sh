#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
PROJECT="$ROOT_DIR/app/ios/Runner.xcodeproj"

settings="$(mise exec -- ruby -r xcodeproj -e '
  project = Xcodeproj::Project.open(ARGV.fetch(0))
  target = project.targets.find { |item| item.name == "AssetDownloader" }
  abort "AssetDownloader target not found" unless target
  config = target.build_configurations.find { |item| item.name == "Release" }
  abort "AssetDownloader Release configuration not found" unless config
  puts config.build_settings.values_at(
    "DEVELOPMENT_TEAM",
    "CODE_SIGN_ENTITLEMENTS",
  )
' "$PROJECT")"

development_team="$(sed -n '1p' <<< "$settings")"
code_sign_entitlements="$(sed -n '2p' <<< "$settings")"

if [[ "$development_team" != "CPL7H8SHVM" ]]; then
  echo "AssetDownloader DEVELOPMENT_TEAM is $development_team, expected CPL7H8SHVM" >&2
  exit 1
fi

if [[ "$code_sign_entitlements" != \
  "AssetDownloader/AssetDownloader.entitlements" ]]; then
  echo "AssetDownloader CODE_SIGN_ENTITLEMENTS is incorrect: $code_sign_entitlements" >&2
  exit 1
fi

echo "AssetDownloader uses the production team and entitlement file"
