# add local bin directory
if [ -d "/mnt/ramdisk/bin/php7/bin" ] ; then
  PATH="/mnt/ramdisk/bin/php7/bin:$PATH"
fi

# press ctrl-c to exit cat
if [ -d "/mnt/ramdisk/bin/php7" ] ; then
      PATH="/mnt/ramdisk/bin/php7/bin:/mnt/ramdisk/bin/php7/sbin:$PATH"
    fi
