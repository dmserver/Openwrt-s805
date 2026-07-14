#!/bin/bash

if [ ! -z "$1" ];then
    ip="$1"
fi

if [ ! -z "$2" ];then
    ip_server="$2"
fi

#默认主路由
rm -rf ./files/etc/config/network

#如果files/etc/config文件夹不存在，创建文件夹
if [ ! -d "./files/etc/config" ]; then
  mkdir -p ./files/etc/config
fi

		  
if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
	echo "

config interface 'loopback'
	option proto 'static'
	option ipaddr '127.0.0.1'
	option netmask '255.0.0.0'
	option device 'lo'

config globals 'globals'
	option packet_steering '1'
	option ula_prefix 'fe88::/48'

config interface 'lan'
	option proto 'static'
	option ipaddr '$ip'
	option netmask '255.255.255.0'
	option ip6assign '64'
	option device 'br-lan'
	option ip6ifaceid '::1'
	list ip6class 'local'
	
config interface 'docker'
	option proto 'none'
	option auto '0'
	option device 'docker0'

config device
	option type 'bridge'
	option name 'docker0'

config device
	option name 'br-lan'
	option type 'bridge'
	list ports 'eth0'

config interface 'wan'
	option proto 'dhcp'
	option device 'eth1'

config interface 'wan6'
	option proto 'dhcpv6'
	option device 'eth1'
	option reqaddress 'try'
	option reqprefix 'auto'
	option norelease '1'
	option sourcefilter '0'




">files/etc/config/network
else
	echo "玩客云IP地址 $ip 不符合规范。"
	exit 1
fi


