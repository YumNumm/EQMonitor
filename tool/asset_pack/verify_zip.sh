#!/usr/bin/env bash
# Verify and unpack an Asset Pack zip (asset-pack-vX.Y.Z.zip) produced by
# eqmonitor-backend's release-asset-pack.yaml workflow.
#
# Checks performed, in order:
#   1. sha256 checksum of the zip matches the expected value.
#   2. The zip unpacks and contains the mandated layout:
#        manifest.json
#        map/all.pmtiles
#        parameters/{jma_code_table,earthquake_stations,tsunami_stations,
#                    kyoshin_observation_points,shindo_db_stations}.json
#   3. manifest.json's "pack_version" field matches the expected pack_version
#      (guards against a mismatched/stale artifact_url or sha256 override).
#
# Usage:
#   verify_zip.sh <zip_path> <expected_sha256> <expected_pack_version> <output_dir>
#
# On success, exits 0 and leaves the unpacked contents in <output_dir>.
# On any failure, prints a clear reason to stderr and exits non-zero.
set -euo pipefail

if [ "$#" -ne 4 ]; then
  echo "Usage: verify_zip.sh <zip_path> <expected_sha256> <expected_pack_version> <output_dir>" >&2
  exit 2
fi

zip_path=$1
expected_sha256=$2
expected_pack_version=$3
output_dir=$4

for cmd in sha256sum unzip jq; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "verify_zip.sh: required command not found: $cmd" >&2
    exit 2
  fi
done

if [ ! -f "$zip_path" ]; then
  echo "verify_zip.sh: zip not found: $zip_path" >&2
  exit 1
fi

echo "==> Verifying sha256 checksum"
if ! printf '%s  %s\n' "$expected_sha256" "$zip_path" | sha256sum -c -; then
  echo "verify_zip.sh: sha256 checksum mismatch for $zip_path (expected $expected_sha256)" >&2
  exit 1
fi

echo "==> Unpacking $zip_path to $output_dir"
mkdir -p "$output_dir"
unzip -q -o "$zip_path" -d "$output_dir"

echo "==> Asserting mandated pack layout"
required_relative_paths=(
  "manifest.json"
  "map/all.pmtiles"
  "parameters/jma_code_table.json"
  "parameters/earthquake_stations.json"
  "parameters/tsunami_stations.json"
  "parameters/kyoshin_observation_points.json"
  "parameters/shindo_db_stations.json"
)

missing=()
for relative_path in "${required_relative_paths[@]}"; do
  if [ ! -f "$output_dir/$relative_path" ]; then
    missing+=("$relative_path")
  fi
done

if [ "${#missing[@]}" -gt 0 ]; then
  echo "verify_zip.sh: pack is missing required file(s):" >&2
  for m in "${missing[@]}"; do
    echo "  - $m" >&2
  done
  exit 1
fi

echo "==> Asserting manifest.json pack_version matches expected value"
manifest_pack_version=$(jq -er '.pack_version' "$output_dir/manifest.json")
if [ "$manifest_pack_version" != "$expected_pack_version" ]; then
  echo "verify_zip.sh: manifest.json pack_version ($manifest_pack_version) does not match expected pack_version ($expected_pack_version)" >&2
  exit 1
fi

echo "verify_zip.sh: OK (pack_version=$manifest_pack_version, output_dir=$output_dir)"
