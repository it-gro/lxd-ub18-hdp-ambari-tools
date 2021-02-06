#!/usr/bin/env bash
# 2019-02, Bruno Grossniklaus, https://github.com/it-gro

if [ "$#" -ne 1 ]; then
  echo $0 pattern
  echo e.g.: $0 cl-hpelb1
  echo e.g.: $0 cl-hpelc1
  exit 1
fi

pattern=".*$1.*"

containers=""
for co in $(lxc list -cn --format csv "$pattern"); do
  if lxc list "$co" | grep RUNNING > /dev/null; then
    containers="${containers} ${co}.lxd"
  fi
done

echo $(dirname $0)/tmux-cssh.sh -u root ${containers}
$(dirname $0)/tmux-cssh.sh -u root ${containers}
