FROM centos:centos7

# yum update
RUN yum update -y

# timezone (Aisa/Seoul)
RUN cp -p /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN yum -y install rdate
RUN rdate -l time.bora.net

# wget
RUN yum -y install wget

# sudo
RUN yum -y install sudo

# java install
RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.rpm
RUN rpm -ivh jdk-8u172-linux-x64.rpm && rm jdk-8u172-linux-x64.rpm

# create user
RUN adduser apollo

# sudo nopassword
RUN echo 'apollo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# env JAVA_HOME
ENV JAVA_HOME /usr/java/latest 

# install apollo
WORKDIR /home/apollo
USER apollo
RUN wget -c http://apache.mirror.cdnetworks.com/activemq/activemq-apollo/1.7.1/apache-apollo-1.7.1-unix-distro.tar.gz && \
        tar -zxvf apache-apollo-1.7.1-unix-distro.tar.gz && \
        rm apache-apollo-1.7.1-unix-distro.tar.gz
RUN apache-apollo-1.7.1/bin/apollo create sample-broker
WORKDIR /home/apollo/sample-broker

EXPOSE 61613 61614 61623 61624 61680 61681

CMD bin/apollo-broker run
