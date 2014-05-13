#!/bin/bash
apt-get install -y redis-server

echo "vm.overcommit_memory=1" > /etc/sysctl.conf
sysctl -f
