#!/bin/bash

/usr/local/php/7.1.19/sbin/php-fpm -y /usr/local/etc/php/php-fpm.conf
nginx -c /usr/local/etc/nginx/nginx.conf
