#!/bin/sh
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
port=8889

PROXY_HTTP="http://${hostip}:${port}"
PROXY_HTTPS="https://${hostip}:${port}"
echo "$PROXY_HTTP"

docker build --build-arg PROXY_HTTP=$PROXY_HTTP $*
# docker build --build-arg $*