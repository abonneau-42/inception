FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV VERSION_MARIADB="1:10.11.14-0+deb12u2"

COPY launch.sh /launch.sh

RUN apt update && \
    apt install -y \
        mariadb-server=${VERSION_MARIADB} \
        mariadb-client=${VERSION_MARIADB} && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/lib/mysql /var/run/mysqld && \
    chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld && \
    chmod +x /launch.sh

CMD ["/launch.sh"]
