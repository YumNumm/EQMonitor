#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
APP_BUILD_GRADLE="$ROOT_DIR/app/android/app/build.gradle.kts"
APP_NDK_VERSION="$(sed -n 's/.*ndkVersion = "\([^"]*\)".*/\1/p' "$APP_BUILD_GRADLE" | head -n 1)"
if [[ -z "$APP_NDK_VERSION" ]]; then
  echo "::error::Failed to read ndkVersion from app/android/app/build.gradle.kts"
  exit 1
fi

ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-${ANDROID_HOME:-}}"
if [[ -z "$ANDROID_SDK_ROOT" ]]; then
  echo "::error::ANDROID_SDK_ROOT or ANDROID_HOME must be set"
  exit 1
fi

SDKMANAGER="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager"
if [[ ! -x "$SDKMANAGER" ]]; then
  echo "::error::sdkmanager not found at ${SDKMANAGER}"
  exit 1
fi

FLUTTER_NDK_VERSION=""
if flutter_bin="$(command -v flutter)"; then
  FLUTTER_ROOT="$(cd "$(dirname "$flutter_bin")/.." && pwd)"
  FLUTTER_NDK_VERSION="$(grep -Rho 'ndkVersion = "[0-9.]*"' \
    "$FLUTTER_ROOT/packages/flutter_tools/gradle" 2>/dev/null \
    | head -n 1 \
    | sed 's/.*"\([^"]*\)".*/\1/')"
fi

declare -a NDK_VERSIONS=()
append_unique_version() {
  local version=$1
  if [[ -z "$version" ]]; then
    return
  fi
  for existing in "${NDK_VERSIONS[@]}"; do
    if [[ "$existing" == "$version" ]]; then
      return
    fi
  done
  NDK_VERSIONS+=("$version")
}

append_unique_version "$FLUTTER_NDK_VERSION"
append_unique_version "$APP_NDK_VERSION"

install_ndk_version() {
  local version=$1
  local package="ndk;${version}"
  local ndk_dir="$ANDROID_SDK_ROOT/ndk/${version}"
  local attempt
  for attempt in 1 2 3; do
    echo "Installing ${package} (attempt ${attempt}/3)"
    if "$SDKMANAGER" --install "$package"; then
      return 0
    fi

    echo "::warning::NDK install failed for ${package}; cleaning partial download before retry"
    rm -rf "$ndk_dir"
    rm -rf "$ANDROID_SDK_ROOT/.temp" 2>/dev/null || true
    sleep $((attempt * 10))
  done

  echo "::error::Failed to install ${package} after 3 attempts"
  return 1
}

for version in "${NDK_VERSIONS[@]}"; do
  install_ndk_version "$version"
done
