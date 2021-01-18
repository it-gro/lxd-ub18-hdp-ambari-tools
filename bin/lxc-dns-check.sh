#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

cnt=$(systemd-resolve --status | grep lxd | wc -l)
if [ $cnt -ne 2 ]; then
  echo DNS config lost
  echo please run: sudo systemctl restart lxd-host-dns
  echo exiting ...
  exit 1
else
  echo "OK"
fi
