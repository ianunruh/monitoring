#!/bin/bash
##
# Installs Redis
#
# Provides:
# - Redis (TCP/6379)
##
set -eux

source env.sh

echo "vm.overcommit_memory=1" > /etc/sysctl.conf
sysctl -f

add-apt-repository -y ppa:chris-lea/redis-server

apt-get update -q
apt-get install -yq redis-server

cp $BASE_PATH/etc/redis/redis.conf /etc/redis
service redis-server restart
