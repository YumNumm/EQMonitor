#!/usr/bin/env bash

set -euo pipefail

log_path="$(mktemp "${RUNNER_TEMP:-${TMPDIR:-/tmp}}/eqmonitor-ios-export.XXXXXX")"
trap 'rm -f "$log_path"' EXIT

print_export_logs() {
  echo "::group::xcodebuild export output (timestamped)"
  cat "$log_path"
  echo "::endgroup::"
  local distribution_logs
  distribution_logs="$(sed -n 's/.*Created bundle at path "\(.*\.xcdistributionlogs\)".*/\1/p' "$log_path" | tail -1)"
  if [[ -z "$distribution_logs" ]]; then
    # Fallback for Xcode versions that do not print the bundle path.
    distribution_logs="$(find "${TMPDIR:-/tmp}" -maxdepth 2 -name '*.xcdistributionlogs' \
      -newer "$log_path" 2>/dev/null | head -1)"
  fi
  if [[ -n "$distribution_logs" && -f "$distribution_logs/IDEDistribution.standard.log" ]]; then
    echo "::group::IDEDistribution.standard.log"
    cat "$distribution_logs/IDEDistribution.standard.log"
    echo "::endgroup::"
  else
    echo "IDEDistribution logs were not found."
  fi
}

for attempt in 1 2 3; do
  echo "Exporting iOS archive (attempt $attempt/3)"
  # Timestamp raw lines so slow export phases can be found; xcbeautify hides them.
  if xcodebuild -exportArchive "$@" 2>&1 |
    perl -MPOSIX=strftime -pe 'BEGIN { $| = 1 } $_ = strftime("%H:%M:%S ", localtime) . $_' |
    tee "$log_path" |
    sed -u 's/^[0-9:]\{8\} //' |
    xcbeautify --renderer github-actions; then
    print_export_logs
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
