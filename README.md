# docker_collector

bosh-liteなどのログをkibanaで表示するためのdocker一式です。

次の3コンテナからなります。
- fluentd
- elasticsearch
- kibana

## INSTALL

```
pip install -r requirements.txt
```


## USAGE

ビルドと起動
```
docker-compose up
```
