FROM ubuntu:20.04

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt-get install keyboard-configuration -y
RUN unlink /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime

####################
#Configure Timezone#
####################
RUN apt-get install -yq tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
ENV TZ="Europe/Amsterdam"

##########################
#Configure apt repository#
##########################
RUN mv /etc/apt/sources.list /etc/apt/sources.list.origineel
RUN touch /etc/apt/sources.list
RUN echo "deb http://nl.archive.ubuntu.com/ubuntu/ focal main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://nl.archive.ubuntu.com/ubuntu/ focal-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://nl.archive.ubuntu.com/ubuntu/ focal-updates restricted universe multiverse " >> /etc/apt/sources.list
RUN echo "deb http://nl.archive.ubuntu.com/ubuntu/ focal-proposed restricted universe multiverse " >> /etc/apt/sources.list
RUN echo "deb http://nl.archive.ubuntu.com/ubuntu/ focal-backports restricted universe multiverse " >> /etc/apt/sources.list
RUN apt-get update

RUN apt install gnupg -y
RUN apt install apt-transport-https lsb-release ca-certificates curl build-essential libssl-dev wget -y

########################
#Add enviroment Root CA#
########################
ADD Root-CA.crt /usr/local/share/ca-certificates/Root-CA.crt.crt
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
RUN /usr/sbin/squid -z
