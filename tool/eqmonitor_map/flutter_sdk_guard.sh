#!/usr/bin/env bash

set -euo pipefail

sdk_dir="${1:-}"
expected_revision="${2:-}"
sdk_tool="${3:-}"

case "$expected_revision" in
  ''|*[!0-9a-f]*|???????????????????????????????????????|?????????????????????????????????????????*)
    echo "expected Flutter revision must be 40-character lowercase hexadecimal" >&2
    exit 64
    ;;
esac

case "$sdk_tool" in
  flutter|dart) ;;
  *)
    echo "unsupported pinned Flutter tool: $sdk_tool" >&2
    exit 64
    ;;
esac

bootstrap_hint="run mise bootstrap repos apply --yes"
if [[ ! -d "$sdk_dir" ]]; then
  echo "Flutter SDK checkout is missing; must be $expected_revision; $bootstrap_hint" >&2
  exit 78
fi

checkout_root="$(git -C "$sdk_dir" rev-parse --show-toplevel 2>/dev/null || true)"
if [[ -z "$checkout_root" || "$checkout_root" != "$(cd "$sdk_dir" && pwd -P)" ]]; then
  echo "Flutter SDK path is not a git checkout; must be $expected_revision; $bootstrap_hint" >&2
  exit 78
fi

actual_revision="$(git -C "$sdk_dir" rev-parse HEAD 2>/dev/null || true)"
if [[ "$actual_revision" != "$expected_revision" ]]; then
  echo "Flutter SDK must be $expected_revision; $bootstrap_hint" >&2
  exit 78
fi

if [[ -n "$(git -C "$sdk_dir" status --porcelain --untracked-files=no)" ]]; then
  echo "Flutter SDK tracked files must be clean at $expected_revision; $bootstrap_hint" >&2
  exit 78
fi

sdk_executable="$sdk_dir/bin/$sdk_tool"
if [[ ! -x "$sdk_executable" ]]; then
  echo "Flutter SDK executable is missing: $sdk_executable; $bootstrap_hint" >&2
  exit 78
fi

exec "$sdk_executable" "${@:4}"
