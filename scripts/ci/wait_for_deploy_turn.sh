#!/usr/bin/env bash
set -euo pipefail

: "${GH_REPO:?GH_REPO is required}"
: "${RUN_NUMBER:?RUN_NUMBER is required}"
WORKFLOW_FILE="${WORKFLOW_FILE:-deploy-app.yaml}"
MAX_POLL_INTERVAL_SECONDS="${MAX_POLL_INTERVAL_SECONDS:-300}"
ERROR_RETRY_SECONDS="${ERROR_RETRY_SECONDS:-60}"

if ! [[ "$RUN_NUMBER" =~ ^[0-9]+$ ]]; then
  echo "RUN_NUMBER must be a number: $RUN_NUMBER" >&2
  exit 1
fi

older_active_runs() {
  local response
  response="$(gh api "repos/$GH_REPO/actions/workflows/$WORKFLOW_FILE/runs?per_page=100")" || return 1
  jq -r --argjson run_number "$RUN_NUMBER" '
    if (.workflow_runs | type) == "array" and (.workflow_runs | length) > 0 then
      [.workflow_runs[]
        | select(.status != "completed" and .run_number < $run_number)
        | .run_number]
      | sort | map(tostring) | join(" ")
    else
      error("unexpected workflow runs response")
    end
  ' <<<"$response"
}

while true; do
  # 取得や解析の失敗を「先行 run なし」と扱うと配信順が崩れるため、成功するまで待つ。
  if ! older="$(older_active_runs)"; then
    echo "::warning::Failed to list $WORKFLOW_FILE runs; retrying in ${ERROR_RETRY_SECONDS}s" >&2
    sleep "$ERROR_RETRY_SECONDS"
    continue
  fi
  if [ -z "$older" ]; then
    echo "No older $WORKFLOW_FILE run is active. Run #$RUN_NUMBER may deploy."
    exit 0
  fi

  read -r -a older_runs <<<"$older"
  # GITHUB_TOKEN の API 上限を配信 job と共有するため、待ち行列が長いほど間隔を空ける。
  interval=$((30 + 30 * ${#older_runs[@]}))
  if [ "$interval" -gt "$MAX_POLL_INTERVAL_SECONDS" ]; then
    interval=$MAX_POLL_INTERVAL_SECONDS
  fi
  echo "Run #$RUN_NUMBER waits for older runs: $older (next check in ${interval}s)"
  sleep "$interval"
done
