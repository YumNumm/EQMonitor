#!/usr/bin/env bash
set -euo pipefail

: "${EVENT_NAME:?EVENT_NAME is required}"
: "${REF_TYPE:?REF_TYPE is required}"
: "${REF_NAME:?REF_NAME is required}"
: "${COMMITS_JSON:?COMMITS_JSON is required}"
: "${INPUT_IOS:?INPUT_IOS is required}"
: "${INPUT_ANDROID:?INPUT_ANDROID is required}"
: "${INPUT_EXTERNAL:?INPUT_EXTERNAL is required}"
: "${INPUT_IS_BETA_TESTING:?INPUT_IS_BETA_TESTING is required}"

platforms=()
ios_external=false
android_track=internal

if [[ "$EVENT_NAME" == "workflow_dispatch" ]]; then
  if [[ "$INPUT_IOS" == "true" ]]; then
    platforms+=(ios)
  fi
  if [[ "$INPUT_ANDROID" == "true" ]]; then
    platforms+=(android)
  fi
  ios_external=$INPUT_EXTERNAL
elif [[ "$EVENT_NAME" == "push" && "$REF_TYPE" == "tag" && "$REF_NAME" == v*-beta.* ]]; then
  platforms+=(ios android)
  ios_external=true
  android_track=external
elif [[ "$EVENT_NAME" == "push" && "$REF_TYPE" == "branch" && "$REF_NAME" == "develop" ]]; then
  platforms+=(ios android)
  if grep -qF '[external]' <<< "$COMMITS_JSON"; then
    ios_external=true
  fi
else
  echo "Unsupported deployment event/ref: $EVENT_NAME $REF_TYPE $REF_NAME" >&2
  exit 1
fi

for platform in "${platforms[@]}"; do
  echo "deploy-$platform=true"
done
echo "deploy-ios-external=$ios_external"
echo "android-track=$android_track"

is_beta_testing=false
if [[ "$EVENT_NAME" == "push" && "$REF_TYPE" == "tag" && "$REF_NAME" == v*-beta.* ]]; then
  is_beta_testing=true
elif [[ "$EVENT_NAME" == "workflow_dispatch" && "$INPUT_IS_BETA_TESTING" == "true" ]]; then
  is_beta_testing=true
fi
echo "is-beta-testing=$is_beta_testing"
