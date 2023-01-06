#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* GENERATING BLOG"
echo "*"

# Blog: generate all articles
echo -n "Generating articles... "
pushd /mnt/content/blog >/dev/null
mapfile -t adoc < <(find . -type f -name \*.adoc -printf "%f\n")
for a in "${adoc[@]}"
do
  echo -n "${a} "
  asciidoctor \
    -a linkcss \
    -a copycss \
    -a webfonts! \
    -a iconfont-remote! \
    -a highlightjsdir=/mnt/content/assets/highlight \
    -a stylesheet=/assets/css/blog.min.css \
    -a docinfodir=/mnt/content/docinfo \
    -a includedir=/mnt/content/include \
    -r asciidoctor-diagram \
    --base-dir=/mnt/content/blog \
    -D "/mnt/publish/blog" \
    "${a}"
done
echo "done"
popd >/dev/null

exit 0
