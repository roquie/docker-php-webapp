#!/bin/bash

# CPU cores count.
count=$(grep processor /proc/cpuinfo | wc -l)

export PORT=${PORT:=8080}
export NGINX_WEBROOT=${NGINX_WEBROOT:="/srv/www"}
export NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES:=${count}}
export NGINX_MAX_BODY_SIZE=${NGINX_MAX_BODY_SIZE:="2G"}
export NGINX_BODY_TIMEOUT=${NGINX_BODY_TIMEOUT:="120s"}
export NGINX_HEADER_TIMEOUT=${NGINX_HEADER_TIMEOUT:="120s"}

export PHP_FPM_CLEAR_ENV=${PHP_FPM_CLEAR_ENV:="no"}

export PHP_ERROR_REPORTING=${PHP_ERROR_REPORTING:="E_ALL & ~E_DEPRECATED & ~E_STRICT"}
export PHP_DISPLAY_ERRORS=${PHP_DISPLAY_ERRORS:="Off"}
export PHP_SHORT_OPEN_TAG=${PHP_SHORT_OPEN_TAG:="Off"}
export PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT:="512M"}
export PHP_POST_MAX_SIZE=${PHP_POST_MAX_SIZE:="128M"}
export PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE:="128M"}
export PHP_MAX_EXECUTION_TIME=${PHP_MAX_EXECUTION_TIME:="160"}
export PHP_MAX_INPUT_TIME=${PHP_MAX_INPUT_TIME:="120"}
export PHP_DATE_TIMEZONE=${PHP_DATE_TIMEZONE:="UTC"}
export PHP_EXPOSE=${PHP_EXPOSE:="Off"}
export PHP_OPCACHE=${PHP_OPCACHE:="1"}

varrick -x /etc/nginx/host.conf.tmpl /etc/nginx
varrick -x /etc/nginx/nginx.conf.tmpl /etc/nginx
varrick -x /etc/php/7.2/fpm/pool.d/www.conf.tmpl /etc/php/7.2/fpm/pool.d
varrick -x /etc/php/7.2/fpm/php.ini.tmpl /etc/php/7.2/fpm

# Start supervisord and services
/usr/local/bin/supervisord -c /etc/supervisord.conf
