#!/usr/bin/env bash
# 2020-01, Bruno Grossniklaus, https://github.com/it-gro

if [ "$#" -ne 1 ]; then
  echo $0 pattern
  echo e.g.: $0 cl-hpelb1
  echo e.g.: $0 cl-hpsec1
  exit 1
fi

pattern=".*$1.*"
logins=""

for co in $(lxc list -cn --format csv "$pattern" | sort -r ); do
  logins="$logins root@$co"
done

if [ -z "$logins" ]; then
  echo pattern "'$1'" does not match anything
  exit 1
fi

echo cssh $logins

# if ! (ssh-add -l | grep ~/.ssh/id_rsa >/dev/null 2>&1) ; then
#   echo ~/.ssh/id_rsa not unlocked >&2
#   echo do:
#   echo "eval \$(ssh-agent)"
#   echo ssh-add ~/.ssh/id_rsa
#   exit 1
# fi

cssh $logins
