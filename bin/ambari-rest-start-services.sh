#!/usr/bin/env bash
# 2020-06, Bruno Grossniklaus, https://github.com/it-gro

if [ "$#" -ne 1 ]; then
  echo $0 cluster
  echo e.g.: $0 cl-hpelb1
  echo e.g.: $0 cl-hpelc1
  exit 1
fi

cluster="$1"
cluster_name=$(echo ${cluster} | tr -d -)
ambari_host=${cluster}-10-am-01-lx-ub18.lxd
ambari_user=admin
ambari_password=admin

services=""
services="${services} ZOOKEEPER      "
services="${services} HDFS           "
services="${services} YARN           "
services="${services} MAPREDUCE2     "
services="${services} HIVE           "
services="${services} SPARK2         "
services="${services} ZEPPELIN       "
services="${services} KAFKA          "
services="${services} AMBARI_METRICS "
services="${services} SMARTSENSE     "

for s in ${services}; do
  curl -H "X-Requested-By: ambari" -u $ambari_user:$ambari_password -X PUT \
    -d '{"RequestInfo": {"context" :"Starting service '${s}' via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' \
    http://${ambari_host}:8080/api/v1/clusters/${cluster_name}/services/${s}
done
