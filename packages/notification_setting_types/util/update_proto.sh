#!/usr/bin/env bash

# ensure protoc-gen-dart is in path
if ! type -P protoc-gen-dart &>/dev/null; then
    echo "protoc-gen-dart not found in PATH"
    exit 1
fi

rm -rf lib/*
protoc \
    --dart_out="grpc:lib" \
    -I="./proto" \
    "$(find . -iname "*.proto")"
