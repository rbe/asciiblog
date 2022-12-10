#!/usr/bin/env bash

set -o nounset
set -o errexit

g="$1"
echo "Generating group ${g}: Asciidoc to HTML, $(pwd)"
find . -type f -name \*.adoc -print0 |
  xargs -r -0 asciidoctor \
    -a linkcss \
    -a copycss \
    -a webfonts! \
    -a iconfont-remote! \
    -a highlightjsdir=/opt/highlight \
    --base-dir=/mnt/content/blog/article \
    -D "/mnt/publish/article/${g}"

exit 0