#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

function install_server() {
  cp $BASE_PATH/etc/sensu/conf.d/metrics.json /etc/sensu/conf.d
  service sensu-server restart
}

function install_client() {
  mkdir -p $TMP_PATH && cd $TMP_PATH

  apt-get install -y git ruby ruby-dev build-essential sysstat

  git clone git://github.com/sensu/sensu-community-plugins.git
  cd sensu-community-plugins/plugins

  cp system/interface-metrics.rb /etc/sensu/plugins
  cp system/iostat-extended-metrics.rb /etc/sensu/plugins
  cp system/load-metrics.rb /etc/sensu/plugins
  cp system/memory-metrics.rb /etc/sensu/plugins
}

case "$1" in
  server)
    install_server
    ;;
  client)
    install_client
    ;;
  *)
    install_client
    install_server
    ;;
esac
