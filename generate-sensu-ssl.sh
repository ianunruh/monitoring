#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

curl -O http://sensuapp.org/docs/0.12/tools/ssl_certs.tar
tar xf ssl_certs.tar
cd $TMP_PATH/ssl_certs

./ssl_certs.sh generate
