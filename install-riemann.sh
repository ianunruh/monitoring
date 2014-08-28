#!/bin/bash
##
# Installs the Riemann server
#
# Provides:
# - Riemann receiver (TCP/5555 and UDP/5555)
# - Websockets (TCP/5556)
##
BASE_PATH=`pwd`

apt-get update
apt-get install -y openjdk-7-jre-headless unzip

cd /tmp

curl -O -L http://aphyr.com/riemann/riemann_0.2.6_all.deb
dpkg -i riemann_0.2.6_all.deb

cp $BASE_PATH/etc/riemann/riemann.conf /etc/riemann

service riemann restart
