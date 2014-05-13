#!/bin/bash
BASE_PATH=`pwd`

apt-get install -y graphite-web python-psycopg2 apache2 apache2-mpm-worker libapache2-mod-wsgi

sudo -i -u postgres psql <<EOF
CREATE USER graphite WITH PASSWORD 'graphite';
CREATE DATABASE graphite OWNER graphite;
EOF

rm /etc/apache2/sites-enabled/000-default.conf
cp $BASE_PATH/etc/apache2/sites-enabled/graphite.conf /etc/apache2/sites-enabled
cp $BASE_PATH/etc/graphite/local_settings.py /etc/graphite

service apache2 restart

graphite-manage syncdb --noinput
