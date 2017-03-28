# ssr-with-net-speeder

FROM rastasheep/ubuntu-sshd
MAINTAINER malaohu <tua@live.cn>

# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
