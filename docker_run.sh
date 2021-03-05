#!/bin/sh
hostip=$(cat /etc/resolv.conf | grep nameserver | awk '{ print $2 }')
port=8889

PROXY_HTTP="http://${hostip}:${port}"

docker run \
--env http_proxy="${PROXY_HTTP}" \
--env HTTP_PROXY="${PROXY_HTTP}" \
--env https_proxy="${PROXY_HTTP}" \
--env HTTPS_proxy="${PROXY_HTTP}" \
--env ALL_PROXY="${PROXY_SOCKS5}" \
--env all_proxy=${PROXY_SOCKS5} \
$*