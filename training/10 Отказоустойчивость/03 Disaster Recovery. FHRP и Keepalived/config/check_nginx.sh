#!/bin/bash
if [[ $(netstat -ant | grep LISTEN | grep :80) ]] && [[ -f /var/www/html/index.nginx-debian.html ]]; then
  exit 0
else
  exit 1
fi