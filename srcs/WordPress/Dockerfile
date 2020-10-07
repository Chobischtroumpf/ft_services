FROM alpine:latest


RUN apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN mkdir -p /etc/telegraf

COPY ./telegraf.conf /etc/telegraf/telegraf.conf
RUN wget https://wordpress.org/latest.tar.gz

RUN tar -xvf latest.tar.gz
RUN rm latest.tar.gz
RUN mkdir /www
RUN mv wordpress/* /www
RUN mkdir -p /run/wordpress

COPY setup.sh .
RUN chmod +x ./setup.sh
COPY wp-config.php /www/wp-config.php

EXPOSE 5050

CMD sh setup.sh