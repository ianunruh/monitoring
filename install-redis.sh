#!/bin/bash
BASE_PATH=`pwd`

echo "vm.overcommit_memory=1" > /etc/sysctl.conf
sysctl -f

apt-get install -y redis-server

cp $BASE_PATH/etc/redis/redis.conf /etc/redis
service redis-server restart
