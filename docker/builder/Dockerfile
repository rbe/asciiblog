FROM ubuntu:latest
COPY *.sh /usr/local/bin/
ADD highlight.tar /opt/highlight/
RUN chmod +x /usr/local/bin/*.sh \
    && apt-get update \
    && apt-get -y install --no-install-recommends \
        cpio asciidoctor rsync
WORKDIR /mnt
