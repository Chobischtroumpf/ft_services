FROM alpine

RUN apk update && apk add nginx \
&& apk add openrc \
&& apk add bash \
&& apk add openssl && mkdir -p /var/run/nginx \
&& apk add openssl openssh \
&& rm -rf /var/cache/apk/*

RUN adduser -D -g 'www' www \
&& mkdir /www && chown -R www:www /var/lib/nginx \
&& chown -R www:www /www

RUN mkdir /etc/nginx/ssl \
&& openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/www.pem -keyout /etc/nginx/ssl/www.key -subj "/C=BE/ST=Bxl/L=Bruxelles/O=s19/OU=adorigo/CN=ft_services"

RUN rm /etc/nginx/nginx.conf

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY id_rsa_key_ssh /etc/ssh/ssh_host_rsa_key
COPY sshd_config /etc/ssh/

COPY setup.sh .
COPY index.html /www/

RUN chmod +x setup.sh
RUN chmod 600 /etc/ssh/ssh_host_rsa_key

EXPOSE 80 443 1234
CMD ./setup.sh