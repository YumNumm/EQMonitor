#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_PLAY_ACCESS_TOKEN:?GOOGLE_PLAY_ACCESS_TOKEN is required}"
: "${PACKAGE_NAME:?PACKAGE_NAME is required}"
: "${TRACK_NAME:?TRACK_NAME is required}"
: "${BUILD_NUMBER:?BUILD_NUMBER is required}"
: "${RELEASE_VERSION:?RELEASE_VERSION is required}"
[[ "$BUILD_NUMBER" =~ ^[0-9]+$ ]]
case "$TRACK_NAME" in internal|beta|external) ;; *) exit 1 ;; esac

api_root=https://androidpublisher.googleapis.com/androidpublisher/v3
edits_url="$api_root/applications/$PACKAGE_NAME/edits"
authorization="Authorization: Bearer $GOOGLE_PLAY_ACCESS_TOKEN"
edit_id=
cleanup() {
  if [[ -n "$edit_id" ]]; then
    curl --fail --silent --show-error --request DELETE \
      --header "$authorization" "$edits_url/$edit_id" > /dev/null || true
  fi
}
trap cleanup EXIT
api() {
  curl --fail-with-body --silent --show-error \
    --header "$authorization" --header 'Content-Type: application/json' "$@"
}

edit_id=$(api --request POST --data '{}' "$edits_url" | jq -er .id)
api "$edits_url/$edit_id/tracks" > tracks-before.json
jq -e --arg track "$TRACK_NAME" 'any(.tracks[]; .track == $track)' tracks-before.json > /dev/null
jq -e --arg track "$TRACK_NAME" --argjson number "$BUILD_NUMBER" \
  'all(.tracks[] | select(.track == $track) | .releases[]?.versionCodes[]?; tonumber <= $number)' \
  tracks-before.json > /dev/null
api "$edits_url/$edit_id/bundles" > bundles-before.json
if ! jq -e --argjson number "$BUILD_NUMBER" \
  'any((.bundles // [])[]; .versionCode == $number)' bundles-before.json > /dev/null; then
  curl --fail-with-body --silent --show-error --request POST \
    --header "$authorization" --header 'Content-Type: application/octet-stream' \
    --data-binary @app.aab \
    "https://androidpublisher.googleapis.com/upload/androidpublisher/v3/applications/$PACKAGE_NAME/edits/$edit_id/bundles?uploadType=media" \
    > uploaded-bundle.json
  jq -e --argjson number "$BUILD_NUMBER" '.versionCode == $number' uploaded-bundle.json > /dev/null
  cp uploaded-bundle.json source-bundle.json
else
  jq --argjson number "$BUILD_NUMBER" '.bundles[] | select(.versionCode == $number)' \
    bundles-before.json > source-bundle.json
fi
bundle_sha256=$(sha256sum app.aab | cut -d ' ' -f 1)
jq -e --arg sha256 "$bundle_sha256" '.sha256 == $sha256' source-bundle.json > /dev/null

jq -n --arg track "$TRACK_NAME" --arg version "$RELEASE_VERSION" \
  --arg number "$BUILD_NUMBER" --slurpfile notes release-notes.json \
  '{track: $track, releases: [{name: $version, versionCodes: [$number], status: "completed", releaseNotes: $notes[0]}]}' \
  > target-track.json
api --request PUT --data-binary @target-track.json "$edits_url/$edit_id/tracks/$TRACK_NAME" > updated-track.json
api --request POST "$edits_url/$edit_id:validate" > /dev/null
curl --fail-with-body --silent --show-error --retry 3 --retry-delay 2 \
  --request POST --header "$authorization" "$edits_url/$edit_id:commit" > committed-edit.json
edit_id=

# Read back committed store state under the shared Google Play edit queue.
edit_id=$(api --request POST --data '{}' "$edits_url" | jq -er .id)
api "$edits_url/$edit_id/tracks" > tracks-after.json
jq -e --arg track "$TRACK_NAME" --arg number "$BUILD_NUMBER" \
  'any(.tracks[]; .track == $track and any(.releases[]; .status == "completed" and any(.versionCodes[]; . == $number)))' \
  tracks-after.json > /dev/null
diff -u <(jq -S '[.tracks[] | select(.track == "production")]' tracks-before.json) \
  <(jq -S '[.tracks[] | select(.track == "production")]' tracks-after.json)
jq --arg track "$TRACK_NAME" '.tracks[] | select(.track == $track or .track == "production")' tracks-after.json
sha256sum app.aab
printf 'Published %s (%s) to %s; production unchanged.\n' "$RELEASE_VERSION" "$BUILD_NUMBER" "$TRACK_NAME"
