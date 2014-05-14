#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout forwarder.key -out forwarder.crt
