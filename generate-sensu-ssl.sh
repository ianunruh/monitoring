#!/bin/bash
##
# Generates certificates for RabbitMQ brokers and clients
##
set -eux

source env.sh
BUILD_PATH=$BASE_PATH/build
BASE_URL_TAR=http://sensuapp.org/docs/0.12/tools
SSL_TAR=ssl_certs.tar
	
mkdir -p $BUILD_PATH
cd $BUILD_PATH

if [ "x$USE_CACHE" == "xtrue" ]; then
	if [ ! -e $REPOS_PATH/$SSL_TAR ]; then wget -P $REPOS_PATH $BASE_URL_TAR/$SSL_TAR; fi
	tar xf $REPOS_PATH/$SSL_TAR &> rabbitssl.log
else
	curl -O $BASE_URL_TAR
	tar xf $SSL_TAR &> rabbitssl.log
fi


cd ssl_certs

source ssl_certs.sh generate
