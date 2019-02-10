#!/usr/bin/env bash

/usr/sbin/php-fpm${PHP_VERSION} --nodaemonize --fpm-config=/etc/php/${PHP_VERSION}/fpm/php-fpm.conf
