#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* PUBLISH"
echo "*"

mkdir -p /mnt/publish

# Copy assets/files
echo -n "Copying assets... "
#pushd /mnt/content/assets >/dev/null
#find . \
#    -type f |
#    cpio -pd /mnt/publish/assets
#popd >/dev/null
rsync \
    -vhP --stats \
    -rl \
    --delete \
    /mnt/content/assets/ /mnt/publish/assets
echo "done"

# Code highlighter
echo -n "Copying code highlighter... "
if [[ ! -d /mnt/publish/assets/highlight ]]
then
    mkdir -p /mnt/publish/assets/highlight
    tar -C /mnt/publish/assets/highlight -xf /mnt/docker/builder/highlight.tar
fi
echo "done"

exit 0
