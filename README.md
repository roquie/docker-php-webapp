PHP Docker webapp image
-----------------------

[![Build Status](https://travis-ci.org/roquie/docker-php-webapp.svg?branch=master)](https://travis-ci.org/roquie/docker-php-webapp)
![Docker Automated build](https://img.shields.io/docker/automated/roquie/docker-php-webapp.svg)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/roquie/docker-php-webapp.svg)
[![GitHub license](https://img.shields.io/github/license/roquie/docker-php-webapp.svg)](https://github.com/roquie/docker-php-webapp)

## Introduction

A classic container who runs NGINX and PHP-FPM together. 

Docker image includes PHP, NGINX, PHP-FPM and supervisord.

Features:
* Security-frendly because work as non-root user.
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
ENV NGINX_ACCESS_LOG="off"

ENV PHP_FPM_CLEAR_ENV="no"
ENV PHP_FPM_LOG_LEVEL="notice"

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
ENV PHP_OPCACHE_ENABLED="1"
ENV PHP_OPCACHE_SAVE_COMMENTS="0"
```

## Ports

* 8080

## Volumes

* /srv/www

## Usage example

```bash
FROM roquie/docker-php-webapp:8.1-1.0.0

COPY --chown=nginx:nginx . /srv/www
```

## Versions

* latest
* 8.1-latest or 8.1-{semver}
* 8.0-latest or 8.0-{semver}
* 7.4-latest or 7.4-{semver}
* 7.3-latest

## License

Copyright (c) 2022 Roquie <roquie0@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

