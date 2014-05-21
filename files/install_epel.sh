#!/bin/bash

#$1 hostname proxy
#$2 port proxy

URL_EPELPACKAGES="http://dl.fedoraproject.org/pub/epel/6/x86_64/"

#Parse arguments
errorargs=0
if [ $# -eq 2 ] ; then
	[ ${1:0:7} != "http://" ] && erroragrs=1
	[ $2 -lt 1024 -o $2 -gt 65535 ] && errorargs=1
	if [ $errorargs -eq 1 ]; then	
		echo "Usage $0: install_epel.sh <proxyhost> <proxyport>" 
		exit 1
	fi
	proxy=${1#http://}
	port=$2
fi

if [ "x$1" != "x" -a  "x$2" != "x" ] ; then
URL_EPELRPM=$(elinks -eval "set protocol.http.proxy.host = '$proxy:$port'" -dump $URL_EPELPACKAGES | cut -d ' ' -f 2 |grep '^http://.*/epel-[^/]\+\.rpm$')
	rpm --httpproxy $proxy --httpport $port -i $URL_EPELRPM
else
	URL_EPELRPM=$(elinks -dump $URL_EPELPACKAGES | cut -d ' ' -f 2 |grep '^http://.*/epel-[^/]\+\.rpm$')
	rpm -i $URL_EPELRPM
fi
exit $?
