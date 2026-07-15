#!/bin/sh
set -eu

apk_path=${1:?Usage: verify_maplibre_android_classes.sh <apk-path>}
class_name='org.maplibre.android.style.expressions.Expression$Converter'

if ! command -v apkanalyzer >/dev/null 2>&1; then
  echo 'apkanalyzer is required' >&2
  exit 2
fi

if apkanalyzer dex packages --defined-only "$apk_path" | grep -Fq "$class_name"; then
  echo "Verified $class_name in $apk_path"
  exit 0
fi

echo "Missing $class_name in $apk_path" >&2
exit 1
