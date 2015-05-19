#!/bin/bash
##
# Generates a single certificate and key for the Lumberjack protocol
##
set -eux

source env.sh
BUILD_PATH=$BASE_PATH/build

mkdir -p $BUILD_PATH
cd $BUILD_PATH

openssl req -x509 -batch -days 365 -nodes -newkey rsa:2048 \
  -keyout client-key.pem -out client-cert.pem

openssl req -x509 -days 365 -nodes -newkey rsa:2048 \
  -keyout server-key.pem -out server-cert.pem \
  -config $BASE_PATH/lumberjack-ssl.cnf
