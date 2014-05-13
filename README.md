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

These scripts have been tested extensively on Ubuntu Server 14.04.

```sh
apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

# Run ONLY one of the following scripts
./install-all-server.sh
./install-all-server-with-kale.sh
```

There is a script for installing Sensu and Logstash on your clients too.

```sh
apt-get install -y git

git clone git://github.com/ianunruh/monitoring.git
cd monitoring

./install-all-client.sh
```
