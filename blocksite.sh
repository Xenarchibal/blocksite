#!/bin/bash

function IPTABLES
{
	iptables -$1 OUTPUT -p all -m string --algo kmp --string $2 -j DROP
}


case $1 in
	add)
		CMD="A"
		;;
	del)
		CMD="D"
		;;
	*)
		echo "Usage: $0 { add | del}"
		exit 1
		;;
esac

SITES_LIST=$(<./blocksite.conf)
for SITE in $SITES_LIST; do
	IPTABLES $CMD $SITE
	IPTABLES $CMD '.'$SITE
done

exit 0

