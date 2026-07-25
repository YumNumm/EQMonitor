#!/usr/bin/env bash
set -euo pipefail

url=${!#}
printf '%s\n' "$*" >> "$FAKE_CURL_LOG"

case "$url" in
  */edits)
    printf '{"id":"edit-1"}\n'
    ;;
  */edits/edit-1/tracks)
    if [[ "$*" == *'--request GET'* ]]; then
      if [[ "$FAKE_TRACK_EXISTS" == "true" ]]; then
        printf '{"tracks":[{"track":"external"}]}\n'
      else
        printf '{"tracks":[]}\n'
      fi
    else
      printf '{"track":"external"}\n'
    fi
    ;;
  */edits/edit-1:commit)
    printf '{"id":"edit-1","expiryTimeSeconds":"0"}\n'
    ;;
  */edits/edit-1)
    printf '{}\n'
    ;;
  *)
    echo "unexpected URL: $url" >&2
    exit 1
    ;;
esac
