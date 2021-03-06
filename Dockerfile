FROM giantmonkey/debian:jessie-amd64
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

COPY mariadb.list /etc/apt/sources.list.d/
RUN chown root: /etc/apt/sources.list.d/mariadb.list
RUN adduser --uid 200 --disabled-password --gecos "MySQL Server" --home /var/lib/mysql --shell /bin/false mysql
RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
    apt-get update && \
    apt-get install -y mariadb-server

COPY my.cnf /etc/mysql/my.cnf
COPY mysqld.sh /mysqld.sh


RUN chmod 555 /mysqld.sh

# Define mountable directories.
VOLUME ["/var/lib/mysql"]

# Define default command.
ENTRYPOINT ["/mysqld.sh"]
