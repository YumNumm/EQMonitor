#!/usr/bin/env bash

# ensure protoc-gen-dart is in path
if ! type -P protoc-gen-dart &>/dev/null; then
    echo "protoc-gen-dart not found in PATH"
    echo "PLEASE EXECUTE: dart pub global activate protoc_plugin"
    exit 1
fi

# If lib/* exists, remove it
if [ -d "lib" ]; then
    rm -rf lib/*
fi

protoc \
    --dart_out="grpc:lib" \
    -I="./proto" \
    $(find . -iname "*.proto")
