#!/usr/bin/env bash
#
# 配布ノート本文を生成する。末尾に rev: <HEAD SHA> を必ず付与する。
#
# 環境変数:
#   PLATFORM          ios | android (必須)
#   OUTPUT_PATH       出力先 (必須)
#   BASE_SHA          差分の起点 (任意。指定時は ASC / Play へ問い合わせない)
#   MAX_LENGTH        本文の文字数上限 (既定 4000)
#   REPO_ROOT         git リポジトリのルート (既定: このスクリプトから 2 階層上)
#   ASC_APP_ID        App Store Connect アプリ ID (既定 6447546703、ios のみ)
#   TESTFLIGHT_LOCALE TestFlight test-notes の locale (既定 ja、ios のみ)
#   LOOKBACK          遡るビルド数 (既定 5、ios のみ)
#   ASC_BIN           asc CLI のパス (任意)
#
set -euo pipefail

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
REPO_ROOT="${REPO_ROOT:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
OUTPUT_PATH="${OUTPUT_PATH:-}"
PLATFORM="${PLATFORM:-}"
MAX_LENGTH="${MAX_LENGTH:-4000}"
BASE_SHA="${BASE_SHA:-}"
ASC_APP_ID="${ASC_APP_ID:-6447546703}"
TESTFLIGHT_LOCALE="${TESTFLIGHT_LOCALE:-ja}"
LOOKBACK="${LOOKBACK:-5}"
ASC_BIN="${ASC_BIN:-}"

log() { printf '\033[1;34m==>\033[0m %s\n' "$*" >&2; }
die() {
	printf '\033[1;31mエラー:\033[0m %s\n' "$*" >&2
	exit 1
}

resolve_gh_repo() {
	local gh_repo="${GITHUB_REPOSITORY:-}"
	if [ -n "$gh_repo" ]; then
		echo "$gh_repo"
		return
	fi
	local url
	url="$(git -C "$REPO_ROOT" remote get-url origin 2>/dev/null || true)"
	[ -n "$url" ] || return 0
	url="${url%.git}"
	case "$url" in
	*:*/*) echo "${url##*:}" ;;
	*/*/*) echo "$url" | sed -n 's#.*/\([^/]*/[^/]*\)$#\1#p' ;;
	esac
}

fetch_pr_title() {
	local number="$1"
	local gh_repo="${GITHUB_REPOSITORY:-}"
	[ -n "$gh_repo" ] || gh_repo="$(resolve_gh_repo)"
	[ -n "$gh_repo" ] || return 0
	command -v gh >/dev/null 2>&1 || return 0
	gh pr view "$number" --repo "$gh_repo" --json title -q .title 2>/dev/null || true
}

resolve_asc() {
	if [ -n "$ASC_BIN" ]; then
		echo "$ASC_BIN"
		return
	fi
	if command -v mise >/dev/null 2>&1; then
		local from_mise
		if from_mise="$(mise which asc 2>/dev/null)" && [ -x "$from_mise" ]; then
			echo "$from_mise"
			return
		fi
	fi
	if command -v asc >/dev/null 2>&1; then
		command -v asc
		return
	fi
	die "asc CLI が見つかりません。mise install を実行するか ASC_BIN を指定してください。"
}

resolve_base_sha_for_ios() {
	local asc app_id locale lookback builds_json build_numbers
	asc="$(resolve_asc)"
	app_id="$ASC_APP_ID"
	locale="$TESTFLIGHT_LOCALE"
	lookback="$LOOKBACK"

	if ! builds_json="$(
		"$asc" builds list \
			--app "$app_id" \
			--platform IOS \
			--sort -uploadedDate \
			--limit "$lookback" \
			--output json
	)"; then
		die "App Store Connect のビルド一覧を取得できませんでした。"
	fi

	build_numbers="$(printf '%s' "$builds_json" | grep -Eo '"version":"[0-9]+"' | cut -d'"' -f4 || true)"

	for build_number in $build_numbers; do
		local notes_json candidate
		if ! notes_json="$(
			"$asc" builds test-notes list \
				--app "$app_id" \
				--build-number "$build_number" \
				--platform IOS \
				--locale "$locale" \
				--output json 2>/dev/null
		)"; then
			continue
		fi
		candidate="$(printf '%s' "$notes_json" | grep -Eo 'rev: [0-9a-f]{40}' | tail -1 | cut -d' ' -f2 || true)"
		[ -n "$candidate" ] || continue
		if ! git -C "$REPO_ROOT" cat-file -e "$candidate^{commit}" 2>/dev/null; then
			log "ビルド $build_number の rev ($candidate) は手元に存在しないため読み飛ばします"
			continue
		fi
		log "ビルド $build_number を前回の配信とみなします (rev: $candidate)"
		echo "$candidate"
		return 0
	done

	echo ""
}

