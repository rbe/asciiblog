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
    echo "Generating group ${g}: Asciidoc to HTML, $(pwd)"
    find . -type f -name \*.adoc -print0 |
      xargs -r -0 asciidoctor \
        -a linkcss \
        -a copycss \
        -a webfonts! \
        -a iconfont-remote! \
        -a highlightjsdir=/mnt/content/assets/highlight \
        -r asciidoctor-diagram \
        --base-dir=/mnt/content/blog/article \
        -D "/mnt/publish/article/${g}"
    popd >/dev/null
done
popd >/dev/null

exit 0
