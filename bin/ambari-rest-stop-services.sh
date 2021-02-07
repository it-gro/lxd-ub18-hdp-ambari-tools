#!/usr/bin/env bash
# 2020-06, Bruno Grossniklaus, https://github.com/it-gro

if [ "$#" -ne 1 ]; then
  echo $0 cluster
  echo e.g.: $0 cl-hpelb1
  echo e.g.: $0 cl-hpsec1
  exit 1
fi

cluster="$1"
cluster_name=$(echo ${cluster} | tr -d -)
ambari_host=${cluster}-10-am-01-lx-ub18.lxd
ambari_user=admin
ambari_password=admin

services=""
services="${services} SMARTSENSE     "
services="${services} AMBARI_METRICS "
services="${services} KAFKA          "
services="${services} ZEPPELIN       "
services="${services} SPARK2         "
services="${services} HIVE           "
services="${services} MAPREDUCE2     "
services="${services} YARN           "
services="${services} HDFS           "
services="${services} ZOOKEEPER      "

for s in ${services}; do
  curl -H "X-Requested-By: ambari" -u $ambari_user:$ambari_password -X PUT \
    -d '{"RequestInfo": {"context" :"Stopping service '${s}' via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' \
    http://${ambari_host}:8080/api/v1/clusters/${cluster_name}/services/${s}
done
