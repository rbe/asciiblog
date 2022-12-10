#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* GENERATING BLOG INDEX"
echo "*"

blog_index="/mnt/content/blog/blog.adoc"
:>"${blog_index}"
echo "Generating blog index to ${blog_index}... "
cat <<EOF >"${blog_index}"
include::blog-header.adoc[]

include::blog-introduction.adoc[]

EOF

echo -n "Adding groups to index... "
pushd /mnt/content/blog/article >/dev/null
mapfile -t groups < <(find . -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
if [[ "${#groups[@]}" -gt 0 ]]
then
    echo "${groups[@]}"
    for i in $(seq $((${#groups[@]} - 1)) -1 0)
    do
        g="${groups[${i}]}"
        echo "Processing group ${g}... "
        cat <<EOF >>"${blog_index}"

== ${g}

EOF
        pushd "${g}" >/dev/null
        for n in $(find . -type f -name \*.adoc)
        do
            # Find first heading 2
            t="$(grep -m 1 "== " "${n}" | cut -d ' ' -f 2-)"
            echo -n "Adding '${t}' to blog index... "
            echo "* xref:/${n}[${t}]" >>"${blog_index}"
            echo "done"
        done
        popd >/dev/null
    done
fi
popd >/dev/null
echo "done"

pushd /mnt/content/blog >/dev/null
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

rm "${blog_index}"

exit 0
