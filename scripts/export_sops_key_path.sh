#!/bin/bash

export SOPS_AGE_KEY_FILE="$PWD/.config/age/age.txt"

# macOS環境の場合、MISE_ENVを設定してmacOS専用ツールを有効化
if [[ "$(uname)" == "Darwin" ]]; then
    export MISE_ENV="macos"
fi
