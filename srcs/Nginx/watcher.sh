while true;do
        instance=$(pgrep -f sshd:)
	[[ "$(echo "$instance")" == '' ]] && kill $(pgrep -f "nginx: master")
	sleep 5s
done