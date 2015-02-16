#!/bin/bash
##
# Installs Kibana, a dashboard for Elasticsearch and Logstash
#
# Uses Apache to provide Grafana at `http://localhost/kibana`
#
# Provides:
# - HTTP (TCP/80)
#
# Dependencies:
# - Elasticsearch (any version)
##
set -eux

source env.sh
KIB_BASE_URL=https://download.elasticsearch.org/kibana/kibana
KIB_TAR=kibana-${KIBANA_VERSION}.tar.gz
KIB_INST_PATH=/usr/share/kibana #you may need to alter apache kibana conf if you touch this
	
cd /tmp
sudo mkdir -p $KIB_INST_PATH 
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$KIB_TAR ]; then wget -P $REPOS_PATH $KIB_BASE_URL/$KIB_TAR; fi
	sudo tar --strip-components=1 -xzvf $REPOS_PATH/$KIB_TAR -C $KIB_INST_PATH &> kibana.log
else
	curl $KIB_BASE_URL/$KIB_TAR | sudo tar --strip-components=1 -xzv -C $KIB_INST_PATH &> kibana.log
fi


cp $BASE_PATH/usr/share/kibana/config.js $KIB_INST_PATH

apt-get install -yq apache2

cp $BASE_PATH/etc/apache2/sites-enabled/kibana.conf /etc/apache2/sites-enabled
service apache2 restart
