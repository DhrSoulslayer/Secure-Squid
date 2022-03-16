FROM ubuntu:20.04

ENV http_proxy http://192.168.25.98:3128
ENV https_proxy http://192.168.25.98:3128

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install keyboard-configuration -y
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

ENV TZ="Europe/Amsterdam"

RUN apt install apt-transport-https lsb-release ca-certificates curl -y
RUN apt install ca-certificates -y

ADD squid-secure.crt /usr/local/share/ca-certificates/squid-secure.crt
RUN update-ca-certificates