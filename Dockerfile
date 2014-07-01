FROM 		ubuntu:latest
MAINTAINER 	matt conroy <matt@conroy.cc>

RUN apt-get update -y
RUN apt-get install -y unzip telnet inetutils-ping

# Install Consul
ADD https://dl.bintray.com/mitchellh/consul/0.3.0_linux_amd64.zip /tmp/consul.zip
RUN cd /bin && unzip /tmp/consul.zip && chmod +x /bin/consul
RUN mkdir /config
RUN mkdir /data

ADD https://dl.bintray.com/mitchellh/consul/0.3.0_web_ui.zip /tmp/consul-ui.zip
RUN mkdir /ui
RUN cd /ui && unzip /tmp/consul-ui.zip

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53/udp

VOLUME ["/data"]

ENTRYPOINT ["/bin/consul", "agent", "-config-dir=/config", "-data-dir=/data", "-ui-dir=/ui/dist", "-client=0.0.0.0"]
CMD []
