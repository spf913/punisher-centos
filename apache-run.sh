#!/bin/bash
exec 2>&1
exec /usr/local/apache/bin/httpd -k start
