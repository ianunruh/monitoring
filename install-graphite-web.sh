#!/bin/bash
BASE_PATH=`pwd`

apt-get install -y graphite-web apache2 apache2-mpm-worker libapache2-mod-wsgi

chown _graphite /var/lib/graphite
graphite-manage syncdb --noinput

rm /etc/apache2/sites-enabled/000-default.conf
cp $BASE_PATH/etc/apache2/sites-enabled/graphite.conf /etc/apache2/sites-enabled
cp $BASE_PATH/etc/graphite/local_settings.py /etc/graphite

service apache2 restart
