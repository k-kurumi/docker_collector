FROM ruby:latest

WORKDIR /data

RUN \
  apt-get update && \
  apt-get install -yq wget curl netcat && \
  rm -rf /var/lib/apt/lists/*

RUN \
  gem install fluentd --no-ri --no-rdoc && \
  fluent-gem install fluent-plugin-elasticsearch

COPY myecho.sh /data/myecho.sh
RUN chmod +x myecho.sh

# recv syslog
EXPOSE 51400

# recv forward
EXPOSE 24224

CMD ./myecho.sh
