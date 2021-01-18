#!/usr/bin/env bash
# 2019-02, Bruno Grossniklaus, https://github.com/it-gro

N=3

if [ "$#" -ne 1 ]; then
  echo $0 pattern
  echo e.g.: $0 cl-hpseb1
  echo e.g.: $0 cl-hpsec1
  exit 1
fi

pattern=".*$1.*"

for co in $(lxc list -cn --format csv "$pattern" | sort -r ); do
  (
    echo lxc starting $co ...
    lxc start $co
    echo $co started
  ) &

  if [[ $(jobs -r -p | wc -l) -ge $N ]]; then
    wait -n
  fi
done
wait

lxc list "$pattern"
