
echo "# Put your custom commands here that should be executed once
# the system init finished. By default this file does nothing.

#mount -o remount rw /
#/usr/sbin/balethirq.pl
#alias reboot='reboot -f'
sh /etc/diymo.sh
exit 0">/etc/rc.local

rm -rf /etc/1.sh
sh /etc/rc.local
