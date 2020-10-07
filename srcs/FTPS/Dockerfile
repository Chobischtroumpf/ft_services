FROM alpine:latest

ARG USER=user
ARG PASS=password

RUN echo "@testing http://dl-3.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories
RUN apk update && apk add openssl pure-ftpd@testing telegraf@testing

RUN mkdir -p /ftps/$USER

RUN adduser -D -g '' --home /ftps/$USER $USER; \
    echo "$USER:$PASS" | chpasswd

RUN chown -R $USER:$USER /ftps/$USER

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/pure-ftpd.pem -out /etc/ssl/private/pure-ftpd.pem -subj "/C=BE/ST=Bxl/L=Bruxelles/O=s19/OU=adorigo/CN=ft_services"

RUN chmod 600 /etc/ssl/private/pure-ftpd.pem

# COPY vsftpd.conf /etc/vsftpd/vsftpd.conf
# COPY start_vsftpd.sh /
# RUN chmod +x start_vsftpd.sh

RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 21 30020 30021 30022 30023

CMD nohup sh -c "(telegraf;pkill pure-ftpd)&"; /usr/sbin/pure-ftpd -j -Y 2 -I 20 -p 30020:30023 -P "192.168.99.121"