#!/bin/bash
# setup an apt-get/pip cache to reduce traffic and speedup futur deployement

set -eux

source env.sh
PIP_CACHE=pip/cache
PIP_CACHE=pip/packages

if [ "x$1" == "xServer" ]; then
	apt-get -y --force-yes --quiet install apt-cacher-ng
	cp $BASE_PATH/etc/apt-cacher-ng/acng.conf /etc/apt-cacher-ng/acng.conf
	/etc/init.d/apt-cacher-ng restart
#	/usr/share/apt-cacher/apt-cacher-import.pl -l /var/cache/apt/archives
fi
#both server and client need this
echo 'Acquire::http { Proxy "http://VmCache:3142"; };' >> /etc/apt/apt.conf.d/02proxy
echo 'Acquire::http::Proxy { download.oracle.com DIRECT; };' >> /etc/apt/apt.conf.d/02proxy
if [ "x$2" == "xforcedIP" ]; then
	echo '#Forced IP cache' >> /etc/hosts
	if [ "x$3" == "x" ]; then
		echo "192.168.12.13	VmCache" >> /etc/hosts
	else
		echo "$3	VmCache" >> /etc/hosts
	fi
fi

if [ "x$1" == "xServer" ]; then
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -y
	
	mkdir -p $REPOS_PATH/$PIP_CACHE
	mkdir -p $REPOS_PATH/$PIP_PKG
else
	mkdir -p ~/.pip/
	echo "[global]
download-cache = $REPOS_PATH/$PIP_CACHE
find-links = $REPOS_PATH/$PIP_PKG

[install]
use-wheel = yes

[wheel]
wheel-dir = $REPOS_PATH/$PIP_PKG" >> ~/.pip/pip.conf
	echo "[easy_install]
find_links = $REPOS_PATH/$PIP_PKG" >> ~/.pydistutils.cfg
fi
