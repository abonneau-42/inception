FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && \
    apt install -y mariadb-server mariadb-client gosu && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/mysql 
RUN chown -R mysql:mysql /var/lib/mysql

RUN mkdir -p /var/run/mysqld
RUN chown -R mysql:mysql /var/run/mysqld
RUN chmod 755 /var/run/mysqld


COPY launch.sh /launch.sh
RUN chmod +x /launch.sh

RUN sed -i 's/^bind-address\s*=.*$/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

CMD ["/launch.sh"]
