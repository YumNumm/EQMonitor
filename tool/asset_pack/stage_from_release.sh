#!/usr/bin/env bash
# Download an Asset Pack from the private YumNumm/eqmonitor-backend GitHub
# Release and stage its contents into Android / macOS / iOS-native build paths.
#
# pmtiles and most parameter JSON are NOT committed to this repo — the
# canonical source is the backend Release (`asset-pack-vX.Y.Z`). Call this
# before `flutter build appbundle` (Android PAD install-time module) or a
# macOS bundle build that expects `app/assets/platform/`.
#
# iOS AppIntent/Widget slim `jma_code_table.json` is committed for local DX;
# `--target ios-native` still refreshes it from Release (CI / when updating).
#
# Usage:
#   GH_TOKEN=... stage_from_release.sh [--version X.Y.Z] --target android|macos|both|ios-native
#
# Environment:
#   GH_TOKEN                       Required. GitHub token with contents:read on eqmonitor-backend.
#   ANDROID_ASSET_PACK_ASSETS_DIR  Override (default below).
#   MACOS_ASSET_DIR                Override (default below).
#   IOS_NATIVE_JMA_CODE_TABLE      Override slim JSON output path (default below).
#
# If --version is omitted, the latest Release whose tag matches
# `asset-pack-v*` is used.
set -euo pipefail

REPO="${ASSET_PACK_RELEASE_REPO:-YumNumm/eqmonitor-backend}"
ANDROID_DIR="${ANDROID_ASSET_PACK_ASSETS_DIR:-app/android/assetpacks/eqmonitor_assets/src/main/assets}"
MACOS_DIR="${MACOS_ASSET_DIR:-app/assets/platform}"
IOS_NATIVE_JMA_CODE_TABLE="${IOS_NATIVE_JMA_CODE_TABLE:-app/assets/parameters/jma_code_table.json}"

pack_version=""
target=""

while [ "$#" -gt 0 ]; do
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
      sed -n '2,20p' "$0"
      exit 0
      ;;
    *)
      echo "stage_from_release.sh: unknown argument: $1" >&2
      exit 2
      ;;
  esac
done

if [ -z "$target" ]; then
  echo "stage_from_release.sh: --target android|macos|both|ios-native is required" >&2
  exit 2
fi
case "$target" in
  android|macos|both|ios-native) ;;
  *)
    echo "stage_from_release.sh: invalid --target '$target'" >&2
    exit 2
    ;;
esac

if [ -z "${GH_TOKEN:-}" ]; then
  echo "stage_from_release.sh: GH_TOKEN is required (private Release)" >&2
  exit 2
fi

for cmd in gh unzip jq python3; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    echo "stage_from_release.sh: required command not found: $cmd" >&2
    exit 2
  fi
done

if [ -z "$pack_version" ]; then
  echo "==> Resolving latest asset-pack-v* Release on $REPO"
  pack_version=$(
    gh release list --repo "$REPO" --limit 50 \
      --json tagName,isLatest,createdAt \
      --jq '
        [.[] | select(.tagName | startswith("asset-pack-v"))]
        | sort_by(.createdAt) | reverse | .[0].tagName // empty
      ' \
      | sed 's/^asset-pack-v//'
  )
  if [ -z "$pack_version" ]; then
    echo "stage_from_release.sh: no asset-pack-v* Release found on $REPO" >&2
    exit 1
  fi
  echo "resolved pack_version=$pack_version"
fi

tag="asset-pack-v${pack_version}"
zip_name="asset-pack-v${pack_version}.zip"
workdir=$(mktemp -d)
trap 'rm -rf "$workdir"' EXIT

echo "==> Downloading $tag / $zip_name"
gh release download "$tag" \
  --repo "$REPO" \
  --pattern "$zip_name" \
  --output "$workdir/asset-pack.zip"
test -s "$workdir/asset-pack.zip"

echo "==> Unpacking and asserting layout"
mkdir -p "$workdir/extracted"
unzip -q -o "$workdir/asset-pack.zip" -d "$workdir/extracted"

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
  if [ ! -f "$workdir/extracted/$relative_path" ]; then
    missing+=("$relative_path")
  fi
done
if [ "${#missing[@]}" -gt 0 ]; then
  echo "stage_from_release.sh: pack is missing required file(s):" >&2
  printf '  - %s\n' "${missing[@]}" >&2
  exit 1
fi

manifest_pack_version=$(jq -er '.pack_version' "$workdir/extracted/manifest.json")
if [ "$manifest_pack_version" != "$pack_version" ]; then
  echo "stage_from_release.sh: manifest pack_version ($manifest_pack_version) != requested ($pack_version)" >&2
  exit 1
fi

stage_into() {
  local dest=$1
  echo "==> Staging into $dest"
  mkdir -p "$dest"
  # Remove previous staged contents but keep the directory (and any .gitkeep).
  find "$dest" -mindepth 1 -maxdepth 1 ! -name '.gitkeep' -exec rm -rf {} +
  cp -R "$workdir/extracted/." "$dest"/
  # Drop .gitkeep once real assets are present so Gradle / Xcode see only pack files.
  rm -f "$dest/.gitkeep"
}

stage_ios_native() {
  local source="$workdir/extracted/parameters/jma_code_table.json"
  local dest="$IOS_NATIVE_JMA_CODE_TABLE"
  local dest_dir
  dest_dir=$(dirname "$dest")

  echo "==> Extracting slim jma_code_table for iOS native extensions -> $dest"
  mkdir -p "$dest_dir"
  # Only replace the slim output file. Do not wipe the whole directory —
  # IOS_NATIVE_JMA_CODE_TABLE is overridable and a mis-set dirname must
  # not delete unrelated tracked assets.
  rm -f "$dest"

  python3 -m tool.asset_pack.extract_ios_native_jma_code_table \
    --source "$source" \
    --destination "$dest"

  test -s "$dest"
}

case "$target" in
  android)
    stage_into "$ANDROID_DIR"
    ;;
  macos)
    stage_into "$MACOS_DIR"
    ;;
  both)
    stage_into "$ANDROID_DIR"
    stage_into "$MACOS_DIR"
    ;;
  ios-native)
    stage_ios_native
    ;;
esac

echo "stage_from_release.sh: OK (pack_version=$pack_version, target=$target)"
