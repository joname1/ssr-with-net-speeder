#!/bin/bash

#start net-speeder
nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &

#start ssd
/usr/sbin/sshd -D

#start ss
nohup python /src/ssr/server.py -s 0.0.0.0 -p $SERVER_PORT -k $PASSWORD -m $METHOD -O $PROTOCOL -o $OBFS -t 300
