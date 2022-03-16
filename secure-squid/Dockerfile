FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt install -yq --no-install-recommends tzdata
RUN apt-get install keyboard-configuration -y
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
ENV TZ="Europe/Amsterdam"

RUN apt install build-essential apt-transport-https lsb-release ca-certificates curl libssl-dev devscripts fakeroot debhelper dh-autoreconf dh-apparmor cdbs -y
RUN apt install ca-certificates -y
RUN apt install wget -y
RUN mkdir /opt/sources
########################
#Add enviroment Root CA#
########################
ADD Root-CA.crt /usr/local/share/ca-certificates/Root-CA.crt
RUN update-ca-certificates

##############################
#SquidClamAV & C-ICAP Install#
##############################
RUN apt-get -y install clamav
RUN apt-get -y install clamav-daemon
RUN apt-get -y install c-icap
RUN apt-get -y install libicapapi-dev
RUN mkdir /opt/sources/SquidClamAV
RUN cd /opt/sources/SquidClamAV
RUN wget https://sourceforge.net/projects/squidclamav/files/squidclamav/7.1/squidclamav-7.1.tar.gz 
RUN gunzip squidclamav-7.1.tar.gz 
RUN tar -xvf squidclamav-7.1.tar
RUN cd squidclamav-7.1 && ./configure --with-c-icap=/usr && make && make install

#Configure C-ICAP
RUN mv /etc/default/c-icap /etc/default/c-icap.origineel
ADD ./c-icap/c-icap.default /etc/default/c-icap
RUN mv /etc/c-icap/c-icap.conf /etc/c-icap/c-icap.conf.origineel
ADD ./c-icap/c-icap.conf /etc/c-icap/c-icap.conf


#Configure SquidClamAV
RUN mv /etc/c-icap/squidclamav.conf /etc/c-icap/squidclamav.conf.origineel
ADD ./squidclamav/squidclamav.conf /etc/c-icap/squidclamav.conf

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
RUN mkdir /opt/squid/
ADD Squid-SUB-CA.crt /opt/squid/squid-ca-full.pem
RUN /usr/sbin/squid -z
RUN /usr/sbin/squid 


