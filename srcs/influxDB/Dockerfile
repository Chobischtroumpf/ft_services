FROM alpine:latest

RUN apk update && apk add influxdb --no-cache
RUN apk add telegraf --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

RUN mkdir -p /etc/telegraf

COPY ./telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 8086

COPY ./init-influxdb.sh /init-influxdb.sh
RUN chmod +x /init-influxdb.sh
CMD sh /init-influxdb.sh