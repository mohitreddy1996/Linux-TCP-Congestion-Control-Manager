#!/bin/bash

function error_exit
{
	echo "$1" 1>&2
	echo
	exit 1
}

wlan_state="$(cat /sys/class/net/wlan0/operstate)"
eth_state="$(cat /sys/class/net/eth0/operstate)"


if [[ "$eth_state" == "up" ]]; then
	echo "Ethernet is $eth_state currently"
	if [[ `sudo sysctl -w net.ipv4.tcp_congestion_control=cubic` ]]; then
		echo "TCP now changed to Cubic."
		exit 0
	else
		error_exit "Could not set the tcp_congestion_control to cubic."
	fi
else
	echo "Ethernet is $eth_state currently"
fi


if [[ "$wlan_state" == "up" ]]; then
	echo "Wireless LAN $wlan_state currently"
	if [[ `sudo sysctl -w net.ipv4.tcp_congestion_control=westwood` ]]; then
		echo "TCP now changed to westwood"
		exit 0
	else
		error_exit "Could not set the tcp_congestion_control to westwood"
	fi
else
	echo "Wireless LAN $wlan_state currently"
fi

