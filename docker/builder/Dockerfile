FROM ubuntu:latest AS base
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        cpio rsync curl

FROM base AS tools
RUN apt-get -y install \
        asciidoctor ruby-asciidoctor-kroki ruby-asciidoctor-plantuml ruby-asciidoctor-pdf \
        plantuml \
        imagemagick \
        python3-blockdiag \
    && curl -fsSL -o - https://deb.nodesource.com/setup_18.x | bash \
    && apt-get -y install nodejs \
    && gem install asciidoctor-diagram \
    && gem install barby \
    && gem install rqrcode \
    && npm install --global state-machine-cat \
    && npm install --global uglify-js css-minify

FROM tools
COPY *.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh
WORKDIR /mnt
