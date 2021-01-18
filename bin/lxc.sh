#!/usr/bin/env bash
# 2019-02, Bruno Grossniklaus, https://github.com/it-gro

if [ "$#" -ne 2 ]; then
  echo $0 pattern command
  echo e.g.: $0 cl-hpseb1 stop
  echo e.g.: $0 cl-hpsec1 stop
  exit 1
fi

pattern=".*$1.*"

for co in $(lxc list -cn --format csv "$pattern" | sort ); do
  echo "lxc $2 $co;"
done
