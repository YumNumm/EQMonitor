#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
INSTALL="$ROOT_DIR/scripts/ci/install_android_ndk.sh"
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

mkdir -p "$TEST_DIR/android-sdk/cmdline-tools/latest/bin" \
  "$TEST_DIR/android-sdk/ndk"

cat >"$TEST_DIR/android-sdk/cmdline-tools/latest/bin/sdkmanager" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
printf '%s\n' "$*" >> "$FAKE_SDKMANAGER_LOG"
case "$*" in
  *"ndk;28.2.13676358"*)
    if [[ "${FAIL_NDK_28:-}" == "1" ]]; then
      count="$(cat "${FAIL_NDK_28_MARKER:?}" 2>/dev/null || echo 0)"
      if [[ "$count" -lt 1 ]]; then
        echo 1 >"${FAIL_NDK_28_MARKER}"
        exit 1
      fi
    fi
    mkdir -p "$ANDROID_SDK_ROOT/ndk/28.2.13676358"
    ;;
  *"ndk;29.0.14206865"*)
    mkdir -p "$ANDROID_SDK_ROOT/ndk/29.0.14206865"
    ;;
  *)
    echo "unexpected sdkmanager args: $*" >&2
    exit 1
    ;;
esac
EOF
chmod +x "$TEST_DIR/android-sdk/cmdline-tools/latest/bin/sdkmanager"

mkdir -p "$TEST_DIR/flutter/bin"
cat >"$TEST_DIR/flutter/bin/flutter" <<'EOF'
#!/usr/bin/env bash
exit 0
EOF
chmod +x "$TEST_DIR/flutter/bin/flutter"

mkdir -p "$TEST_DIR/flutter/packages/flutter_tools/gradle/src/main/kotlin"
cat >"$TEST_DIR/flutter/packages/flutter_tools/gradle/src/main/kotlin/FlutterExtension.kt" <<'EOF'
const val ndkVersion = "28.2.13676358"
EOF

run_install() {
  local marker="$TEST_DIR/fail-marker-$$"
  : >"$marker"
  PATH="$TEST_DIR/flutter/bin:$TEST_DIR/android-sdk/cmdline-tools/latest/bin:$PATH" \
    ANDROID_SDK_ROOT="$TEST_DIR/android-sdk" \
    FAKE_SDKMANAGER_LOG="$1" \
    FAIL_NDK_28="${2:-0}" \
    FAIL_NDK_28_MARKER="$marker" \
    "$INSTALL"
}

LOG="$TEST_DIR/first.log"
run_install "$LOG"
grep -Fq 'ndk;28.2.13676358' "$LOG"
grep -Fq 'ndk;29.0.14206865' "$LOG"
test -d "$TEST_DIR/android-sdk/ndk/28.2.13676358"
test -d "$TEST_DIR/android-sdk/ndk/29.0.14206865"

RETRY_LOG="$TEST_DIR/retry.log"
run_install "$RETRY_LOG" 1
grep -c 'ndk;28.2.13676358' "$RETRY_LOG" | grep -Fx '2' >/dev/null

echo "install_android_ndk.sh tests passed"
