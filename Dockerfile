# ssr-with-net-speeder

FROM rastasheep/ubuntu-sshd
MAINTAINER malaohu <tua@live.cn>
RUN apt-get update && \
apt-get clean
RUN apt-get install -y python && \
apt-get clean
RUN apt-get install -y python-pip && \
apt-get clean
RUN apt-get install -y python-m2crypto && \
apt-get clean
RUN apt-get install -y libnet1-dev && \
apt-get clean
RUN apt-get install -y libpcap0.8-dev && \
apt-get clean
RUN apt-get install -y git && \
apt-get clean
RUN apt-get install -y gcc && \
apt-get clean

RUN git clone -b manyuser https://github.com/breakwa11/shadowsocks.git /src/ssr
RUN git clone https://github.com/snooda/net-speeder.git /src/net-speeder
WORKDIR /src/net-speeder
RUN chmod +x build.sh
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/net_speeder
# Configure container to run as an executable
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
