#!/usr/bin/env bash

set -o errexit
set -o nounset

sitemap_xml="/mnt/publish/sitemap.xml"
datum="$(date +%Y-%m-%d)"

cat <<EOF >${sitemap_xml}
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://bensmann.com/</loc>
    <lastmod>${datum}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>1.0</priority>
  </url>
EOF

mapfile -t html < <(find /mnt/publish . -type f -name \*.html \
    -a -not \
    \( \
       -name docinfo\*.html \
    -o -name \*title.html \
    -o -name \*header.html \
    -o -name \*navigation.html \
    -o -name \*introduction.html \
    \) \
 -printf "%f\n")
for h in "${html[@]}"
do
    cat <<EOF >>${sitemap_xml}
  <url>
    <loc>https://bensmann.com/${h}</loc>
    <lastmod>${datum}</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.5</priority>
  </url>
EOF
done

cat <<EOF >>${sitemap_xml}
</urlset>
EOF

exit 0
