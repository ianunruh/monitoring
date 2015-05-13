#!/bin/bash
##
# Installs Redis
#
# Provides:
# - Redis (TCP/6379)
##
set -eux

source env.sh

echo "vm.overcommit_memory=1" | tee -a /etc/sysctl.conf
sysctl -p

add-apt-repository -y ppa:chris-lea/redis-server

apt-get update -q
apt-get install -yq redis-server
