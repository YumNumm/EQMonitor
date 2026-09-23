#!/usr/bin/env bash
set -euo pipefail
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
build_dir="$(mktemp -d "${TMPDIR:-/tmp}/eqmonitor-live-activity.XXXXXX")"
trap 'rm -rf "$build_dir"' EXIT
EQMONITOR_REPO_ROOT="$(cd "$script_dir/../.." && pwd)"
export EQMONITOR_REPO_ROOT
xcodegen generate --spec "$script_dir/project.yml" --project "$build_dir"
simulator_id="$(xcrun simctl list devices available --json | python3 -c '
import json, sys
for runtime, devices in sorted(json.load(sys.stdin)["devices"].items(), reverse=True):
    if ".iOS-" not in runtime:
        continue
    for device in devices:
        if device["name"].startswith("iPhone"):
            print(device["udid"])
            sys.exit(0)
sys.exit("No available iPhone simulator")
')"
xcodebuild test -project "$build_dir/LiveActivityCompatibility.xcodeproj" \
  -scheme LiveActivityCompatibilityTests \
  -destination "platform=iOS Simulator,id=$simulator_id" \
  -derivedDataPath "$build_dir/DerivedData" \
  -parallel-testing-enabled NO \
  CODE_SIGNING_ALLOWED=NO
