FROM alpine:latest
RUN apk update \
	&& apk upgrade \
	&& apk add nginx \
	&& apk add openssl openssh

RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN sed -i -e "s/#Port 22/Port 2222/g" /etc/ssh/sshd_config
RUN mkdir /run/nginx
RUN mkdir -p /www
ADD index.html /www/index.html
RUN chmod 666 /www/index.html
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=BE/ST=Bxl/L=Bruxelles/O=s19/OU=adorigo/CN=ft_services"
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -t rsa -N ''

COPY user.sh /tmp/user.sh
COPY setup.sh /setup.sh
RUN sh /tmp/user.sh

RUN mkdir -p /etc/telegraf
COPY ./telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 80 443 2222

CMD /usr/sbin/sshd ;  sh /setup.sh ;