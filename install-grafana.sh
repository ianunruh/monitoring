#!/bin/bash
##
# Installs Grafana, an alternate Graphite dashboard
#
# Uses Apache to provide Grafana at `http://localhost/grafana`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Elasticsearch (any version)
# - Graphite web
##
set -eux

source env.sh
GRAF_BASE_URL=http://grafanarel.s3.amazonaws.com
GRAF_TAR=grafana-${GRAFANA_VERSION}.tar.gz
GRAF_INST_PATH=/usr/share/grafana
	
cd /tmp

sudo mkdir -p $GRAF_INST_PATH 
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$GRAF_TAR ]; then wget -P $REPOS_PATH $GRAF_BASE_URL/$GRAF_TAR; fi
	sudo tar --strip-components=1 -xzvf $REPOS_PATH/$GRAF_TAR -C $GRAF_INST_PATH &> grafana.log
else
	curl $GRAF_BASE_URL/$GRAF_TAR | sudo tar --strip-components=1 -xzv -C $GRAF_INST_PATH &> grafana.log
fi

cp $BASE_PATH/usr/share/grafana/config.js $GRAF_INST_PATH

apt-get install -yq apache2

cp $BASE_PATH/etc/apache2/sites-enabled/grafana.conf /etc/apache2/sites-enabled
service apache2 restart
