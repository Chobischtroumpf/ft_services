FROM alpine

RUN apk update && apk upgrade && apk add bash \
&& apk add php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

COPY phpMyAdmin-4.9.0.1-english.tar.gz /tmp/phpMyAdmin-4.9.0.1-english.tar.gz
RUN tar xfv /tmp/phpMyAdmin-4.9.0.1-english.tar.gz \
&& mv phpMyAdmin-4.9.0.1-english /www \
&& rm -rf /var/cache/apk/*
  
COPY config.inc.php /www/config.inc.php
COPY setup.sh .
RUN chmod +x setup.sh

EXPOSE 5000

CMD ./setup.sh