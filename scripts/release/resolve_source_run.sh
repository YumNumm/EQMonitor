#!/usr/bin/env bash
set -euo pipefail

: "${GH_REPO:?GH_REPO is required}"
: "${SOURCE_RUN_ID:?SOURCE_RUN_ID is required}"
[[ "$SOURCE_RUN_ID" =~ ^[0-9]+$ ]]

source_run=$(gh api "repos/$GH_REPO/actions/runs/$SOURCE_RUN_ID")
workflow_id=$(gh api "repos/$GH_REPO/actions/workflows/deploy-app.yaml" --jq .id)
jq -e --argjson workflow "$workflow_id" \
  '.workflow_id == $workflow and .status == "completed"' <<< "$source_run" > /dev/null
jobs=$(gh api --paginate "repos/$GH_REPO/actions/runs/$SOURCE_RUN_ID/jobs?per_page=100" | jq -s '[.[].jobs[]]')
artifacts=$(gh api --paginate "repos/$GH_REPO/actions/runs/$SOURCE_RUN_ID/artifacts?per_page=100" | jq -s '[.[].artifacts[]]')
for platform in ios android; do
  input_name="INPUT_${platform^^}"
  if [[ "${!input_name}" != "true" ]]; then
    continue
  fi
  if [[ "$platform" == ios ]]; then
    job_name='Build iOS'
    binary_name='EQMonitor-ios.ipa'
  else
    job_name='Build Android'
    binary_name='EQMonitor-android.aab'
  fi
  jq -e --arg name "$job_name" 'any(.[]; .name == $name and .conclusion == "success")' <<< "$jobs" > /dev/null
  for name in "$binary_name" "EQMonitor-release-notes-$platform"; do
    jq -e --arg name "$name" 'any(.[]; .name == $name and .expired == false)' <<< "$artifacts" > /dev/null
  done
done
head_sha=$(jq -er .head_sha <<< "$source_run")
pubspec=$(gh api "repos/$GH_REPO/contents/app/pubspec.yaml?ref=$head_sha" --jq .content | base64 -d)
version=$(sed -n 's/^version: *\([^ #]*\).*/\1/p' <<< "$pubspec")
version=${version%%-*}
version=${version%%+*}
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]
printf 'build-number=%s\nversion=%s\nhead-sha=%s\n' \
  "$(jq -er .run_number <<< "$source_run")" "$version" "$head_sha"
