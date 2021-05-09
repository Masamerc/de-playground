# Fluentd & Elasticsearch Demo with Docker

---

`docker-compose.yaml`

- `web` for http logs which will be forwarded to fluentd
- `fluentd` container that routes logs from `web` to elasticsearch as well as sends any http requests to elasticsearch
- `elasticsearch` & `kibana` for collecting analyzing logs

```docker
version: "3"
services:
    web:
        image: httpd
        ports:
            - "80:80"
        logging:
            driver: "fluentd"
            options:
                fluentd-address: localhost:24224
                tag: httpd.access
        networks: 
            - esfluentd
  
    fluentd:
        build: ./fluentd
        volumes:
            - ./fluentd/conf:/fluentd/etc
        ports:
            - "24224:24224"
            - "9880:9880"
            - "24224:24224/udp"
        networks: 
            - esfluentd
  
    elasticsearch:
        image: docker.elastic.co/elasticsearch/elasticsearch:7.12.1
        environment:
            - "discovery.type=single-node"
        expose:
            - "9200"
        ports:
            - "9200:9200"
        networks: 
            - esfluentd
  
    kibana:
        image: docker.elastic.co/kibana/kibana:7.12.1
        ports:
            - "5601:5601"
        networks: 
            - esfluentd

networks: 
    esfluentd:
```

`fluentd/conf/fluent.conf`

- forwards logs on port 24224
- sends data that arrive on port 9880 via http

```docker
# fluentd/conf/fluent.conf

<source>
  @type forward
  port 24224
  bind 0.0.0.0
</source>

<source>
  @type http
  port 9880
  bind 0.0.0.0
</source>

<match *.**>
  @type copy

  <store>
    @type elasticsearch
    host elasticsearch
    port 9200
    logstash_format true
    logstash_prefix fluentd
    logstash_dateformat %Y%m%d
    include_tag_key true
    type_name access_log
    tag_key @log_name
    flush_interval 1s
  </store>

  <store>
    @type stdout
  </store>
</match>
```

`flunetd/Dockerfile`

```docker
# fluentd/Dockerfile

FROM fluent/fluentd:v1.12.0-debian-1.0
USER root
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-document", "--version", "4.3.3"]
USER fluent
```