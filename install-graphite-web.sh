#!/bin/bash
##
# Installs Graphite web, which provides an API and dashboard for consumers of metrics
#
# It is backed by SQLite, since Grafana should be utilized instead of the Graphite dashboard.
#
# Uses Apache to provide Graphite at `http://localhost`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Carbon
##
set -eux

source env.sh

apt-get install -yq graphite-web apache2 apache2-mpm-worker libapache2-mod-wsgi

chown _graphite /var/lib/graphite
sudo -u _graphite graphite-manage syncdb --noinput

rm /etc/apache2/sites-enabled/000-default.conf
cp $BASE_PATH/etc/apache2/sites-enabled/graphite.conf /etc/apache2/sites-enabled
cp $BASE_PATH/etc/graphite/local_settings.py /etc/graphite

service apache2 restart
