#!/usr/bin/env bash
# 2019-02, Bruno Grossniklaus, https://github.com/it-gro

N=3

if [ "$#" -ne 1 ]; then
  echo $0 pattern
  echo e.g.: $0 cl-hpelb1
  echo e.g.: $0 cl-hpsec1
  echo e.g.: $0 sb-db
  exit 1
fi

pattern=".*$1.*"

for co in $(lxc list -cn --format csv "$pattern" | sort -r ); do
  (
    echo lxc stopping $co ...
    lxc stop $co
    echo $co stopped
  ) &

  if [[ $(jobs -r -p | wc -l) -ge $N ]]; then
    wait -n
  fi
done
wait

lxc list
