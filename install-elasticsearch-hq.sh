#!/bin/bash
##
# Installs the Elastic HQ plugin
#
# Dependencies:
# - Elasticsearch (any version)
##
set -eux

cd /usr/share/elasticsearch && bin/plugin -s --install royrusso/elasticsearch-HQ
