#!/usr/bin/env bash

echo "*"
echo "* GENERATING ROOT"
echo "*"
pushd /mnt/content/root >/dev/null
echo -n "Generating AsciiDoc to HTML in $(pwd)... "
for adoc in *.adoc
do
    asciidoctor \
        -a linkcss \
        -a copycss \
        -a webfonts! \
        -a iconfont-remote! \
        --base-dir=/mnt/content/blog \
        -D /mnt/publish \
        "${adoc}"
done
popd >/dev/null
echo "done"
