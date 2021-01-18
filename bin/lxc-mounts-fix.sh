#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

for e in $(lxc list -c ns --format csv | sort -r ); do
  co=$(echo $e | cut -d',' -f1)
  st=$(echo $e | cut -d',' -f2)
  if [ "$st" = "RUNNING" ]; then
    echo $co
    lxc shell $co << 'EOLXC' 2>&1 | grep -v "mesg: ttyname failed: Inappropriate ioctl for device"
      grep lxcfs /proc/mounts | cut -d " " -f2
      if grep lxcfs /proc/mounts; then
        umount $(grep lxcfs /proc/mounts | cut -d " " -f2)
        echo "umount done $(hostname)"
      else
        echo "noting to do"
      fi
      grep lxcfs /proc/mounts | cut -d " " -f2
EOLXC
  fi
done
