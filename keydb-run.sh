#!/bin/bash
exec 2>&1
exec keydb-server /redis.conf
