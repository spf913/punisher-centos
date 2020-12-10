#!/bin/bash
exec 2>&1
#exec /usr/local/nginx/sbin/nginx -g "daemon off;"
exec /usr/sbin/nginx -c /etc/nginx/nginx.conf -g "daemon off;"
