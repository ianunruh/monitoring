#!/bin/bash
##
# Installs Heka, a tool from Mozilla for high-performance data gathering, analysis,
# monitoring and reporting.
##
set -eux

source env.sh
HEKA_BASE_URL=https://github.com/mozilla-services/heka/releases/download/v${HEKA_VERSION}
HEKA_DEB=heka_${HEKA_VERSION}_amd64.deb
	
cd /tmp

if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$HEKA_DEB ]; then wget -P $REPOS_PATH $HEKA_BASE_URL/$HEKA_DEB; fi
	dpkg -i $REPOS_PATH/$HEKA_DEB
else
	curl -sOL $HEKA_BASE_URL/$HEKA_DEB
	dpkg -i $HEKA_DEB
fi


useradd -d /var/cache/hekad -m hekad

mkdir -p /etc/hekad/conf.d

cp $BASE_PATH/etc/init/hekad.conf /etc/init
