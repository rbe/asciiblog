#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* GENERATING BOOK"
echo "*"

# Books: generate all books
pushd /mnt/content/book >/dev/null
mapfile -t books < <(find . -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
echo "Generating books: ${books[*]}"
for g in "${books[@]}"
do
    pushd "${g}" >/dev/null
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
        --base-dir="/mnt/content/book/${g}" \
        -D "/mnt/publish/book" \
        "${g}.adoc"
    popd >/dev/null
done

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
    --base-dir="/mnt/content/book" \
    -D "/mnt/publish" \
    "book.adoc"

popd >/dev/null


exit 0
