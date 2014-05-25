#!/bin/bash
##
# Installs Sensu check plugins for common metrics
##
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

mkdir -p $TMP_PATH && cd $TMP_PATH

apt-get install -y git ruby ruby-dev build-essential sysstat

gem install sensu sensu-plugin --no-ri --no-rdoc

git clone git://github.com/sensu/sensu-community-plugins.git
cd sensu-community-plugins/plugins

cp system/interface-metrics.rb /etc/sensu/plugins
cp system/iostat-extended-metrics.rb /etc/sensu/plugins
cp system/load-metrics.rb /etc/sensu/plugins
cp system/memory-metrics.rb /etc/sensu/plugins
