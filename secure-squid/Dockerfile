FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends tzdata
RUN apt-get install keyboard-configuration -y
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
ENV TZ="Europe/Amsterdam"

RUN apt install build-essential apt-transport-https lsb-release ca-certificates curl -y
RUN apt install ca-certificates -y
RUN apt install wget -y

########################
#Add enviroment Root CA#
########################
ADD Root-CA.crt /usr/local/share/ca-certificates/Root-CA.crt
RUN update-ca-certificates

###############
#Squid Section#
###############
#Add Squid5 repository
RUN wget -qO - https://packages.diladele.com/diladele_pub.asc | apt-key add -
RUN echo "deb https://squid52.diladele.com/ubuntu/ focal main" > /etc/apt/sources.list.d/squid52.diladele.com.list
#Install Squid5
RUN apt-get update && apt-get install -y squid-common squid-openssl squidclient libecap3 libecap3-dev
#Configure Squid5
RUN /usr/lib/squid/security_file_certgen -c -s /var/log/squid/ssl_db -M 40MB
RUN chmod -R 777 /var/log/squid/
RUN mv /etc/squid/squid.conf /etc/squid/squid.conf.origineel
ADD ./squid/squid.conf /etc/squid/squid.conf
RUN /usr/sbin/squid -z

#C-ICAP Install
RUN apt install c-icap -y
RUN mv /etc/c-icap/c-icap.conf /etc/c-icap/c-icap.conf.origineel
ADD ./c-icap/c-icap.conf /etc/c-icap/c-icap.conf
