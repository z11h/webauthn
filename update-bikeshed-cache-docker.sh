#!/bin/bash

# Abort on error
set -e
# Echo commands
set -x

function cleanup() {
  docker rm -v bikeshed-tmp
}

BIKESHED_ROOT=/usr/local/lib/python3.8/site-packages/bikeshed

docker build -t bikeshed docker/bikeshed --no-cache
docker create --name bikeshed-tmp bikeshed
trap cleanup EXIT

rm -r .bikeshed-include
rm -r .spec-data

docker cp bikeshed-tmp:"${BIKESHED_ROOT}"/boilerplate/webauthn .bikeshed-include
docker cp bikeshed-tmp:"${BIKESHED_ROOT}"/spec-data .spec-data

echo "Now be sure to run:"
echo " git add .spec-data/ .bikeshed-include/"
echo ""
