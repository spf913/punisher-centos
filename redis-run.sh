#!/bin/bash
exec 2>&1
exec /usr/local/redis/bin/redis-server
