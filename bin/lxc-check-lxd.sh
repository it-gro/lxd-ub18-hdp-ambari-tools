#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro
# https://github.com/lxc/lxcfs/issues/295

# sudo journalctl -u snap.lxd.daemon -n 50
# sudo systemctl reload snap.lxd.daemon
# sudo journalctl -u snap.lxd.daemon -n 50

cnt=$(ps aux | grep [l]xcfs | wc -l)
if [ $cnt -lt 1 ]; then
  ps aux | grep [l]xcfs
  echo lxcfs not running?
  echo please run: sudo systemctl reload snap.lxd.daemon
  echo exiting ...
  exit 1
fi
