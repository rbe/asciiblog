#!/usr/bin/env bash

set -o nounset
set -o errexit

. "/mnt/content/site.env"

nginx_conf="/mnt/docker/webserver/asciiblog-urls.nginx"
:>"${nginx_conf}"

echo "try_files \$uri \$uri/" >>${nginx_conf}
mapfile -t g < <(find /mnt/content/blog/article -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
for g in "${g[@]}"
do
    echo " /article/${g}\$uri" >>${nginx_conf}
    echo " /article/${g}\$uri.html" >>${nginx_conf}
done
echo " /book\$uri" >>${nginx_conf}
echo " =404;" >>${nginx_conf}

exit 0
