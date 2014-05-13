#!/bin/bash
BASE_PATH=`pwd`

useradd -b /opt skyline

mkdir -p /var/log/skyline /var/run/skyline
chown skyline:skyline /var/log/skyline /var/run/skyline

apt-get install -y python-pip python-numpy python-scipy git redis-server

pip install pandas
pip install patsy
pip install statsmodels
pip install msgpack_python

git clone git://github.com/etsy/skyline.git /opt/skyline
cd /opt/skyline

chown skyline:skyline src/webapp/static/dump

pip install -r requirements.txt

cp $BASE_PATH/opt/skyline/src/settings.py /opt/skyline/src

cp $BASE_PATH/etc/init/skyline* /etc/init
cp $BASE_PATH/etc/redis/skyline.conf /etc/redis

service skyline-redis start
service skyline-horizon start
service skyline-analyzer start
service skyline-webapp start
