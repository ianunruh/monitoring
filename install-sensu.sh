#!/bin/bash
##
# Installs the Sensu omnibus package
#
# This package contains all of the different Sensu components. Use specific scripts
# to configure each component on different nodes.
##
set -eux

source env.sh

$BASE_PATH/install-sensu.sh

apt-get install -yq sensu
