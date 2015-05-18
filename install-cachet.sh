#!/bin/bash
##
# Installs Cachet, an open source service status page
#
# Seeds database with included fixtures, login with username `test@test.com` and password `test123`.
#
# Provides:
# - HTTP (TCP/4477)
#
# Dependencies:
# - MySQL (TCP/3306)
##
set -eux

source env.sh

apt-get install -yq git php5 php5-mcrypt php5-apcu php5-mysql php5-intl apache2 libapache2-mod-php5

php5enmod mcrypt

a2enmod rewrite

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

git clone https://github.com/cachethq/Cachet.git /opt/cachet
cd /opt/cachet

cp $BASE_PATH/opt/cachet/.env /opt/cachet/.env

composer install --no-dev -o --no-interaction

mysql <<EOF
  CREATE DATABASE cachet;
  CREATE USER cachet;
  GRANT ALL PRIVILEGES ON cachet.* TO cachet@'%' IDENTIFIED BY 'cachet';
  FLUSH PRIVILEGES;
EOF

php artisan migrate
php artisan db:seed

chown -R www-data:www-data /opt/cachet/storage

cp $BASE_PATH/etc/apache2/sites-enabled/cachet.conf /etc/apache2/sites-enabled/cachet.conf

service apache2 restart
