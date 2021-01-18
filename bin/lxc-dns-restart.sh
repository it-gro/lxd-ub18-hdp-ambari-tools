#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

# /lib/systemd/system/lxd-host-dns.service

sudo systemctl restart lxd-host-dns
systemd-resolve --status | grep lxd
