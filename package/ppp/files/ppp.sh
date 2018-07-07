scan_ppp() {
	config_get ifname "$1" ifname
	pppdev="${pppdev:-0}"
	config_set "$1" ifname "ppp$pppdev"
	config_set "$1" unit "$pppdev"
}

start_pppd() {
	local cfg="$1"; shift
	config_get device "$cfg" device
	config_get unit "$cfg" unit
	config_get username "$cfg" username
	config_get password "$cfg" password
	config_get keepalive "$cfg" keepalive
	interval="${keepalive%%*[, ]}"
	[ "$interval" != "$keepalive" ] || interval=5
	
	config_get demand "$cfg" demand
	[ -n "$demand" ] && echo "nameserver 1.1.1.1" > /tmp/resolv.conf
	/usr/sbin/pppd "$@" \
		${keepalive:+lcp-echo-interval $interval lcp-echo-failure ${keepalive##[, ]*}} \
		${demand:+precompiled-active-filter /etc/ppp/filter demand idle }${demand:-persist} \
		usepeerdns \
		defaultroute \
		replacedefaultroute \
		${username:+user "$username" password "$password"} \
		linkname "$cfg" \
		ipparam "$cfg"
}
