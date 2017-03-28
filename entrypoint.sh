#!/bin/bash

#start net-speeder
nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &

#start ssd
/usr/sbin/sshd -D


nohup python /src/ssr/shadowsocks/server.py "$@" >/dev/null 2>&1 &
