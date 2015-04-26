#!/bin/bash

env | sort

# kibana_1        | ELASTICSEARCH_1_ENV_ELASTICSEARCH_VERSION=1.5.1
# kibana_1        | ELASTICSEARCH_1_ENV_JAVA_DEBIAN_VERSION=7u75-2.5.4-2
# kibana_1        | ELASTICSEARCH_1_ENV_JAVA_VERSION=7u75
# kibana_1        | ELASTICSEARCH_1_ENV_LANG=C.UTF-8
# kibana_1        | ELASTICSEARCH_1_NAME=/elasticsearch_kibana_1/elasticsearch_1
# kibana_1        | ELASTICSEARCH_1_PORT=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP_PORT=9200
# kibana_1        | ELASTICSEARCH_1_PORT_9200_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP=tcp://172.17.2.141:9300
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP_PORT=9300
# kibana_1        | ELASTICSEARCH_1_PORT_9300_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_ELASTICSEARCH_VERSION=1.5.1
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_JAVA_DEBIAN_VERSION=7u75-2.5.4-2
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_JAVA_VERSION=7u75
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_ENV_LANG=C.UTF-8
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_NAME=/elasticsearch_kibana_1/elasticsearch_elasticsearch_1
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP_PORT=9200
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9200_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP=tcp://172.17.2.141:9300
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP_PORT=9300
# kibana_1        | ELASTICSEARCH_ELASTICSEARCH_1_PORT_9300_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_ENV_ELASTICSEARCH_VERSION=1.5.1
# kibana_1        | ELASTICSEARCH_ENV_JAVA_DEBIAN_VERSION=7u75-2.5.4-2
# kibana_1        | ELASTICSEARCH_ENV_JAVA_VERSION=7u75
# kibana_1        | ELASTICSEARCH_ENV_LANG=C.UTF-8
# kibana_1        | ELASTICSEARCH_NAME=/elasticsearch_kibana_1/elasticsearch
# kibana_1        | ELASTICSEARCH_PORT=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP=tcp://172.17.2.141:9200
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP_PORT=9200
# kibana_1        | ELASTICSEARCH_PORT_9200_TCP_PROTO=tcp
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP=tcp://172.17.2.141:9300
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP_ADDR=172.17.2.141
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP_PORT=9300
# kibana_1        | ELASTICSEARCH_PORT_9300_TCP_PROTO=tcp

cat << __EOL__ > /data/fluentd.conf
<source>
  @type forward
  @id forward_input
  @label @raw
</source>

<source>
  @type syslog
  @id cf
  @label @syslog
  tag cf
  port 51400
  bind 0.0.0.0
#  protocol_type tcp
</source>

<label @raw>
<match **>
  @type copy

  <store>
    @type stdout
  </store>

</match>
</label>

<label @syslog>
<match **>
  @type copy

  <store>
    @type stdout
  </store>

  <store>
    @type elasticsearch
    type_name fluentd
    tag_key @log_name
    include_tag_key true
    logstash_format true
    host ${ELASTICSEARCH_PORT_9300_TCP_ADDR}
    port ${ELASTICSEARCH_PORT_9200_TCP_PORT}
    flush_interval 10s
  </store>

</match>
</label>
__EOL__


fluentd --config /data/fluentd.conf


#echo "start nc server"
#while true; do ( echo "HTTP/1.0 200 Ok"; echo; echo "Hello World" ) | nc -l 8000; [ $? != 0 ] && break; done
