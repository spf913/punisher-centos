# to add additional compile options to PHP, add " \" after the last
# element. You *must* put a space and then a backslash so the configure
# script knows that the there is more to the build script
#!/bin/sh

######################
# To build PHP
# STEP 1: sh build_php.sh
# STEP 2: make -j number_of_cores_or_processors_CPU_has
# STEP 3: make install
######################

INSTALL_DIR=/mnt/ramdisk/bin

mkdir -p $INSTALL_DIR

./configure --prefix=$INSTALL_DIR \
        --with-config-file-path=$INSTALL_DIR/etc \
	--with-config-file-scan-dir=$INSTALL_DIR/etc/php.d \
	--with-fpm-user=www-data \
        --with-fpm-group=www-data \
	--enable-fpm \
	--enable-opcache \
	--disable-fileinfo \
	--enable-mysqlnd \
	--with-mysqli=mysqlnd \
	--with-pdo-mysql=mysqlnd \
	--with-freetype \
	--with-jpeg \
	--with-zlib \
	--enable-xml \
	--disable-rpath \
	--enable-bcmath \
	--enable-shmop \
	--enable-exif \
	--enable-sysvsem \
	--enable-inline-optimization \
	--enable-mbregex \
	--enable-mbstring \
	--with-password-argon2 \
	--with-sodium=/usr/local \
	--enable-gd \
	--with-mhash \
	--enable-pcntl \
	--enable-sockets \
	--with-xmlrpc \
	--enable-ftp \
	--enable-intl \
	--with-xsl \
	--with-gettext \
	--with-zip=/usr/local \
	--enable-soap \
	--disable-debug \
	--disable-cgi \
	--enable-sysvmsg \
	--enable-sysvshm \
	--with-curl \
	--without-pear \
	--with-openssl


# to add additional compile options to PHP, add " \" after the last
# element. You *must* put a space and then a backslash so the configure
# script knows that the there is more to the build script
