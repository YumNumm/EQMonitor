#!/usr/bin/env bash
# https://github.com/yumemi-inc/flutter-mobile-project-template/blob/main/scripts/fix.sh

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

files=()
while IFS= read -r -d $'\0' file; do
  files+=("$file")
done < <(find_custom_dart_files)

for file in "${files[@]}"; do
  # limit jobs to 5
  if [ "$(jobs -r | wc -l)" -ge 5 ]; then
    wait "$(jobs -r -p | head -1)"
  fi
  dart fix --apply "$file" &
done
wait
