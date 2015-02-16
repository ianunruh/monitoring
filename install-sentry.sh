#!/bin/bash
##
# Installs the Sentry event logging and aggregation platform
#
# Configured with the username `admin` and the password `secret`.
#
# Provides:
# - HTTP (TCP/9000)
#
# Dependencies:
# - Memcached (TCP/11211)
# - PostgreSQL (TCP/5432)
# - Redis (TCP/6379)
##
set -eux

source env.sh
SENTRY_PATH=/usr/share/sentry
SENTRY_CONFIG=/etc/sentry/settings.py

apt-get update -q
apt-get install -yq python-pip python-dev libxml2-dev libxslt1-dev libpq-dev supervisor


pip install virtualenv
if [ -e ~/.pydistutils.cfg ]; then mv  ~/.pydistutils.cfg ~/.pydistutils.cfg.bak; fi

virtualenv $SENTRY_PATH
set +o nounset #https://github.com/pypa/virtualenv/issues/150
source $SENTRY_PATH/bin/activate
set -o nounset

pip install sentry[postgres] sentry-top

sudo -i -u postgres psql <<EOF
  CREATE USER sentry WITH PASSWORD 'sekret';
  CREATE DATABASE sentry OWNER sentry;
EOF

mkdir -p /etc/sentry

cp $BASE_PATH/usr/share/sentry/initial_data.json $SENTRY_PATH
cp $BASE_PATH/etc/sentry/settings.py /etc/sentry

sentry --config=$SENTRY_CONFIG upgrade --noinput

cp $BASE_PATH/etc/supervisor/conf.d/sentry.conf /etc/supervisor/conf.d

supervisorctl reload
supervisorctl status

cp $BASE_PATH/usr/local/bin/sentry-top /usr/local/bin
