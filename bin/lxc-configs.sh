#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

for lxid in $(lxc list ${cl_name} -cn --format csv); do
  echo $lxid
  lxc config show $lxid | grep -E 'limits|boot'
done

echo default profile
lxc profile show default | grep limit
