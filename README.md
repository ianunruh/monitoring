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

### Vagrant

If you have Vagrant installed, simply run `vagrant up`. This creates two boxes:

- `monitoring` on 192.168.12.10
- `app1` on 192.168.12.11

The `monitoring` box provides the following:

- [Kibana](http://192.168.12.10/kibana)
- [Grafana](http://192.168.12.10/grafana)
- [Skyline](http://192.168.12.10:1500) (best viewed in Chrome)
- [Oculus](http://192.168.12.10:3000)
- [Flapjack](http://192.168.12.10:3080)
- [Sensu dashboard](http://192.168.12.10:8080)
- [ElasticHQ](http://192.168.12.10:9200/_plugin/HQ)

For client nodes, it provides:

- AMQP (TCP/5672)
- AMQP over SSL (TCP/5671)
- Redis (TCP/6379)
- Statsd (UDP/8125)
- Lumberjack receiver (TCP/5043)
- Graphite line receiver (TCP/2013)
- Graphite Pickle receiver (TCP/2014)

### Graylog2

To install Graylog2 with the web interface and stream dashboard, simply use the following.

```sh
apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

./install-all-graylog2.sh
```

Note that Graylog2 requires its own Elasticsearch cluster, so you **should not** use this script on the same node as other installation scripts.
