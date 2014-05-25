#!/bin/bash
##
# Installs Skyline, the anomaly detection component of Etsy's Kale stack
#
# Provides:
# - HTTP (TCP/9000)
# - Graphite metric receiver (TCP/2024)
# - MessagePack metric receiver (UDP/2025)
#
# Dependencies:
# - Carbon
# - Redis
##
BASE_PATH=`pwd`

useradd -d /opt/skyline -M skyline

mkdir -p /var/log/skyline
chown skyline:skyline /var/log/skyline

apt-get install -y python-pip python-numpy python-scipy python-pandas python-msgpack git

git clone git://github.com/etsy/skyline.git /opt/skyline
cd /opt/skyline

chown skyline:skyline src/webapp/static/dump

pip install -r requirements.txt

cp $BASE_PATH/etc/init/skyline* /etc/init
cp $BASE_PATH/opt/skyline/src/settings.py /opt/skyline/src

service skyline-horizon start
service skyline-analyzer start
service skyline-webapp start
