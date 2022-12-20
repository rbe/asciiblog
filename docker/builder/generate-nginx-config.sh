#!/usr/bin/env bash

set -o nounset
set -o errexit

. /mnt/content/site.env

nginx_conf="/mnt/docker/webserver/urls.nginx"
:>"${nginx_conf}"

echo "try_files \$uri \$uri/" >>${nginx_conf}
for g in $(find /mnt/content/blog/article -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
do
    echo " /article/${g}\$uri" >>${nginx_conf}
done
echo " /book\$uri" >>${nginx_conf}
echo " =404;" >>${nginx_conf}

cat <<EOF >>"${nginx_conf}"
location ~* .(eot|otf|woff|woff2|ttf|ico)$ {
    expires modified +1y;
    access_log off;
}
location ~* .(svg|png|jpg|jpeg|gif|png)$ {
    expires modified +1w;
    access_log off;
}
location ~* .(css|js)$ {
    expires modified +1w;
    access_log off;
}
EOF

#add_header Link '<https://${SITE_BASE_URL}/assets/fontawesome/css/site.css>; rel="preconnect"';
cat <<EOF >>"${nginx_conf}"
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains;";
add_header Content-Security-Policy "default-src 'self'; child-src 'self' blob:;";
#add_header Permissions-Policy: "";
add_header Referrer-Policy "strict-origin-when-cross-origin";
add_header X-Content-Type-Options "nosniff";
add_header X-XSS-Protection "1; mode=block;";
add_header X-Frame-Options "SAMEORIGIN";
EOF

cat <<EOF >>"${nginx_conf}"
sub_filter '<link rel="stylesheet" href="./asciidoctor.css">' '';
sub_filter '<link rel="stylesheet" href="./font-awesome.css">' '';
EOF

cat <<EOF >>"${nginx_conf}"
gzip on;
gzip_types text/plain
           font/woff2
           text/css
           text/javascript application/javascript application/x-javascript
           application/json
           text/xml application/xml application/xhtml+xml application/xml+rss;
gzip_proxied no-cache no-store no_last_modified private expired auth;
gzip_min_length 256;
gzip_comp_level 6;
EOF

exit 0
