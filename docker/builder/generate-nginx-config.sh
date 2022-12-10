#!/usr/bin/env bash

set -o nounset
set -o errexit

nginx_conf="/mnt/docker/webserver/urls.nginx"
:>"${nginx_conf}"

# nginx: Content-Security-Policy
echo "add_header Content-Security-Policy \"default-src 'self'; child-src 'self' blob:\";" >>"${nginx_conf}"

# nginx: sub_filter
echo "sub_filter '<link rel=\"stylesheet\" href=\"./font-awesome.css\">' '';" >>"${nginx_conf}"

# nginx: try_files
echo "try_files \$uri" >>${nginx_conf}
for g in $(find /mnt/content/blog/article -mindepth 1 -maxdepth 1 -type d -printf "%f\n")
do
    echo " /article/${g}/\$uri" >>${nginx_conf}
done
echo " /book/\$uri" >>${nginx_conf}
echo " /index.html =404;" >>${nginx_conf}

exit 0
