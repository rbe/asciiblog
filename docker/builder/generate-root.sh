#!/usr/bin/env bash

set -o errexit
set -o nounset

echo "*"
echo "* GENERATING ROOT"
echo "*"
pushd /mnt/content/root >/dev/null
echo -n "Generating AsciiDoc to HTML in $(pwd)... "
mapfile -t adoc < <(find . -type f -name \*.adoc -printf "%f\n")
for a in "${adoc[@]}"
do
    echo -n "${a} "
    asciidoctor \
        -a linkcss \
        -a copycss \
        -a webfonts! \
        -a iconfont-remote! \
        -a stylesheet=/assets/css/blog.min.css \
        -a docinfodir=/mnt/content/docinfo \
        -a includedir=/mnt/content/include \
        -r asciidoctor-diagram \
        --base-dir=/mnt/content/root \
        -D /mnt/publish \
        "${a}"
done
popd >/dev/null
echo "done"
