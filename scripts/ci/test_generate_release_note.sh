#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
GEN="$SCRIPT_DIR/generate_release_note.sh"
CLEANUP_DIRS=()
trap 'for dir in "${CLEANUP_DIRS[@]}"; do rm -rf "$dir"; done' EXIT

new_repo() {
	local repo
	repo=$(mktemp -d)
	CLEANUP_DIRS+=("$repo")
	git -C "$repo" init -q
	git -C "$repo" config user.email t@example.com
	git -C "$repo" config user.name t
	echo "$repo"
}

run_gen() {
	local repo=$1
	local platform=$2
	local output=$3
	shift 3
	env REPO_ROOT="$repo" PLATFORM="$platform" OUTPUT_PATH="$output" "$@" bash "$GEN"
}

# squash / merge / direct commit
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'base' -q
BASE=$(git -C "$REPO" rev-parse HEAD)
git -C "$REPO" commit --allow-empty -m 'feat: hello (#42)' -q
git -C "$REPO" commit --allow-empty -m 'chore: direct' -q

OUT="$REPO/notes.txt"
run_gen "$REPO" ios "$OUT" BASE_SHA="$BASE"

grep -F '・#42 feat: hello' "$OUT"
grep -E 'その他 1 件' "$OUT"
grep -E "^rev: $(git -C "$REPO" rev-parse HEAD)$" "$OUT"

# BASE_SHA unset -> cannot resolve previous build
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'only' -q
OUT="$REPO/unresolved.txt"
run_gen "$REPO" android "$OUT"

grep -F '前回の配信ビルドを特定できなかった' "$OUT"
grep -E "^rev: $(git -C "$REPO" rev-parse HEAD)$" "$OUT"
if grep -F '・#' "$OUT" || grep -E 'その他 [0-9]+ 件' "$OUT"; then
	echo 'unresolved BASE_SHA must not list changes' >&2
	exit 1
fi

# BASE_SHA == HEAD -> no changes
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'base' -q
HEAD_SHA=$(git -C "$REPO" rev-parse HEAD)
OUT="$REPO/no-changes.txt"
run_gen "$REPO" ios "$OUT" BASE_SHA="$HEAD_SHA"

grep -F '前回の配信から変更はありません。' "$OUT"
grep -E "^rev: ${HEAD_SHA}$" "$OUT"

# invalid PLATFORM
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'base' -q
OUT="$REPO/bad-platform.txt"
if REPO_ROOT="$REPO" PLATFORM=windows OUTPUT_PATH="$OUT" bash "$GEN"; then
	echo 'invalid PLATFORM must fail' >&2
	exit 1
fi
