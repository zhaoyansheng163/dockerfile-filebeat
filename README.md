#dockerfile-filebeat

Based on `stakater/base` which is based on `Ubuntu 16.04`

Run the latest container with:

`docker run stakater/filebeat:latest`

# Advanced

Build an image:
`docker build -t stakater/filebeat .`

Push an image:
`sudo docker push stakater/filebeat`

_Note_ you might have to login first before you can push the image to docker-hub `sudo docker login`

# Extra Info

Before starting `Filebeat`, you should look at the configuration options in the configuration file, for example `/etc/filebeat/filebeat.yml`

Tell filebeat container three things:

1. location (directory) containing logs to beat
2. logstash server host
3. logstash server port

e.g.

`docker run -d -v "/Users/rasheed/Documents/projects/pliro/ams/logs:/var/log/app" -e "LOGSTASH_HOST=192.168.99.100" -e "LOGSTASH_PORT=5044" stakater/filebeat`

### Run filebeat with debug level logging

To run filebeat with full debug logs...

```
/usr/bin/filebeat -e -d "*" -c /etc/filebeat/filebeat.yml
```

`filebeat` logs can be found at: `/var/log/mybeat/mybeat`

and level can be changed in filebeat.yml

### Filebeat & ElasticSearch

Before starting Filebeat for the first time, run this command (replace ELASTIC_SEARCH_HOST with the appropriate hostname) to load the default index template in Elasticsearch:

```
curl -XPUT 'http://{ELASTIC_SEARCH_HOST}:9200/_template/filebeat?pretty' -d@/{PATH_TO_THIS_FILE}/filebeat.template.json
```

And the response should be:

```
{
  "acknowledged" : true
}
```
