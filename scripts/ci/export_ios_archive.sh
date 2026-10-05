#!/usr/bin/env bash

set -euo pipefail

log_path="$(mktemp "${RUNNER_TEMP:-${TMPDIR:-/tmp}}/eqmonitor-ios-export.XXXXXX")"
trap 'rm -f "$log_path"' EXIT

for attempt in 1 2 3; do
  echo "Exporting iOS archive (attempt $attempt/3)"
  if xcodebuild -exportArchive "$@" 2>&1 | tee "$log_path" | xcbeautify --renderer github-actions; then
    exit 0
  else
    pipeline_status=("${PIPESTATUS[@]}")
  fi

  echo "::group::xcodebuild export failure (attempt $attempt)"
  cat "$log_path"
  echo "::endgroup::"

  # A logging failure must not cause another export of a successfully signed IPA.
  for status in "${pipeline_status[@]:1}"; do
    if [[ "$status" -ne 0 ]]; then
      exit "$status"
    fi
  done

  # A provisioning connection failure can also report missing extension profiles.
  # Only retry explicit connection errors, not signing/configuration errors on their own.
  if [[ "$attempt" -eq 3 ]] ||
    ! grep -Fq \
      -e 'error: exportArchive The request timed out.' \
      -e 'error: exportArchive The Internet connection appears to be offline.' "$log_path"; then
    exit "${pipeline_status[0]}"
  fi

  delay_seconds=$((attempt * 20))
  echo "::warning::Apple provisioning connection failed; retrying export in ${delay_seconds}s."
  sleep "$delay_seconds"
done
