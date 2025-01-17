#!/bin/bash

function usage() {
  echo "Usage: $0 <package-name>"
  exit 1
}

function success() {
  tput setab 4 && tput setaf 7 && echo "[✅️] $1"
  tput sgr0
}

function info() {
  echo "[ℹ️  INFO] $1"
  tput sgr0
}

function error() {
  tput setab 1 && tput setaf 7 && echo "[❌] $1"
  tput sgr0
}

# Input parameters
PACKAGE_NAME=$1

if [ -z "$PACKAGE_NAME" ]; then
  echo "Usage: $0 <package-name>"
  exit 1
fi

# check if `packages` directory exists
if [ ! -d "packages" ]; then
  error "Please run this script from the root of the project"
  exit 1
fi

# Check if package which is being created already exists
if [ -d "packages/$PACKAGE_NAME" ]; then
  error "Package $PACKAGE_NAME already exists"
  exit 1
fi

info "Creating package as $PACKAGE_NAME ..."

# Copy the template package to the new package
cp -r packages/_base packages/$PACKAGE_NAME

# Replace _base with package_name in the new package's files
find packages/$PACKAGE_NAME -type f -exec sed -i '' "s/_base/$PACKAGE_NAME/g" {} +

# Replace file name
for f in $(find packages/$PACKAGE_NAME -type f -name "*_base*"); do
  mv "$f" "${f/_base/$PACKAGE_NAME}"
done

info "Executing bootstrap script for $PACKAGE_NAME ... Please wait..."

melos bootstrap &>/dev/null

echo "\n\n"
success "Package $PACKAGE_NAME created successfully! "
