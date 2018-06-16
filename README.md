Docker webapp image
-------------------

[![Build Status](https://travis-ci.org/roquie/docker-php-webapp.svg?branch=master)](https://travis-ci.org/roquie/docker-php-webapp)
![Docker Automated build](https://img.shields.io/docker/automated/roquie/docker-php-webapp.svg)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/roquie/docker-php-webapp.svg)
[![GitHub license](https://img.shields.io/github/license/roquie/docker-php-webapp.svg)](https://github.com/roquie/docker-php-webapp)

## Introduction

Docker image includes PHP 7.2, NGINX 1.15, PHP-FPM and supervisord.

Kill features:
* Security-frendly because work as non root user.
* Fast start at run.
* Used the env variables for configure many parameters at start.
* Fully compatible with PaaS-solutions like as Heroku, Flynn, Deis Workflow, Dokku and many others.
* Internal port of nginx is taken from `$PORT` env variable.
* Used Supervisord written on Golang.
* Small image size (for Debian-based of course).

**Every week travis auto build the docker image and push to the registry.**

## ENV

```bash
ENV PORT=8080
ENV NGINX_WEBROOT="/srv/www"
ENV NGINX_WORKER_PROCESSES=auto # If not set, when image start, script automatically check how many of CPUs count contains within machine.
ENV NGINX_MAX_BODY_SIZE="2G"
ENV NGINX_BODY_TIMEOUT="120s"
ENV NGINX_HEADER_TIMEOUT="120s"

ENV PHP_FPM_CLEAR_ENV="no"

ENV PHP_ERROR_REPORTING="E_ALL & ~E_DEPRECATED & ~E_STRICT"
ENV PHP_DISPLAY_ERRORS="Off"
ENV PHP_SHORT_OPEN_TAG="Off"
ENV PHP_MEMORY_LIMIT="512M"
ENV PHP_POST_MAX_SIZE="128M"
ENV PHP_UPLOAD_MAX_FILESIZE="128M"
ENV PHP_MAX_EXECUTION_TIME="160"
ENV PHP_MAX_INPUT_TIME="120"
ENV PHP_DATE_TIMEZONE="UTC"
ENV PHP_EXPOSE="Off"
ENV PHP_OPCACHE="1"
```

## Ports

* 8080

## Volumes

* /srv/www

## Usage example

```bash
FROM roquie/docker-php-webapp:latest

COPY --chown=nginx:nginx . /srv/www
```

## Versions

* latest

## License

MIT
