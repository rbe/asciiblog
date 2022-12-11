#!/usr/bin/env bash

set -o nounset
set -o errexit

EXECDIR="$(pushd "$(dirname "$0")" >/dev/null ; pwd ; popd >/dev/null)"
BASEDIR="$(pushd "${EXECDIR}/.." >/dev/null ; pwd ; popd >/dev/null)"

echo "*"
echo "* BUILDING IMAGE 'blog/builder'"
echo "*"
docker build \
    -t blog/builder:latest \
    docker/builder

echo "*"
echo "* RUNNING BUILDER"
echo "*"
docker run \
    --rm \
    -v "${BASEDIR}":/mnt \
    blog/builder:latest \
    generate-all.sh

exit 0
