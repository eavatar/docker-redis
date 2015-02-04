#!/bin/bash

exec 2>&1
source /etc/envvars

exec chpst -u ava redis-server /etc/redis/redis.conf