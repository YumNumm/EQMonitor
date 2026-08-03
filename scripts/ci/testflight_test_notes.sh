#!/usr/bin/env bash
# TestFlight の What to Test を直近タグ以降のコミット件名から生成する。
# 旧 scripts/testflight/distribute-external.ts の buildWhatsNewFromGit と同挙動:
# 空なら "- (no changes)"、4000 文字(Unicode 文字数)超過時は末尾を "..." にする。
set -euo pipefail

last_tag=$(git describe --tags --abbrev=0)
log=$(git log "${last_tag}..HEAD" --pretty=format:'- %s')
if [ -z "$log" ]; then
  log='- (no changes)'
fi

# ASC の whatsNew 上限は 4000 文字。コミット件名は日本語を含むため
# バイト数で切る head -c は使えない。
printf '%s' "$log" | python3 -c '
import sys

text = sys.stdin.read()
MAX_LEN = 4000
if len(text) > MAX_LEN:
    text = text[: MAX_LEN - 3] + "..."
print(text, end="")
'
