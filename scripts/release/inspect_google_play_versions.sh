#!/usr/bin/env bash
set -euo pipefail

: "${GOOGLE_PLAY_ACCESS_TOKEN:?GOOGLE_PLAY_ACCESS_TOKEN is required}"
: "${PACKAGE_NAME:?PACKAGE_NAME is required}"

edits_url="https://androidpublisher.googleapis.com/androidpublisher/v3/applications/$PACKAGE_NAME/edits"
authorization="Authorization: Bearer $GOOGLE_PLAY_ACCESS_TOKEN"
edit_id=
cleanup() {
  if [[ -n "$edit_id" ]]; then
    curl --fail --silent --show-error --request DELETE \
      --header "$authorization" "$edits_url/$edit_id" > /dev/null
  fi
}
trap cleanup EXIT
api() {
  curl --fail-with-body --silent --show-error \
    --header "$authorization" --header 'Content-Type: application/json' "$@"
}

# Google Play requires an edit even for reads. Never commit this inspection edit.
edit_id=$(api --request POST --data '{}' "$edits_url" | jq -er .id)
api "$edits_url/$edit_id/tracks" | jq '{tracks: [.tracks[] | {
  track, releases: [.releases[]? | {name, versionCodes, status}]
}]}'
api "$edits_url/$edit_id/bundles" | jq '{
  versionCodes: [(.bundles // [])[] | .versionCode] | sort,
  maxVersionCode: ([(.bundles // [])[] | .versionCode] | max)
}'
for track in internal beta production; do
  api "https://androidpublisher.googleapis.com/androidpublisher/v3/applications/$PACKAGE_NAME/tracks/$track/releases" \
    | jq --arg track "$track" '{track: $track, releases: [.releases[]? | {
      releaseName, activeArtifacts, releaseLifecycleState
    }]}'
done
