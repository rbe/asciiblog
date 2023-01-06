#!/usr/bin/env bash

set -o errexit
set -o nounset

# Cleanup
echo "*"
echo "* CLEANUP"
echo "*"
find /mnt/publish -type d \
    -name .asciidoctor -print0 |
    xargs -r -0 rm -rf
#find /mnt/publish -type f \
#    \( \
#       -name asciidoctor.css \
#    \) \
#    -print0 |
#    xargs -r -0 rm
echo "done"

exit 0
