#!/usr/bin/env bash
# Download a signed Asset Pack from the public R2 distribution and stage it
# into the app-bundled platform directory and/or the slim native JMA table.
set -euo pipefail

BASE_URL="${ASSET_PACK_BASE_URL:-https://assets.eqmonitor.app/v1/assets}"
BUNDLED_DIR="${BUNDLED_ASSET_PACK_DIR:-app/assets/platform}"
IOS_NATIVE_JMA_CODE_TABLE="${IOS_NATIVE_JMA_CODE_TABLE:-app/assets/parameters/jma_code_table.json}"
KEY_ID="${ASSET_PACK_SIGNING_KEY_ID:-asset-pack-2026-08-16}"
PUBLIC_KEY="${ASSET_PACK_PUBLIC_KEY:-tool/asset_pack/trusted_keys/${KEY_ID}.pem}"

pack_version=''
target=''

while [[ $# -gt 0 ]]; do
  case "$1" in
    --version)
      pack_version="${2:-}"
      shift 2
      ;;
    --target)
      target="${2:-}"
      shift 2
      ;;
    -h|--help)
      sed -n '2,24p' "$0"
      exit 0
      ;;
    *)
      echo "stage_from_r2.sh: unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

case "$target" in
  bundled|ios-native|all) ;;
  *)
    echo 'stage_from_r2.sh: --target bundled|ios-native|all is required' >&2
    exit 2
    ;;
esac

for cmd in curl jq node python3 unzip; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "stage_from_r2.sh: required command not found: $cmd" >&2
    exit 2
  fi
done
if [[ ! -f "$PUBLIC_KEY" ]]; then
  echo "stage_from_r2.sh: trusted public key not found: $PUBLIC_KEY" >&2
  exit 2
fi

work_dir=$(mktemp -d)
trap 'rm -rf "$work_dir"' EXIT

download() {
  local url=$1
  local output=$2
  curl --fail --location --retry 5 --retry-all-errors \
    --output "$output" "$url"
  test -s "$output"
}

echo '==> Downloading signed R2 distribution manifest'
download "$BASE_URL/manifest.json" "$work_dir/manifest.json"
download "$BASE_URL/manifest.sig" "$work_dir/manifest.sig"

if [[ -z "$pack_version" ]]; then
  pack_version=$(jq -er '.latest_version' "$work_dir/manifest.json")
fi
if [[ ! "$pack_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "stage_from_r2.sh: invalid pack version: $pack_version" >&2
  exit 1
fi

archive_sha256=$(jq -er --arg version "$pack_version" \
  '.packs[] | select(.version == $version) | .archive_sha256' \
  "$work_dir/manifest.json")
archive_url="$BASE_URL/packs/$pack_version/asset-pack-v$pack_version.zip"
echo "==> Downloading Asset Pack v$pack_version"
download "$archive_url" "$work_dir/asset-pack.zip"

node tool/asset_pack/verify_r2_distribution.mjs \
  --manifest "$work_dir/manifest.json" \
  --signature "$work_dir/manifest.sig" \
  --archive "$work_dir/asset-pack.zip" \
  --version "$pack_version" \
  --sha256 "$archive_sha256" \
  --public-key "$KEY_ID=$PUBLIC_KEY"

tool/asset_pack/verify_zip.sh \
  "$work_dir/asset-pack.zip" "$archive_sha256" "$pack_version" \
  "$work_dir/extracted"

stage_bundled_pack() {
  local destination=$1
  local parent
  local staged
  local previous
  if [[ "$(basename "$destination")" != 'platform' || -L "$destination" ]]; then
    echo "stage_from_r2.sh: bundled destination must be a non-symlink platform directory: $destination" >&2
    exit 1
  fi
  parent=$(dirname "$destination")
  mkdir -p "$parent"
  staged=$(mktemp -d "$parent/.platform-staged.XXXXXX")
  previous="$parent/.platform-previous"
  cp -R "$work_dir/extracted/." "$staged/"

  if [[ -e "$previous" ]]; then
    echo "stage_from_r2.sh: stale staging backup exists: $previous" >&2
    exit 1
  fi
  if [[ -e "$destination" ]]; then
    mv "$destination" "$previous"
  fi
  if ! mv "$staged" "$destination"; then
    if [[ -e "$previous" ]]; then
      mv "$previous" "$destination"
    fi
    exit 1
  fi
  if [[ -e "$previous" ]]; then
    rm -rf "$previous"
  fi
}

stage_ios_native() {
  local source="$work_dir/extracted/parameters/jma_code_table.json"
  local destination="$IOS_NATIVE_JMA_CODE_TABLE"
  mkdir -p "$(dirname "$destination")"
  python3 -m tool.asset_pack.extract_ios_native_jma_code_table \
    --source "$source" \
    --destination "$destination"
  test -s "$destination"
}

case "$target" in
  bundled)
    stage_bundled_pack "$BUNDLED_DIR"
    ;;
  ios-native)
    stage_ios_native
    ;;
  all)
    stage_bundled_pack "$BUNDLED_DIR"
    stage_ios_native
    ;;
esac

echo "stage_from_r2.sh: OK (pack_version=$pack_version, target=$target)"
