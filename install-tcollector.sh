#!/bin/bash
##
# Installs TCollector
#
# Dependencies:
# - OpenTSDB (HTTP/4242)
##
set -eux

source env.sh

apt-get install -yq git supervisor

git clone git://github.com/OpenTSDB/tcollector.git /opt/tcollector

cp $BASE_PATH/etc/supervisor/conf.d/tcollector.conf /etc/supervisor/conf.d
supervisorctl update
