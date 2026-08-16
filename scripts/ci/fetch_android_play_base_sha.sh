#!/usr/bin/env bash
# Google Play 対象トラックの前回 release notes から rev: <40桁SHA> を取り出す。
# 見つからなくても exit 0（空行を stdout に出す）。
set -euo pipefail

: "${GOOGLE_PLAY_ACCESS_TOKEN:?GOOGLE_PLAY_ACCESS_TOKEN is required}"
: "${PACKAGE_NAME:?PACKAGE_NAME is required}"
: "${TRACK_NAME:?TRACK_NAME is required}"

api_root=https://androidpublisher.googleapis.com/androidpublisher/v3
edits_url="$api_root/applications/$PACKAGE_NAME/edits"
authorization="Authorization: Bearer $GOOGLE_PLAY_ACCESS_TOKEN"
edit_id=
edit_open=false

cleanup_edit() {
	if [[ "$edit_open" == "true" ]]; then
		curl \
			--fail-with-body \
			--silent \
			--show-error \
			--request DELETE \
			--header "$authorization" \
			"$edits_url/$edit_id" \
			>/dev/null || true
	fi
}
trap cleanup_edit EXIT

edit_response=$(curl \
	--fail-with-body \
	--silent \
	--show-error \
	--request POST \
	--header "$authorization" \
	--header 'Content-Type: application/json' \
	--data '{}' \
	"$edits_url")
edit_id=$(jq -er '.id' <<<"$edit_response")
edit_open=true

track_response=""
if ! track_response=$(curl \
	--fail-with-body \
	--silent \
	--show-error \
	--request GET \
	--header "$authorization" \
	"$edits_url/$edit_id/tracks/$TRACK_NAME"); then
	cleanup_edit
	edit_open=false
	printf '\n'
	exit 0
fi

cleanup_edit
edit_open=false

sha=$(
	jq -r '
    def texts:
      [.releases[]? | .releaseNotes[]? | .text // empty];
    def ja_texts:
      [.releases[]? | .releaseNotes[]? | select(.language == "ja-JP") | .text // empty];
    (ja_texts + texts) | .[]?
  ' <<<"$track_response" |
		grep -Eo 'rev: [0-9a-f]{40}' |
		head -1 |
		cut -d' ' -f2 || true
)

printf '%s\n' "${sha:-}"
