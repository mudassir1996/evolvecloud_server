FROM ubuntu:20.04
COPY server_install.sh /root/server_install.sh
RUN chmod +x /root/server_install.sh