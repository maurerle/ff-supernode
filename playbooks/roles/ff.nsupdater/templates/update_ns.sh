#!/bin/bash
sudo mkdir -p /var/cache/ffac
#sudo chown -R $UID /var/cache/ffac
mkdir -p /var/cache/ffac/history
LOCKFILE="/var/cache/ffac/nsupdate.lock"

#(
## Wait for lock for 10 seconds
#flock -x -w 10 200 || exit 1

NSUP=`TMPDIR=/var/cache/ffac mktemp --tmpdir nsup.script.XXXXXXXXXX` || exit 1
NSDEL=`TMPDIR=/var/cache/ffac mktemp --tmpdir nsdel.script.XXXXXXXXXX` || exit 1
NSADD=`TMPDIR=/var/cache/ffac mktemp --tmpdir nadd.script.XXXXXXXXXX` || exit 1


jq -r '.nodes[].nodeinfo | {"ips": .network.addresses[], "hostname": (.hostname | gsub(" ";"-")| gsub("\\.";"") | gsub("´";"")+".nodes.ffac.rocks")} | join (" ")' /var/www/html/meshviewer/data/nodes.json | tr '[:upper:]' '[:lower:]' | grep ^2a03:2260:3006 | sed "s/[_#']/-/g"|sed 's/^-\+//g'| ./idnaencode.py > hosts_should
#kill -SIGHUP `pidof dnsmasq`
touch hosts_is
LC_COLLATE=C sort hosts_should | sed -e 's/+/-/g' | sed -e 's/_/-/g' > hosts_should_sorted

# check if should equals is state
diff -q hosts_should_sorted hosts_is &>/dev/null
if [ $? -ne 0 ]; then
	# if not, we calculate the diff
	LC_COLLATE=C comm -23 hosts_is hosts_should_sorted > $NSDEL
	LC_COLLATE=C comm -13 hosts_is hosts_should_sorted > $NSADD
	echo "zone nodes.ffac.rocks" > $NSUP
	while read host ; do
		NAME="$(echo $host | perl -p -e 's/^.*? //')"
		FIXEDNAME=$(echo $NAME | sed 's/ /-/g'|sed 's/^-\+//g')
		echo "update delete $FIXEDNAME AAAA" >> $NSUP
		#cat $NSUP
	done < $NSDEL
	echo "send" >> $NSUP
	echo  >> $NSUP
	nsupdate -v -k ~/.Knodes.ffac.rocks.secret $NSUP &>> /var/cache/ffac/history/nsup-`date +%Y%m%d-%H`
	sleep 1
	# now add additional records
	echo "zone nodes.ffac.rocks" > $NSUP
	while read host ; do
		NAME=$(echo $host | perl -p -e 's/^.*? //')
		IPv6=$(echo $host | awk '$1 ~/2a03:2260:3006/ {print $1}')
		FIXEDNAME=$(echo $NAME | sed 's/ /-/g'|sed 's/^-\+//g')
		echo "update add $FIXEDNAME 60 IN AAAA $IPv6" >> $NSUP
	done < $NSADD
	echo "send" >> $NSUP
	echo  >> $NSUP
	nsupdate -v -k ~/.Knodes.ffac.rocks.secret $NSUP &>> /var/cache/ffac/history/nsup-`date +%Y%m%d-%H`

fi

cp hosts_should_sorted hosts_is

rm $NSUP
rm $NSDEL
rm $NSADD
#) 200>$LOCKFILE
