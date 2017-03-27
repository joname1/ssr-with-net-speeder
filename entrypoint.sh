#!/bin/bash
nohup /usr/local/bin/net_speeder eth0 "ip" >/dev/null 2>&1 &
#ping www.baidu.com -c 5

echo "- yes it start~"
/usr/bin/python /src/ssr/shadowsocks/server.py "$@"
