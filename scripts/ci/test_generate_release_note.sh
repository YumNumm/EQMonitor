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
	git -C "$repo" config commit.gpgSign false
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

# beta Release Please tag -> use only the matching CHANGELOG.beta.md section
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'base' -q
BASE=$(git -C "$REPO" rev-parse HEAD)
git -C "$REPO" commit --allow-empty -m 'feat: beta change (#43)' -q
CHANGELOG="$REPO/CHANGELOG.beta.md"
cat >"$CHANGELOG" <<'EOF'
# Changelog (Beta)

## [3.0.0-beta.2](https://example.com/beta.2) (2026-08-24)

### Features

* **map:** 新しい地図表示を追加する ([abcdef0](https://example.com/commit/abcdef0))

### Bug Fixes

* 表示崩れを修正する ([1234567](https://example.com/commit/1234567))

## [3.0.0-beta.1](https://example.com/beta.1) (2026-08-23)

### Features

* 前回 beta の変更は含めない ([7654321](https://example.com/commit/7654321))
EOF

OUT="$REPO/beta-changelog.txt"
GITHUB_REF_TYPE=tag \
	GITHUB_REF_NAME=v3.0.0-beta.2 \
	run_gen "$REPO" ios "$OUT" BASE_SHA="$BASE"

grep -F '新機能' "$OUT"
grep -F '・map: 新しい地図表示を追加する' "$OUT"
grep -F '不具合修正' "$OUT"
grep -F '・表示崩れを修正する' "$OUT"
grep -E "^rev: $(git -C "$REPO" rev-parse HEAD)$" "$OUT"
if grep -F '前回 beta の変更は含めない' "$OUT" || grep -F 'https://example.com' "$OUT"; then
	echo 'beta release note must contain only the current plain-text changelog section' >&2
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

# fake asc: resolve BASE_SHA from TestFlight test-notes rev marker
new_fake_asc() {
	local dir
	dir=$(mktemp -d)
	CLEANUP_DIRS+=("$dir")
	cat >"$dir/asc" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
if [ "$1" = builds ] && [ "$2" = list ]; then
	printf '%s\n' "${FAKE_ASC_BUILDS_JSON:?FAKE_ASC_BUILDS_JSON is required}"
	exit 0
fi
if [ "$1" = builds ] && [ "$2" = test-notes ] && [ "$3" = list ]; then
	build_number=
	shift 3
	while [ $# -gt 0 ]; do
		case "$1" in
		--build-number)
			build_number=$2
			shift 2
			;;
		*) shift ;;
		esac
	done
	var="FAKE_ASC_NOTES_${build_number}"
	notes_json=${!var:-}
	if [ -z "$notes_json" ]; then
		exit 1
	fi
	printf '%s\n' "$notes_json"
	exit 0
fi
printf 'unexpected asc invocation: %s\n' "$*" >&2
exit 1
EOF
	chmod +x "$dir/asc"
	echo "$dir"
}

REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'base' -q
BASE=$(git -C "$REPO" rev-parse HEAD)
git -C "$REPO" commit --allow-empty -m 'feat: ios change (#7)' -q
FAKE_ASC_DIR=$(new_fake_asc)
OUT="$REPO/ios-resolved.txt"
FAKE_ASC_BUILDS_JSON='{"data":[{"attributes":{"version":"200"}}]}' \
	FAKE_ASC_NOTES_200="{\"data\":[{\"attributes\":{\"whatToTest\":\"前回の配信から変更はありません。\\n\\nrev: ${BASE}\"}}]}" \
	ASC_BIN="$FAKE_ASC_DIR/asc" \
	run_gen "$REPO" ios "$OUT"

grep -F '・#7 feat: ios change' "$OUT"
grep -E "^rev: $(git -C "$REPO" rev-parse HEAD)$" "$OUT"

# fake asc: skip rev that does not exist locally, use older build
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'base' -q
BASE=$(git -C "$REPO" rev-parse HEAD)
git -C "$REPO" commit --allow-empty -m 'fix: follow-up (#8)' -q
FAKE_ASC_DIR=$(new_fake_asc)
OUT="$REPO/ios-skip-missing.txt"
FAKE_ASC_BUILDS_JSON='{"data":[{"attributes":{"version":"201"}},{"attributes":{"version":"200"}}]}' \
	FAKE_ASC_NOTES_201='{"data":[{"attributes":{"whatToTest":"rev: 0000000000000000000000000000000000000000"}}]}' \
	FAKE_ASC_NOTES_200="{\"data\":[{\"attributes\":{\"whatToTest\":\"rev: ${BASE}\"}}]}" \
	ASC_BIN="$FAKE_ASC_DIR/asc" \
	run_gen "$REPO" ios "$OUT"

grep -F '・#8 fix: follow-up' "$OUT"
grep -E "^rev: $(git -C "$REPO" rev-parse HEAD)$" "$OUT"

# BASE_SHA unset + empty ASC builds -> cannot resolve previous build
REPO=$(new_repo)
git -C "$REPO" commit --allow-empty -m 'only' -q
FAKE_ASC_DIR=$(new_fake_asc)
OUT="$REPO/unresolved.txt"
FAKE_ASC_BUILDS_JSON='{"data":[]}' \
	ASC_BIN="$FAKE_ASC_DIR/asc" \
	run_gen "$REPO" ios "$OUT"

grep -F '前回の配信ビルドを特定できなかった' "$OUT"
grep -E "^rev: $(git -C "$REPO" rev-parse HEAD)$" "$OUT"
if grep -F '・#' "$OUT" || grep -E 'その他 [0-9]+ 件' "$OUT"; then
	echo 'unresolved BASE_SHA must not list changes' >&2
	exit 1
fi

echo "generate release note tests passed"
