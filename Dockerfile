FROM ubuntu:14.04
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&  \
    apt-get install -y  software-properties-common && \
    apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    add-apt-repository 'deb http://mirrors.n-ix.net/mariadb/repo/10.0/ubuntu trusty main' && \
    apt-get update && \
    apt-get install -y mariadb-galera-server galera

COPY my.cnf /etc/mysql/my.cnf
COPY mysqld.sh /mysqld.sh

RUN chmod 555 /mysqld.sh

# Define mountable directories.
VOLUME ["/var/lib/mysql"]

# Define default command.
ENTRYPOINT ["/mysqld.sh"]
