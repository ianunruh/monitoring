#!/bin/bash
##
# Installs Fluentd
#
# Provides:
# - Syslog TCP receiver (TCP/1514)
# - HTTP receiver (TCP/9880)
##
set -eux

source env.sh

# Install Ruby and the Fluentd gem
apt-get install -yq ruby ruby-dev libcurl4-openssl-dev
gem install fluentd fluent-plugin-elasticsearch --no-ri --no-rdoc

# Prepare user and directories
useradd -d /var/lib/fluentd -m fluentd
mkdir -p /etc/fluent/conf.d

cp -R $BASE_PATH/etc/fluent/* /etc/fluent

cp $BASE_PATH/etc/init/fluentd.conf /etc/init

start fluentd
