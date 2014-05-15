#!/bin/bash
BASE_PATH=`pwd`
TMP_PATH=$BASE_PATH/tmp

if [ "$#" -ne "2" ]; then
  echo "Usage: ./install-redis-instance.sh NAME PORT"
  exit 1
fi

if [ ! -x /usr/local/bin/redis-server ]; then
  mkdir -p $TMP_PATH && cd $TMP_PATH

  apt-get install -y build-essential

  curl -O -L http://download.redis.io/releases/redis-2.8.9.tar.gz
  tar xf redis-2.8.9.tar.gz
  cd redis-2.8.9

  make
  make install
fi

if [ -z `getent passwd redis` ]; then
  useradd -s /bin/false -m -b /var/lib redis

  mkdir -p /etc/redis
  mkdir -p /var/log/redis

  chown redis:redis /var/log/redis
fi

mkdir -p /var/lib/redis/${1}
chown redis:redis /var/lib/redis/${1}

cat <<EOF > /etc/init/redis-${1}.conf
description "redis-${1}"

start on virtual-filesystems
stop on runlevel [06]

console log
setuid redis
setgid redis

exec /usr/local/bin/redis-server /etc/redis/redis-${1}.conf
EOF

cat <<EOF > /etc/redis/redis-${1}.conf
daemonize no
port ${2}
bind 0.0.0.0
dir /var/lib/redis/${1}
logfile /var/log/redis/redis-${1}.log
EOF

restart redis-${1}
