#!/bin/bash

# CPU cores count.
count=$(grep processor /proc/cpuinfo | wc -l)

export PORT=${PORT:=8080}
export NGINX_WEBROOT=${NGINX_WEBROOT:="/srv/www"}
export NGINX_WORKER_PROCESSES=${NGINX_WORKER_PROCESSES:=${count}}
export NGINX_MAX_BODY_SIZE=${NGINX_MAX_BODY_SIZE:="2G"}
export NGINX_BODY_TIMEOUT=${NGINX_BODY_TIMEOUT:="120s"}
export NGINX_HEADER_TIMEOUT=${NGINX_HEADER_TIMEOUT:="120s"}
export NGINX_ACCESS_LOG=${NGINX_ACCESS_LOG:="off"}

export PHP_FPM_CLEAR_ENV=${PHP_FPM_CLEAR_ENV:="no"}
export PHP_FPM_LOG_LEVEL=${PHP_FPM_LOG_LEVEL:="notice"}

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

# backward compatibility, $PHP_OPCACHE is deprecated.
if [[ "$PHP_OPCACHE" != "" ]]
then
    export PHP_OPCACHE_ENABLED="$PHP_OPCACHE"
    unset PHP_OPCACHE
fi

export PHP_OPCACHE_ENABLED=${PHP_OPCACHE_ENABLED:="1"}
export PHP_OPCACHE_PRELOAD=${PHP_OPCACHE_PRELOAD:=""}
export PHP_OPCACHE_SAVE_COMMENTS=${PHP_OPCACHE_SAVE_COMMENTS:="0"}

smalte build --scope PORT --scope NGINX\.* --scope PHP\.* \
    /etc/nginx/host.conf.tmpl:/etc/nginx/host.conf \
    /etc/nginx/nginx.conf.tmpl:/etc/nginx/nginx.conf \
    /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf.tmpl:/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf \
    /etc/php/${PHP_VERSION}/fpm/php.ini.tmpl:/etc/php/${PHP_VERSION}/fpm/php.ini \
    /etc/php/${PHP_VERSION}/cli/php.ini.tmpl:/etc/php/${PHP_VERSION}/cli/php.ini \
    /etc/php/${PHP_VERSION}/fpm/php-fpm.conf.tmpl:/etc/php/${PHP_VERSION}/fpm/php-fpm.conf

echo "> Configuration loaded."
echo "> Run application."

# Start supervisord and services
/usr/local/bin/supervisord -c /etc/supervisord.conf
