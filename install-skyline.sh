#!/bin/bash
BASE_PATH=`pwd`

useradd -b /opt skyline

mkdir -p /var/log/skyline
chown skyline:skyline /var/log/skyline

apt-get install -y python-pip python-numpy python-scipy git

pip install pandas
pip install patsy
pip install statsmodels
pip install msgpack_python

git clone git://github.com/etsy/skyline.git /opt/skyline
cd /opt/skyline

chown skyline:skyline src/webapp/static/dump

pip install -r requirements.txt

cp $BASE_PATH/etc/init/skyline* /etc/init
cp $BASE_PATH/opt/skyline/src/settings.py /opt/skyline/src

service skyline-horizon start
service skyline-analyzer start
service skyline-webapp start
