#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* INFO"
echo "*"
asciidoctor -v
echo ""
node -v
echo ""
npm -v
echo ""
convert -version

# Blog: generate all groups of articles
generate-blog.sh
generate-blog-index.sh
# Books: generate all books
generate-book.sh
generate-book-index.sh
# nginx: try_files
generate-nginx-config.sh
# Root: generate content
generate-root.sh
# Publish
publish.sh

exit 0
