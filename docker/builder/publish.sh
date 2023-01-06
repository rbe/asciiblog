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

# CSS
echo -n "Optimizing FontAwesome CSS... "
mkdir -p /mnt/publish/assets/css
:>/mnt/publish/assets/fontawesome/css/site.css
for css in /fontawesome/css/fontawesome.min.css /fontawesome/css/solid.min.css /fontawesome/css/brands.min.css /fontawesome/css/v4-shims.min.css
do
    echo -n "${css} "
    {
        cat "/mnt/publish/assets${css}";
        echo ""
    } >>/mnt/publish/assets/fontawesome/css/site.css
done
echo "done"
# CSS
echo "Minifying CSS... "
css-minify -f /publish/assets/css/blog.css -o /publish/assets/css
echo "done"

# JavaScript
echo "UglifyingJ JavaScript... "
uglifyjs --compress --mangle --mangle-props -- /mnt/publish/assets/js/onload.js >/mnt/publish/assets/js/onload.min.js
echo "done"

exit 0
