#!/usr/bin/env bash

set -o nounset
set -o errexit

EXECDIR="$(pushd "$(dirname "$0")" >/dev/null ; pwd ; popd >/dev/null)"
BASEDIR="$(pushd "${EXECDIR}/.." >/dev/null ; pwd ; popd >/dev/null)"

echo "*"
echo "* BUILDING IMAGE 'blog/webserver'"
echo "*"
docker build \
    -t blog/webserver:latest \
    docker/webserver

echo "*"
echo "* RUNNING WEB SERVER"
echo "*"
cp "${BASEDIR}"/docker/webserver/asciiblog-*.nginx "${BASEDIR}/publish"
docker run \
    --rm \
    -v "${BASEDIR}/publish":/usr/share/nginx/html \
    -v "${BASEDIR}/publish":/srv/http/sites/bensmann.com/www \
    -p "8080:8080" \
    blog/webserver:latest

exit 0
