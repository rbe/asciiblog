FROM nginx:latest AS base
RUN apt-get upgrade \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        vim apache2-utils

FROM base
COPY nginx.conf /etc/nginx/
COPY default.nginx /etc/nginx/conf.d/default.conf
COPY asciiblog-*.nginx /etc/nginx/
RUN mkdir -p /home/rbe \
    && htpasswd -c -b /home/rbe/bensmann.com.htpasswd user user
WORKDIR /etc/nginx
CMD ["nginx", "-g daemon off;"]
