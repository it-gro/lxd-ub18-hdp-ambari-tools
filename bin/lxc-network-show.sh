#!/usr/bin/env bash
# 2019-03, Bruno Grossniklaus, https://github.com/it-gro

lx_if="$(lxc network list | grep lx | sort | grep bridge | cut -d'|' -f2 | tr -d ' ')"
lxc network show ${lx_if}
