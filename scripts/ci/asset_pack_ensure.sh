#!/usr/bin/env bash
# App Store Connect に Managed Background Assets のレコードが存在することを
# 保証し、asc workflow の outputs 用に {"assetId":"..."} を stdout へ出力する。
set -euo pipefail

app_id="$1"
asset_pack_id="$2"

id=$(asc background-assets list --app "$app_id" --paginate --output json \
  | jq -r --arg pack "$asset_pack_id" \
      '[.data[]? | select(.attributes.assetPackIdentifier == $pack)][0].id // empty')
if [ -z "$id" ]; then
  id=$(asc background-assets create --app "$app_id" \
        --asset-pack-identifier "$asset_pack_id" --output json \
    | jq -r '.data.id // empty')
  echo "created background asset ${id}" >&2
else
  echo "found background asset ${id}" >&2
fi

if [ -z "$id" ]; then
  echo "::error::background asset create returned no id" >&2
  exit 1
fi

printf '{"assetId":"%s"}' "$id"
