FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# RUN apt update && \
#     apt install -y mariadb-server mariadb-client gosu && \
#     rm -rf /var/lib/apt/lists/*

# RUN mkdir -p /var/lib/mysql 
# RUN chown -R mysql:mysql /var/lib/mysql

# RUN mkdir -p /var/run/mysqld
# RUN chown -R mysql:mysql /var/run/mysqld
# RUN chmod 755 /var/run/mysqld


# COPY launch.sh /launch.sh
# RUN chmod +x /launch.sh

# RUN sed -i 's/^bind-address\s*=.*$/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

# ARG VERSION_MARIADB
# ARG VERSION_GOSU

ENV VERSION_MARIADB="1:10.11.14-0+deb12u2"
ENV VERSION_GOSU="1.14-1+b10"

COPY launch.sh /launch.sh

RUN apt update && \
    apt install -y \
        mariadb-server=${VERSION_MARIADB} \
        mariadb-client=${VERSION_MARIADB} \
        gosu=${VERSION_GOSU} && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld && \
    chmod +x /launch.sh

CMD ["/launch.sh"]
