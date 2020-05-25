adduser -D adorigo
echo "adorigo:adorigo" | chpasswd

/usr/sbin/sshd
nginx -t
nginx -g "daemon off;"