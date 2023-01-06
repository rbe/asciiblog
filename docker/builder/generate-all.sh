#!/usr/bin/env bash

set -o nounset
set -o errexit

echo "*"
echo "* INFO"
echo "*"
echo "asciidoctor"
asciidoctor -v
echo ""
echo "node"
node -v
echo ""
echo "npm"
npm -v
echo ""
echo "ImageMagick convert"
convert -version
echo ""

echo -n "Cleaning up..."
find /mnt/publish -print0 | xargs -r -0 rm -rf
echo "done"

# Index
generate-blog-index.sh
# Blog: generate all groups of articles
generate-blog.sh
# Books: generate all books
generate-book.sh
# Root: generate content
generate-root.sh
# Sitemap
generate-sitemap.sh
# Publish everything to /mnt/publish
publish.sh
# Cleanup unneeded files
cleanup-publish.sh

exit 0
