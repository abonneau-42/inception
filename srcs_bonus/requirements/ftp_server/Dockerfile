FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/vsftpd /var/run/vsftpd/empty /var/ftp /home/vsftpd

COPY vsftpd.conf /etc/vsftpd.conf
COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

EXPOSE 20 21 21100-21110

CMD ["/usr/local/bin/init.sh"]
