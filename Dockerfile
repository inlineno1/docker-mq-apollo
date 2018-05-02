FROM inlineno1/centos7:0.1

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
ADD config/apollo.xml etc/

# port mapping
EXPOSE 61613 61614 61623 61624 61680 61681

CMD bin/apollo-broker run
