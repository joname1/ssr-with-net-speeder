#!/bin/bash

#start net-speeder
nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &

#start ssd
/usr/sbin/sshd -D

echo "-- Start Info : $@" >> /src/log.log
echo "-- Start Info : $1" >> /src/log.log

nohup python /src/ssr/shadowsocks/server.py $1 >/dev/null 2>&1 &
