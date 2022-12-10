#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* GENERATING BLOG"
echo "*"

# Blog: generate all groups of articles
pushd /mnt/content/blog/article >/dev/null
mapfile -t groups < <(find . -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
echo "Generating article groups: ${groups[@]}"
for g in "${groups[@]}"
do
    pushd "${g}" >/dev/null
    generate-article-html.sh "${g}"
    popd >/dev/null
done
popd >/dev/null

exit 0
