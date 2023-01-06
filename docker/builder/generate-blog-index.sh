#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* GENERATING BLOG INDEX"
echo "*"

blog_index="/tmp/blog.adoc"
:>"${blog_index}"
echo "Generating blog index to ${blog_index}... "
cat <<EOF >"${blog_index}"
include::{includedir}/blog-header.adoc[]

include::{includedir}/blog-introduction.adoc[]

EOF

echo -n "Adding articles to blog index... "
pushd /mnt/content/blog >/dev/null
mapfile -t articles < <(find . -type f -printf "%f\n")
for a in "${articles[@]}"
do
    # Find first heading 2
    t="$(grep -m 1 "== " "${a}" | cut -d ' ' -f 2-)"
    echo -n "${a} "
    echo "* xref:/${a}[${t}]" >>"${blog_index}"
done
echo "done"
popd >/dev/null

echo -n "Generating AsciiDoc to HTML: ${blog_index}... "
pushd /mnt/content/blog >/dev/null
asciidoctor \
    -a linkcss \
    -a copycss \
    -a webfonts! \
    -a iconfont-remote! \
    -a stylesheet=/assets/css/blog.min.css \
    -a docinfodir=/mnt/content/docinfo \
    -a includedir=/mnt/content/include \
    --base-dir=/mnt/content/blog \
    -D /mnt/publish \
    "${blog_index}"
echo "done"
popd >/dev/null

rm "${blog_index}"

exit 0
