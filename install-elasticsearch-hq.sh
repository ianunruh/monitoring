#!/bin/bash
##
# Installs the Elastic HQ plugin
#
# Dependencies:
# - Elasticsearch (any version)
##
cd /usr/share/elasticsearch && bin/plugin -install royrusso/elasticsearch-HQ
