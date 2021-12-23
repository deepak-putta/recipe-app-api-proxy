#!/bin/sh 

set -e              #if any lines fail, return arrow to screen
envsubst < /etc/nginx/default.conf.tpl > /etc/nginx/conf.d/default.conf
nginx -g 'daemon off;'  # forcing nginx run foreground, docker prefers primary app run in foreground,all logs from nginx printed out to docker