#!/bin/bash
##
# Installs the Graylog2 web interface
#
# Provides:
# - HTTP (TCP/8400)
#
# Dependencies:
# - Graylog2 server
##
set -eux

source env.sh
GRAY2_BASE_URL=https://github.com/Graylog2/graylog2-web-interface/releases/download/${GRAYLOG_VERSION}
GRAY2_TAR=graylog2-web-interface-${GRAYLOG_VERSION}.tgz
GRAY2_INST_PATH=/usr/share/graylog2-web-interface
	
apt-get install -yq openjdk-7-jre-headless

cd /tmp

useradd -s /bin/false -d /var/lib/graylog2 -m graylog2

mkdir -p /var/log/graylog2
chown graylog2:graylog2 /var/log/graylog2

mkdir -p $GRAY2_INST_PATH 
if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$GRAY2_TAR ]; then wget -P $REPOS_PATH $GRAY2_BASE_URL/$GRAY2_TAR; fi
	tar --strip-components=1 -xzvf $REPOS_PATH/$GRAY2_TAR -C $GRAY2_INST_PATH &> gray2.log
else
	curl $GRAY2_BASE_URL/$GRAY2_TAR | tar --strip-components=1 -xzv -C $GRAY2_INST_PATH &> gray2.log
fi

mkdir -p /etc/graylog2

cp $BASE_PATH/etc/graylog2/web-interface* /etc/graylog2
cp $BASE_PATH/etc/init/graylog2-web-interface.conf /etc/init

start graylog2-web-interface
