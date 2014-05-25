# Monitoring

Set of scripts to install various components needed to monitor every aspect of your infrastructure.

The big players in this stack are:

- Sensu (API, dashboard, server, client)
- Graphite (Carbon cache/relay, dashboard, Grafana)
- Logstash (indexer, shipper, Kibana)
- Kale (Oculus, Skyline)

The supporting persistence/transport providers are PostgreSQL, Redis, RabbitMQ, and Elasticsearch.

## Requirements

For a small infrastructure (~dozen nodes), you need about 2GB memory and 2 cores. If you install the Kale stack, this increases to 4GB memory and 4 cores. For larger infrastructures, or just higher availability, you'll want to start splitting up components to their own nodes.

## Usage

Use the following to install the entire monitoring stack on a single server.

```sh
apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

# Run ONLY one of the following scripts
./install-all-server.sh
./install-all-server-with-kale.sh
```

On your clients, you can use the following to install Logstash and Sensu clients.

```sh
apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

./install-all-client.sh
```

To start feeding metrics into the Sensu/Graphite/Kale pipeline immediately, use the following on the server.

```sh
cat <<EOF > /etc/sensu/conf.d/client.json
{
  "client": {
    "name": "YOUR_HOSTNAME",
    "address": "YOUR_PRIMARY_IP",
    "subscriptions": ["all"]
  }
}
EOF

./install-sensu-common-metrics.sh
```

### Logstash Forwarder

To use Logstash Forwarder, you first need to setup the Lumberjack input on your Logstash indexer.

```sh
./generate-lumberjack-ssl.sh

cp tmp/forwarder.key tmp/forwarder.crt /etc/logstash
cp etc/logstash/conf.d/10-input-lumberjack.conf /etc/logstash/conf.d

service logstash restart
```

Secure copy the certificate and key to the node you're shipping logs from. Then on that node, perform the following.

```sh
mkdir -p /etc/logstash-forwarder
mv forwarder.crt forwarder.key /etc/logstash-forwarder

apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

./install-logstash-forwarder.sh
```

On your indexer, you should start to see the logs flowing. If not, check the following logs.

- `/var/log/logstash-forwarder.log` on the shipper
- `/var/log/upstart/logstash-forwarder.log` on the shipper
- `/var/log/logstash/logstash.log` on the indexer
- `/var/log/upstart/logstash.log` on the indexer

### Graylog2

To install Graylog2 with the web interface and stream dashboard, simply use the following.

```sh
apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

./install-all-graylog2.sh
```
