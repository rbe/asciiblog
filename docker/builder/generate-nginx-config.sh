#!/usr/bin/env bash

set -o nounset
set -o errexit

nginx_conf="/mnt/docker/webserver/urls.nginx"
:>"${nginx_conf}"

# nginx: Caching
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

# nginx: Content-Security-Policy
echo "add_header Content-Security-Policy \"default-src 'self'; child-src 'self' blob:\";" >>"${nginx_conf}"

# nginx: sub_filter
cat <<EOF >>"${nginx_conf}"
sub_filter '<link rel="stylesheet" href="./asciidoctor.css">' '';
sub_filter '<link rel="stylesheet" href="./font-awesome.css">' '';
EOF

# nginx: try_files
echo "try_files \$uri \$uri/" >>${nginx_conf}
for g in $(find /mnt/content/blog/article -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
do
    echo " /article/${g}\$uri" >>${nginx_conf}
done
echo " /book\$uri" >>${nginx_conf}
echo " =404;" >>${nginx_conf}

exit 0
