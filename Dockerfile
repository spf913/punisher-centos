FROM centos:centos8 as oneinstack
LABEL maintainer="damage_brain"

# Use baseimage-docker's init system.
#CMD ["/sbin/my_init"]

ADD spf913-depend.tar.gz /
WORKDIR /spf913-depend
RUN yum install /spf913-depend/*.rpm -y --allowerasing
RUN yum install -y /spf913-depend/autoconf/*.rpm && \
yum install -y /spf913-depend/automake/*.rpm && \
yum install -y /spf913-depend/pkgconf-m4/*.rpm && \
yum install -y /spf913-depend/redhat-rpm-config/*.rpm && \
yum install -y /spf913-depend/asciidoc/*.rpm && \
yum install -y /spf913-depend/intltool/*.rpm && \
yum install -y /spf913-depend/perl-Fedora-VSP/*.rpm && \
yum install -y /spf913-depend/perl-generators/*.rpm && \
yum install -y /spf913-depend/rpmdevtools/*.rpm && \
yum install -y /spf913-depend/perl-ExtUtils-Embed/*.rpm
#yum install -y --cacheonly --disablerepo=* /spf913-depend/pkgconf-m4/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/redhat-rpm-config/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/asciidoc/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/intltool/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/perl-Fedora-VSP/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/perl-generators/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/rpmdevtools/*.rpm && \
#yum install -y --cacheonly --disablerepo=* /spf913-depend/perl-ExtUtils-Embed/*.rpm
# updating system with apt-get update

#ENV DEBIAN_FRONTEND noninteractive
#RUN curl -L http://mirror.centos.org/centos/8/AppStream/x86_64/os/Packages/oniguruma-6.8.2-1.el8.x86_64.rpm -o oniguruma-6.8.2-1.el8.x86_64.rpm && \
#    curl -L http://mirror.centos.org/centos/8/PowerTools/x86_64/os/Packages/oniguruma-devel-6.8.2-1.el8.x86_64.rpm -o oniguruma-devel-6.8.2-1.el8.x86_64.rpm && \
#    yum install ./oniguruma-6.8.2-1.el8.x86_64.rpm -y && \
#    yum install ./oniguruma-devel-6.8.2-1.el8.x86_64.rpm -y
    
#RUN curl http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/r/re2c-0.14.3-2.el7.x86_64.rpm --output re2c-0.14.3-2.el7.x86_64.rpm && \
#    rpm -Uvh re2c-0.14.3-2.el7.x86_64.rpm && \
#    yum install epel-release -y && \
#    yum makecache -y && \
#    yum install -y autoconf automake binutils bison flex gcc gcc-c++ gdb glibc-devel \
#    libtool make pkgconf pkgconf-m4 pkgconf-pkg-config redhat-rpm-config \
#    rpm-build rpm-sign strace asciidoc byacc ctags diffstat git intltool \
#    ltrace patchutils perl-Fedora-VSP perl-generators pesign source-highlight systemtap \
#    valgrind cmake expect rpmdevtools rpmlint perl perl-devel perl-ExtUtils-Embed \
#    libxslt libxslt-devel libxml2 libxml2-devel gd gd-devel GeoIP GeoIP-devel sqlite sqlite-devel oniguruma-devel libargon2 libargon2-devel libzip-devel && \
#    apt-get -y autoremove && \
#    apt-get -yf install && \
#    export DEBIAN_FRONTEND=noninteractive && \
#    apt-get --no-install-recommends -y install vim git build-essential nasm autotools-dev autoconf libjemalloc-dev tcl tcl-dev uuid-dev libcurl4-openssl-dev autoconf autotools-dev libnuma-dev libtool libfreetype6-dev libperl-dev debian-keyring debian-archive-keyring build-essential gcc g++ make cmake autoconf libjpeg8 libjpeg8-dev libpng-dev libxml2 libxml2-dev zlib1g zlib1g-dev libc6 libc6-dev libc-client2007e-dev libglib2.0-0 libglib2.0-dev bzip2 libzip-dev libbz2-1.0 libncurses5 libncurses5-dev libaio1 libaio-dev numactl libreadline-dev curl libcurl3-gnutls e2fsprogs libkrb5-3 libkrb5-dev libltdl-dev libidn11 libidn11-dev openssl net-tools libssl-dev libtool libevent-dev re2c libsasl2-dev libxslt1-dev libicu-dev libsqlite3-dev bison patch vim zip unzip tmux htop bc dc expect libexpat1-dev iptables rsyslog libonig-dev libtirpc-dev libnss3 rsync git lsof lrzsz ntpdate psmisc wget autoconf build-essential libssl-dev pkg-config zlib1g-dev libsodium-dev libcurl4-openssl-dev sqlite3 libsqlite3-dev perl libperl-dev libgd3 libgd-dev libgeoip1 libgeoip-dev geoip-bin libxml2 libxml2-dev libxslt1.1 libxslt1-dev
#    yum install -y autoconf libtool re2c bison libxml2-devel bzip2-devel libcurl-devel libpng-devel libicu-devel gcc-c++ libmcrypt-devel libwebp-devel libjpeg-devel openssl-devel libxslt-devel make



# preparing system for step i
#RUN export DEBIAN_FRONTEND=noninteractive && \
RUN yum remove -y apache2 apache2-doc apache2-utils apache2.2-common apache2.2-bin apache2-doc php5 php5-cli php5-mysql php5-curl php5-gd
ADD libsodium-1.0.18-stable.tar.gz /
#WORKDIR libsodium-stable
RUN cd /libsodium-stable && \
    ./configure --prefix=/usr && \
    make && make check && \
    make install && \
    ldconfig

# making directory and installing necessary dependencies
RUN mkdir -p /mnt/ramdisk && \
    cd /mnt/ramdisk/ && \
    mkdir -p bin && \
    cd bin

# Adding argon2 phc source
ADD phc-winner-argon2-master.tar.gz /

# Building Argon from Source
WORKDIR /phc-winner-argon2-master
#RUN cd phc-winner-argon2-master  && \
RUN export THREAD=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l) && \
    make -j ${THREAD} && \
    make test && \
    make install PREFIX=/usr && \
    cp /usr/lib/x86_64-linux-gnu/libargon2.so.1 /lib64/

ADD KeyDB.tar.gz /
WORKDIR /KeyDB
RUN make -j$(nproc) && \
    make install


# ~/.bashrc
ADD .bashrc /root/.bashrc
RUN /bin/bash -c "source /root/.bashrc" && \

# pkg-config
    ln -s /usr/include/x86_64-linux-gnu/curl /usr/include/curl

#
# oneinstack
#


ADD php-7.4.9.tar.gz /
WORKDIR /php-7.4.9
RUN ./build_php.sh && \
    make clean && \
    export THREAD=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l) && \
    make -j ${THREAD} && \
    make clean && \
    make install && \
    cd / && \
    rm -rf tmp && \
    mkdir -p /mnt/ramdisk/bin/php7/etc/php.d 

# PHPREDIS
ADD phpredis-master.tar.gz /
RUN mkdir -p /tmp && \
    chmod 0777 /tmp && \
    cd /phpredis-master && \
    /mnt/ramdisk/bin/php7/bin/phpize && \
    ./configure --with-php-config=/mnt/ramdisk/bin/php7/bin/php-config && \
    make && \
    make install

# PHPREDIS INI
ADD redis.ini /

ADD php.ini /
ADD www.conf /
ADD php-fpm.conf / 
ADD 02-opcache.ini /

#ADD cp /php.ini /mnt/ramdisk/bin/php7/lib/ && \
#    cp /www.conf /mnt/ramdisk/bin/php7/etc/php-fpm.d/ && \
#    cp /php-fpm.conf /mnt/ramdisk/bin/php7/etc/
#    cp /02-opcache.ini /mnt/ramdisk/bin/php7/etc/php.d/

RUN ["cp",  "/php.ini", "/mnt/ramdisk/bin/php7/lib/"]
RUN ["cp", "/www.conf", "/mnt/ramdisk/bin/php7/etc/php-fpm.d/"]
RUN ["cp", "/02-opcache.ini", "/mnt/ramdisk/bin/php7/etc/php.d/"]
RUN ["cp",  "/php-fpm.conf","/mnt/ramdisk/bin/php7/etc/"]

#PHPREDIS ini
RUN ["cp", "/redis.ini", "/mnt/ramdisk/bin/php7/etc/php.d/"] 

# install composer


ADD tmp.tar.gz /
ADD nginx-1.18.0.tar.gz /
ADD pcre-8.44.tar.gz /
ADD zlib-1.2.11.tar.gz /
ADD openssl-1.1.1g.tar.gz /

WORKDIR /nginx-1.18.0
RUN ./nginx_build.sh && \
    export THREAD=$(grep 'processor' /proc/cpuinfo | sort -u | wc -l) && \
    make -j ${THREAD} && \
    make install && \
    ln -s /usr/lib/nginx/modules /etc/nginx/modules && \
    mkdir -p /home/nonexistent && \
    mkdir -p /nonexistent && \
    useradd --system --home /nonexistent --shell /bin/false --comment "nginx user" --user-group nginx && \
    tail -n 1 /etc/passwd /etc/group /etc/shadow && \
    mkdir -p /var/cache/nginx/client_temp /var/cache/nginx/fastcgi_temp /var/cache/nginx/proxy_temp /var/cache/nginx/scgi_temp /var/cache/nginx/uwsgi_temp && \
    chmod 700 /var/cache/nginx/* && \
    chown nginx:root /var/cache/nginx/*
#apache nginx php-fpm php redis client
ADD nginx /etc/ufw/applications.d/nginx
ADD logrotate /etc/logrotate.d/logrotate


#RUN rm -rf /etc/nginx/* && \
#    rm -rf /etc/nginx && \
#    mkdir -p /etc/nginx && \
    #mkdir /etc/nginx/{conf.d,snippets,sites-available,sites-enabled} && \
    #chmod 640 /var/log/nginx/* && \
    #chown nginx:adm /var/log/nginx/access.log /var/log/nginx/error.log && \
RUN mv /etc/logrotate.d/logrotate nginx && \
    mkdir -p /var/lib/nginx/body && \
    mkdir -p /var/lib/nginx/fastcgi && \
    mkdir -p /etc/nginx/conf.d && \
    mkdir -p /etc/nginx/global && \
    mkdir -p /etc/nginx/sites-available && \
    mkdir -p snippets && \
    mkdir -p /etc/nginx/global/server && \
    rm -rf /etc/nginx/nginx.conf
ADD upstream_varnish.conf /etc/nginx/conf.d/upstream_varnish.conf
ADD upstream_php-wordpress.conf /etc/nginx/conf.d/upstream_php-wordpress.conf
ADD exclusions.conf /etc/nginx/global/server/exclusions.conf
ADD fastcgi-cache.conf /etc/nginx/global/server/fastcgi-cache.conf
ADD security.conf /etc/nginx/global/server/security.conf
ADD ssl.conf /etc/nginx/global/server/ssl.conf
ADD static-files.conf /etc/nginx/global/server/static-files.conf
ADD fastcgi-params.conf /etc/nginx/global/fastcgi-params.conf
ADD gzip.conf /etc/nginx/global/gzip.conf
ADD http.conf /etc/nginx/global/http.conf
ADD limits.conf /etc/nginx/global/limits.conf
ADD mime-types.conf /etc/nginx/global/mime-types.conf
ADD wpintense.cluster.conf /etc/nginx/sites-available/wpintense.cluster.conf
ADD acme-challenge.conf /etc/nginx/snippets/acme-challenge.conf
ADD fastcgi-php.conf /etc/nginx/snippets/fastcgi-php.conf
ADD nginx-cloudflare.conf /etc/nginx/snippets/nginx-cloudflare.conf
ADD snakeoil.conf /etc/nginx/snippets/snakeoil.conf
ADD nginx.conf /etc/nginx/nginx.conf
ADD redis.conf /
#RUN ["cp",  "/wordpress-cluster/etc/nginx/*","-R", "/etc/nginx/"]
    #cp /root/wordpress-cluster/etc/nginx/* -R /etc/nginx/ && \
RUN mkdir -p /etc/nginx/sites-enabled && cd /etc/nginx/sites-available/ && \
    ln -s /etc/nginx/sites-available/wpintense.cluster.conf /etc/nginx/sites-enabled/ && \
    mkdir /sites/wpicluster/cache -p
# Add apache daemon to runit
#RUN mkdir /etc/service/apache
#COPY apache-run.sh /etc/service/apache/run
#RUN chmod a+x /etc/service/apache/run

# Add nginx daemon to runit
#RUN mkdir /etc/service/nginx
#COPY nginx-run.sh /etc/service/nginx/run
#RUN chmod a+x /etc/service/nginx/run

# Add php-fpm daemon to runit
#RUN mkdir /etc/service/php-fpm
#COPY php-fpm-run.sh /etc/service/php-fpm/run
#RUN chmod a+x /etc/service/php-fpm/run

# Add php-fpm 7.2  daemon to runit
#RUN mkdir /etc/service/php72-fpm
#COPY php72-fpm-run.sh /etc/service/php72-fpm/run
#RUN chmod a+x /etc/service/php72-fpm/run

# Add KeyDB  daemon to runit
#RUN mkdir /etc/service/keydb
#COPY keydb-run.sh /etc/service/keydb/run
#RUN chmod a+x /etc/service/keydb/run


#
# clean apt cache and tune PHP
#
#RUN rm -rf /usr/local/php/etc/php-fpm.conf && \
#    rm -rf /usr/local/php/etc/php.ini && \
#    rm -rf /usr/local/php72/etc/php-fpm.conf && \
#    rm -rf /usr/local/php72/etc/php.ini

#COPY php-fpm.conf /usr/local/php/etc
#COPY php.ini /usr/local/php/etc
#COPY redis.conf /

#ADD php72.tar.gz /

#RUN cp -R /php72/* /usr/local/php72/etc && \
#RUN apt-get -y autoremove && apt-get clean && \
#    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
#    rm -rf /oneinstack

WORKDIR /
EXPOSE 80 8080 443 3306 6379 9000
#EXPOSE 80 8080 443 3306 6379 9000

