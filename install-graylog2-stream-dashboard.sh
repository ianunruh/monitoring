#!/bin/bash
##
# Installs the Graylog2 stream dashboard
#
# Uses Apache to provide the dashboard at `http://localhost/graylog2-stream-dashboard`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Graylog2 server with CORS enabled
##
set -eux

source env.sh
GRAYDASH_BASE_URL=https://github.com/Graylog2/graylog2-stream-dashboard/releases/download/0.90/
GRAYDASH_TAR=graylog2-stream-dashboard-${GRAYLOG_STREAM_DASHBOARD_VERSION}.tgz
GRAYDASH_INST_PATH=/usr/share/graylog2-stream-dashboard
	
cd /tmp
sudo mkdir -p $GRAYDASH_INST_PATH 
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$GRAYDASH_TAR ]; then wget -P $REPOS_PATH $GRAYDASH_BASE_URL/$GRAYDASH_TAR; fi
	sudo tar --strip-components=1 -xzvf $REPOS_PATH/$GRAYDASH_TAR -C $GRAYDASH_INST_PATH &> graydash.log
else
	curl $GRAYDASH_BASE_URL/$GRAYDASH_TAR | sudo tar --strip-components=1 -xzv -C $GRAYDASH_INST_PATH &> graydash.log
fi

apt-get install -yq apache2

cp $BASE_PATH/etc/apache2/sites-enabled/graylog2-stream-dashboard.conf /etc/apache2/sites-enabled
service apache2 restart
