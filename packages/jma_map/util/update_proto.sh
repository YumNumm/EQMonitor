#!/usr/bin/env bash

# ensure protoc-gen-dart is in path
if ! type -P protoc-gen-dart &>/dev/null; then
    echo "protoc-gen-dart not found in PATH"
    echo "Please install it by running 'dart pub global activate protoc_plugin'"
    exit 1
fi

if ! type -P protoc &>/dev/null; then
    echo "protoc not found in PATH"
    echo "Please install it by running 'brew install protobuf'"
    exit 1
fi

mkdir -p lib/gen

protoc \
    --dart_out="grpc:lib/gen" \
    -I="./proto" \
    $(find . -iname "*.proto")
