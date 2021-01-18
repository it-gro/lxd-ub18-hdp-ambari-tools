#!/usr/bin/env bash
# 2020-06, Bruno Grossniklaus, https://github.com/it-gro

# ##################################################
lx_if="$(lxc network list | grep lx | sort | grep bridge | cut -d'|' -f2 | tr -d ' ')"
lx_ssh_ips="$(lxc network get ${lx_if} ipv4.address | cut -d/ -f1 | cut -d. -f1-3)"
lx_ssh_ips="${lx_ssh_ips}.*"

# ##################################################
test -d ~/.ssh        || mkdir  ~/.ssh
test -e ~/.ssh/config || touch ~/.ssh/config
if ! grep "${lx_ssh_ips}" ~/.ssh/config > /dev/null; then
	 cat <<EOF >> ~/.ssh/config
# 2020-06, Bruno Grossniklaus, https://github.com/it-gro
Host ${lx_ssh_ips}
  User         root
  IdentityFile ~/.ssh/id_rsa_lxd
Host cl-hp*
  User         root
  IdentityFile ~/.ssh/id_rsa_lxd
Host *
  IdentitiesOnly=yes
EOF
fi

# ##################################################
cat ~/.ssh/config
