FROM iloveuodi/centos:base
MAINTAINER damage_brain

ARG S6_OVERLAY_VERSION=1.22.1.0
ARG S6_OVERLAY_MD5HASH=3060e2fdd92741ce38928150c0c0346a

COPY container-files /

RUN yum -y update --allowerasing && \
cd /tmp && \
curl -L https://www.dropbox.com/s/btf1q4fwjih03lx/s6-overlay-amd64.tar.gz -o s6-overlay-amd64.tar.gz && \
echo "$S6_OVERLAY_MD5HASH *s6-overlay-amd64.tar.gz" | md5sum -c - && \
tar xzf s6-overlay-amd64.tar.gz -C / && \
rm -f s6-overlay-amd64.tar.gz && \
sh /usr/local/sbin/fix-bins.sh

RUN mkdir -p /etc/services.d/nginx && \
    mkdir -p /etc/services.d/php-fpm
#    mkdir -p /etc/services.d/key-db
COPY ./nginxrun /etc/services.d/nginx/run
COPY ./phpfpmrun /etc/services.d/php-fpm/run
#COPY ./keydbrun /etc/services.d/key-db/run

ENTRYPOINT ["/init"]
CMD ["keydb-server", "/redis.conf"]
