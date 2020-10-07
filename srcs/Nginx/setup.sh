/usr/sbin/sshd
/etc/init.d/watcher.sh &
nginx -t
telegraf &
nginx -g 'daemon off;'