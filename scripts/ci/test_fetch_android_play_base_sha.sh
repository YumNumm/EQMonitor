#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
FETCH="$ROOT_DIR/scripts/ci/fetch_android_play_base_sha.sh"
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

KNOWN_SHA=abcdef0123456789abcdef0123456789abcdef01

mkdir -p "$TEST_DIR/bin"

cat >"$TEST_DIR/bin/curl" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail
url=${!#}
printf '%s\n' "$*" >> "$FAKE_CURL_LOG"
case "$url" in
  */edits)
    printf '{"id":"edit-1"}\n'
    ;;
  */edits/edit-1/tracks/internal)
    printf '%s\n' "$FAKE_TRACK_JSON"
    ;;
  */edits/edit-1)
    printf '{}\n'
    ;;
  *)
    echo "unexpected URL: $url" >&2
    exit 1
    ;;
esac
EOF
chmod +x "$TEST_DIR/bin/curl"

run_fetch() {
	PATH="$TEST_DIR/bin:$PATH" \
		FAKE_CURL_LOG="$1" \
		FAKE_TRACK_JSON="$2" \
		GOOGLE_PLAY_ACCESS_TOKEN=test-token \
		PACKAGE_NAME=net.yumnumm.eqmonitor \
		TRACK_NAME=internal \
		"$FETCH"
}

# Case 1: ja-JP notes with rev
json_with_rev=$(jq -nc \
	--arg sha "$KNOWN_SHA" \
	'{track:"internal",releases:[{status:"completed",releaseNotes:[{language:"ja-JP",text:("変更点\n\nrev: "+$sha+"\n")}]}]}')
out=$(run_fetch "$TEST_DIR/with-rev.log" "$json_with_rev")
[[ "$out" == "$KNOWN_SHA" ]] || {
	echo "expected $KNOWN_SHA got [$out]" >&2
	exit 1
}
grep -F -- '--request DELETE' "$TEST_DIR/with-rev.log" >/dev/null

# Case 2: skip release without rev, take later? API order — first text with rev wins
json_skip=$(jq -nc \
	--arg sha "$KNOWN_SHA" \
	'{track:"internal",releases:[
    {status:"completed",releaseNotes:[{language:"ja-JP",text:"no rev here"}]},
    {status:"completed",releaseNotes:[{language:"en-US",text:("old\nrev: "+$sha)}]}
  ]}')
out=$(run_fetch "$TEST_DIR/skip.log" "$json_skip")
[[ "$out" == "$KNOWN_SHA" ]] || {
	echo "expected fallback sha got [$out]" >&2
	exit 1
}

# Case 3: no rev → empty
json_empty='{"track":"internal","releases":[{"status":"completed","releaseNotes":[{"language":"ja-JP","text":"hello"}]}]}'
out=$(run_fetch "$TEST_DIR/empty.log" "$json_empty")
[[ -z "$out" ]] || {
	echo "expected empty got [$out]" >&2
	exit 1
}

echo "fetch android play base sha tests passed"
