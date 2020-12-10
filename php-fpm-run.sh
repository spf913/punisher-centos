#!/bin/bash
exec 2>&1
#exec /usr/local/php/sbin/php-fpm
#exec /mnt/ramdisk/bin/php7/sbin/php-fpm
exec /mnt/ramdisk/bin/php7/sbin/php-fpm --nodaemonize --fpm-config=/mnt/ramdisk/bin/php7/etc/php-fpm.d/www.conf
