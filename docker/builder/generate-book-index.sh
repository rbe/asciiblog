#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* GENERATING BOOK INDEX"
echo "*"

book_index="/mnt/content/book/book.adoc"
:>"${book_index}"
echo -n "Generating book index to ${book_index}... "
cat <<EOF >"${book_index}"
include::book-header.adoc[]

include::book-introduction.adoc[]

EOF
echo "done"

echo -n "Adding books to index... "
pushd /mnt/content/book >/dev/null
mapfile -t books < <(find . -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
echo "${books[@]}"
for b in ${books[@]}
do
    n="${b}/${b}.adoc"
    # Find first heading 1
    t="$(grep -m 1 "= " "${n}" | cut -d ' ' -f 2-)"
    echo -n "Adding ${t} to book index... "
    echo "* xref:/book/${b}.adoc[${t}]" >>"${book_index}"
    echo "done"
done

echo -n "Generating AsciiDoc to HTML in $(pwd)... "
for adoc in *.adoc
do
    asciidoctor \
        -a linkcss \
        -a copycss \
        -a webfonts! \
        -a iconfont-remote! \
        --base-dir=/mnt/content/book \
        -D /mnt/publish \
        "${adoc}"
done
echo "done"
popd >/dev/null

rm "${book_index}"

exit 0
