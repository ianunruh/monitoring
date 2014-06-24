# Monitoring

Set of scripts for evaluating various monitoring stacks (log aggregation, metrics collection, metrics correlation, etc.)

Currently, the following stacks can be installed.

- [Sensu](http://sensuapp.org/) (including [Uchiwa](https://github.com/palourde/uchiwa) and [Sensu Admin](https://github.com/sensu/sensu-admin) dashboards)
- [Flapjack](http://flapjack.io/)
- [Logstash](http://logstash.net/) (with [Elasticsearch](http://www.elasticsearch.org/overview/elasticsearch/)/[Kibana](http://www.elasticsearch.org/overview/kibana/) and [logstash-forwarder](https://github.com/elasticsearch/logstash-forwarder))
- Etsy's [Kale](http://codeascraft.com/2013/06/11/introducing-kale/) stack ([Skyline](https://github.com/etsy/skyline) for anomaly detection, [Oculus](https://github.com/etsy/oculus) for correlation)
- [Heka](https://hekad.readthedocs.org/en/latest/)
- [Sentry](http://sentry.readthedocs.org/en/latest/)
- [Graylog2](http://graylog2.org/) (including standard and [streaming](https://github.com/Graylog2/graylog2-stream-dashboard) dashboards)
- [Statsd](https://github.com/etsy/statsd/)
- [Graphite](https://graphite.readthedocs.org/en/latest/) (with [Grafana](http://grafana.org/))

## Requirements

For a small infrastructure (~dozen nodes), you need about 2GB memory and 2 cores. If you install the Kale stack, this increases to 4GB memory and 4 cores. For larger infrastructures, or just higher availability, you'll want to start splitting up components to their own nodes.

## Usage

Two Vagrant boxes are provided with this script.

- `monitoring` on 192.168.12.10
- `app1` on 192.168.12.11

The `monitoring` box is intended for the different monitoring stacks, while `app1` is intended to try out clients.

### Sensu/Logstash/Skyline

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

### Sentry

This package provides scripts to install Sentry with the following configuration.

- memcached
- supervisord
- Redis as work queue, update buffer and TSDB
- PostgreSQL as node store

You can use the following to perform the installation.

```sh
vagrant up --no-provision monitoring
vagrant ssh monitoring
```

```sh
sudo -i
cd /vagrant && ./install-all-sentry.sh
```

After installation, the [Sentry web interface](http://192.168.12.10:9000) should be available. Login with the username `admin` and the password `secret`.

### Graylog2

To install Graylog2 with the web interface and stream dashboard, simply use the following.

```sh
vagrant up --no-provision monitoring
vagrant ssh monitoring
```

```sh
sudo -i
cd /vagrant && ./install-all-graylog2.sh
```

After installation, you can access one of the following resources. Use the username `admin` and the passwod `password`.

- [Web interface](http://192.168.12.10:8400/)
- [Streaming dashboard](http://192.168.12.10/graylog2-streaming-dashboard)

Note that Graylog2 requires its own Elasticsearch cluster, so **do not** use this script on the same node as other installation scripts.

### Heka

Heka was created by Mozilla as a lighter alternative to Logstash. This package provides scripts for installing a Heka router that outputs to Elasticsearch.

```sh
vagrant up --no-provision monitoring
vagrant ssh monitoring
```

```sh
sudo -i
cd /vagrant && ./install-all-heka.sh
```

This package provides the following:

- [Heka dashboard](http://192.168.12.10:4352/)
- [Kibana](http://192.168.12.10/kibana/)
- [ElasticHQ](http://192.168.12.10:9200/_plugin/HQ/)
- Heka Protobuf input on `192.168.12.10` at TCP port 4352
