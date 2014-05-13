#!/bin/bash
BASE_PATH=`pwd`

useradd -b /opt oculus

mkdir -p /var/log/oculus
chown oculus:oculus /var/log/oculus

apt-get install -y ruby ruby-dev build-essential git openjdk-7-jdk libxml2-dev libxslt1-dev

gem install rake bundler --no-ri --no-rdoc

git clone git://github.com/etsy/oculus.git /opt/oculus

# Compile and install Oculus plugin for Elasticsearch
cp -R /opt/oculus/resources/elasticsearch-oculus-plugin /usr/share/elasticsearch
cd /usr/share/elasticsearch/elasticsearch-oculus-plugin
rake build
cp OculusPlugins.jar ../lib

service elasticsearch restart

# Configure Oculus
cp $BASE_PATH/opt/oculus/config/config.yml /opt/oculus/config

# Install dependencies for Resque workers and Sinatra web app
cd /opt/oculus
bundle install

# Configure Resque
cp $BASE_PATH/opt/oculus/Rakefile /opt/oculus

# Configure and start services
cp $BASE_PATH/etc/init/oculus* /etc/init

service oculus-resque start
service oculus-webapp start

# Configure cron job
cp $BASE_PATH/etc/cron.d/oculus-import /etc/cron.d
