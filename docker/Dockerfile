FROM ubuntu:12.04
MAINTAINER Maestrano <it@maestrano.com>

RUN apt-get update && apt-get install -y apache2 openssh-server mysql-server

# Configure MySQL
ADD mysql/my.cfn /etc/mysql/my.cnf
RUN chmod 700 /etc/mysql/my.cnf

RUN /usr/sbin/mysqld & \
    sleep 5s &&\
    echo "GRANT ALL ON *.* TO admin@'%' IDENTIFIED BY 'changeme' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql

EXPOSE 3306