resolve_base_sha_for_platform() {
	local platform="$1"
	case "$platform" in
	ios) resolve_base_sha_for_ios ;;
	android) echo "" ;;
	*) die "未対応の PLATFORM です: $platform" ;;
	esac
}

[ -n "$PLATFORM" ] || die "PLATFORM を指定してください (ios | android)"
case "$PLATFORM" in
ios | android) ;;
*) die "PLATFORM は ios または android を指定してください: $PLATFORM" ;;
esac

[ -n "$OUTPUT_PATH" ] || die "OUTPUT_PATH を指定してください"

HEAD_SHA="$(git -C "$REPO_ROOT" rev-parse HEAD)"

if [ -n "$BASE_SHA" ]; then
	git -C "$REPO_ROOT" cat-file -e "$BASE_SHA^{commit}" 2>/dev/null ||
		die "指定された BASE_SHA が手元に存在しません: $BASE_SHA"
	BASE_SHA="$(git -C "$REPO_ROOT" rev-parse "$BASE_SHA")"
	log "BASE_SHA が指定されたため外部サービスへの問い合わせを省略します (rev: $BASE_SHA)"
else
	log "前回配信したビルドを探します (platform: $PLATFORM)"
	BASE_SHA="$(resolve_base_sha_for_platform "$PLATFORM")"
	[ -n "$BASE_SHA" ] || log "rev マーカーを持つビルドが見つかりませんでした"
fi

PR_LINES=""
PR_COUNT=0
OTHER_COUNT=0

BUDGET=$((MAX_LENGTH - 120))
USED=0

if [ -n "$BASE_SHA" ]; then
	merge_re='^Merge pull request #([0-9]+) from '
	squash_re='^(.+) \(#([0-9]+)\)$'

	while IFS= read -r entry; do
		[ -n "$entry" ] || continue
		sha="${entry%% *}"
		subject="${entry#* }"

		if [[ "$subject" =~ $merge_re ]]; then
			pr_number="${BASH_REMATCH[1]}"
			pr_title="$(git -C "$REPO_ROOT" log -1 --format=%b "$sha" | sed -n '/[^[:space:]]/{p;q;}')"
			[ -n "$pr_title" ] || pr_title="$(fetch_pr_title "$pr_number")"
			[ -n "$pr_title" ] || pr_title="${subject#*from }"
		elif [[ "$subject" =~ $squash_re ]]; then
			pr_title="${BASH_REMATCH[1]}"
			pr_number="${BASH_REMATCH[2]}"
		else
			OTHER_COUNT=$((OTHER_COUNT + 1))
			continue
		fi

		line="・#${pr_number} ${pr_title}"
		if [ $((USED + ${#line} + 1)) -gt "$BUDGET" ]; then
			OTHER_COUNT=$((OTHER_COUNT + 1))
			continue
		fi
		PR_LINES="${PR_LINES}${line}"$'\n'
		USED=$((USED + ${#line} + 1))
		PR_COUNT=$((PR_COUNT + 1))
	done < <(git -C "$REPO_ROOT" log --first-parent --format='%H %s' "$BASE_SHA..$HEAD_SHA")
fi

if [ -z "$BASE_SHA" ]; then
	BODY="前回の配信ビルドを特定できなかったため、変更点の一覧は省略しています。"
elif [ "$PR_COUNT" -eq 0 ] && [ "$OTHER_COUNT" -eq 0 ]; then
	BODY="前回の配信から変更はありません。"
else
	BODY=""
	if [ "$PR_COUNT" -gt 0 ]; then
		BODY="変更点"$'\n'"${PR_LINES}"
	fi
	if [ "$OTHER_COUNT" -gt 0 ]; then
		[ -z "$BODY" ] || BODY="${BODY}"$'\n'
		BODY="${BODY}その他 ${OTHER_COUNT} 件の変更を含みます。"$'\n'
	fi
	BODY="${BODY%$'\n'}"
fi

mkdir -p "$(dirname "$OUTPUT_PATH")"
printf '%s\n\nrev: %s\n' "$BODY" "$HEAD_SHA" >"$OUTPUT_PATH"

log "変更履歴を書き出しました: $OUTPUT_PATH (PR $PR_COUNT 件 / その他 $OTHER_COUNT 件)"
cat "$OUTPUT_PATH" >&2
