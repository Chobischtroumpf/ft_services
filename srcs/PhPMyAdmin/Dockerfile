FROM alpine:latest

RUN apk update && apk upgrade && apk add bash \
&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN mkdir -p /etc/telegraf

COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY phpMyAdmin-4.9.0.1-english.tar.gz /tmp/phpMyAdmin-4.9.0.1-english.tar.gz
RUN tar xfv /tmp/phpMyAdmin-4.9.0.1-english.tar.gz \
&& mv phpMyAdmin-4.9.0.1-english /www \
&& rm -rf /var/cache/apk/*

RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

COPY config.inc.php /www/config.inc.php
COPY ./telegraf.conf /etc/telegraf/telegraf.conf
COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 5000

CMD ./setup.sh