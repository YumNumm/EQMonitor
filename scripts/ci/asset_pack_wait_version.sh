#!/usr/bin/env bash
# backgroundAssetVersion が既知の終端 state に到達するまでポーリングする。
# 終端 state 名は Apple のドキュメントで確認できていないため、未知の state は
# 成功扱いせず、期限切れ時は失敗として扱う。
set -euo pipefail

version_id="$1"
deadline=$(( $(date +%s) + 20 * 60 ))

while :; do
  state=$(asc background-assets versions view --version-id "$version_id" --output json \
    | jq -r '.data.attributes.state // .data.attributes.assetPackState // "UNKNOWN"')
  echo "backgroundAssetVersion ${version_id} state=${state}" >&2
  case "$state" in
    COMPLETE|READY_FOR_TESTING|PROCESSING_COMPLETE)
      exit 0 ;;
    FAILED_PROCESSING|REJECTED|INVALID)
      echo "::error::backgroundAssetVersion ${version_id} failed: state=${state}" >&2
      exit 1 ;;
  esac
  if [ "$(date +%s)" -ge "$deadline" ]; then
    echo "::error::timed out waiting for backgroundAssetVersion ${version_id} (last state=${state})" >&2
    exit 1
  fi
  sleep 30
done
