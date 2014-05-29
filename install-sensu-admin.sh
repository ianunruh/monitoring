#!/bin/bash
##
# Installs the Sensu admin UI
#
# Configured with the username `admin@example.com` and the password `secret`
#
# Provides:
# - HTTP (TCP/8090)
#
# Dependencies:
# - Apache with Passenger
# - MySQL
# - Sensu API
##
BASE_PATH=`pwd`

export RAILS_ENV=production

apt-get install -y ruby ruby-dev libmysqlclient-dev libsqlite3-dev
gem install bundler

mkdir -p /opt/sensu

git clone git://github.com/sensu/sensu-admin.git /opt/sensu/admin
chown -R www-data:www-data /opt/sensu/admin
cd /opt/sensu/admin
bundle install

# Prepare MySQL
Q0="CREATE DATABASE sensu;"
Q1="CREATE USER sensu IDENTIFIED BY 'sensu';"
Q2="GRANT ALL PRIVILEGES ON sensu.* TO sensu;"
Q3="FLUSH PRIVILEGES;"
Q4="SHOW GRANTS FOR sensu;"

mysql -e "${Q0}${Q1}${Q2}${Q3}${Q4}"

# Prepare Sensu admin database
cp $BASE_PATH/opt/sensu/admin/config/database.yml /opt/sensu/admin/config
rake db:migrate db:seed

# Prepare assets
rake assets:precompile

# Setup Passenger
cp $BASE_PATH/etc/apache2/sites-enabled/sensu-admin.conf /etc/apache2/sites-enabled
service apache2 reload
