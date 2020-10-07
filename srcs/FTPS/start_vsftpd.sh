NAME=user
PASS=password

mkdir -p /ftp/$NAME

echo -e "$PASS\n$PASS" | adduser -h /ftp/$NAME -s /sbin/nologin -u 1000 $NAME
chown $NAME:$NAME /ftp/$NAME

unset NAME PASS UID

ADDR=$(cat ip)

telegraf &
exec /usr/sbin/vsftpd -opasv_address=$ADDR /etc/vsftpd/vsftpd.conf