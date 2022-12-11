#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* PUBLISH"
echo "*"

mkdir -p /mnt/publish

# Copy assets/files
echo -n "Copying assets... "
#rsync --version
#--iconv=UTF-8,UTF-8-mac \
rsync \
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

# Optimize
echo "Optimizing CSS... "
mkdir -p /mnt/publish/assets/css
:>/mnt/publish/assets/fontawesome/css/site.css
for css in /fontawesome/css/all.min.css /fontawesome/css/v4-shims.min.css
do
    echo "${css}"
    cat "/mnt/publish/assets${css}" >>/mnt/publish/assets/fontawesome/css/site.css
    echo "" >>/mnt/publish/assets/css/site.css
done
echo "done"
:>/mnt/publish/assets/css/site.css
cat "/mnt/publish/asciidoctor.css" >>/mnt/publish/assets/css/site.css
echo "" >>/mnt/publish/assets/css/site.css
cat "/mnt/publish/assets/css/blog.css" >>/mnt/publish/assets/css/site.css

exit 0
