#!/usr/bin/env bash
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
      > /dev/null
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
edit_id=$(jq -er '.id' <<< "$edit_response")
edit_open=true

tracks_response=$(curl \
  --fail-with-body \
  --silent \
  --show-error \
  --request GET \
  --header "$authorization" \
  "$edits_url/$edit_id/tracks")

if jq -e --arg track "$TRACK_NAME" \
  'any((.tracks // [])[]; .track == $track)' \
  > /dev/null <<< "$tracks_response"; then
  cleanup_edit
  edit_open=false
  echo "Google Play track already exists: $TRACK_NAME"
  exit 0
fi

track_config=$(jq -nc \
  --arg track "$TRACK_NAME" \
  '{track: $track, type: "CLOSED_TESTING", formFactor: "DEFAULT"}')
curl \
  --fail-with-body \
  --silent \
  --show-error \
  --request POST \
  --header "$authorization" \
  --header 'Content-Type: application/json' \
  --data "$track_config" \
  "$edits_url/$edit_id/tracks" \
  > /dev/null
curl \
  --fail-with-body \
  --silent \
  --show-error \
  --request POST \
  --header "$authorization" \
  "$edits_url/$edit_id:commit" \
  > /dev/null
edit_open=false

echo "Created Google Play closed testing track: $TRACK_NAME"
