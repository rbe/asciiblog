FROM nginx:latest
COPY default.nginx /etc/nginx/conf.d/default.conf
COPY asciiblog-*.nginx /etc/nginx/
RUN apt-get upgrade \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        vim
WORKDIR /etc/nginx
CMD ["nginx", "-g daemon off;"]