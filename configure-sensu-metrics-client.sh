#!/bin/bash
##
# Installs Sensu check plugins for common metrics
##
set -eux

cd /tmp

apt-get install -yq git ruby ruby-dev build-essential sysstat

gem install sensu-plugin --no-ri --no-rdoc

git clone git://github.com/sensu/sensu-community-plugins.git
cd sensu-community-plugins/plugins

cp system/interface-metrics.rb /etc/sensu/plugins
cp system/iostat-extended-metrics.rb /etc/sensu/plugins
cp system/load-metrics.rb /etc/sensu/plugins
cp system/memory-metrics.rb /etc/sensu/plugins
