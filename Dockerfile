FROM       ubuntu:14.04
MAINTAINER malaohu<tua@live.cn>


ENV SERVER_PORT 8989
ENV PASSWORD    RUYO.net
ENV METHOD      rc4-md5
ENV PROTOCOL    auth_sha1
ENV OBFS        http_simple


RUN apt-get update
#ssh
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN apt-get install -y python python-pip python-m2crypto libnet1-dev libpcap0.8-dev git gcc && \
apt-get clean

#net-speeder
RUN git clone https://github.com/snooda/net-speeder.git /src/net-speeder
WORKDIR /src/net-speeder
RUN chmod +x build.sh
RUN sh build.sh

RUN mv net_speeder /usr/local/bin/
RUN chmod +x /usr/local/bin/net_speeder

RUN git clone -b manyuser https://github.com/shadowsocksr/shadowsocksr.git /src/ssr

COPY start.sh /usr/local/bin/
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 80
EXPOSE 22
EXPOSE $SERVER_PORT/tcp
EXPOSE $SERVER_PORT/udp

RUN echo "Start Info : -s 0.0.0.0 -p $SERVER_PORT -k $PASSWORD -m $METHOD -o $OBFS -O $PROTOCOL" >> /src/log.log


CMD ["/usr/local/bin/entrypoint.sh","-s 0.0.0.0 -p $SERVER_PORT -k $PASSWORD -m $METHOD -o $OBFS -O $PROTOCOL"]
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
