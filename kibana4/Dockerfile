FROM ubuntu:14.04

# set locale
RUN locale-gen en_US.UTF-8
RUN update-locale LANG=en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV LC_ALL en_US.UTF-8

ENV KIBANA_VERSION=4.0.2

WORKDIR /data

RUN \
  apt-get update && \
  apt-get install -yq wget curl && \
  rm -rf /var/lib/apt/lists/*

RUN \
  wget https://download.elastic.co/kibana/kibana/kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
  tar zxvf kibana-${KIBANA_VERSION}-linux-x64.tar.gz && \
  rm kibana-${KIBANA_VERSION}-linux-x64.tar.gz

COPY myecho.sh /data/myecho.sh
RUN chmod +x myecho.sh

EXPOSE 5601

CMD ./myecho.sh
