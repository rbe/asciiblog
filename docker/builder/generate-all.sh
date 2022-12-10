#!/usr/bin/env bash

set -o nounset
set -o errexit

# Blog: generate all groups of articles
generate-blog.sh
generate-blog-index.sh
# Books: generate all books
generate-book.sh
generate-book-index.sh
# nginx: try_files
generate-nginx-config.sh
# root
generate-root.sh
# Publish
publish.sh

exit 0
