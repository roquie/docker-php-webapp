FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND noninteractive
ENV PHP_VERSION 8.1
ENV NGINX_WEBROOT /srv/www

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
       gnupg2 dirmngr curl apt-transport-https lsb-release ca-certificates \
    && apt-key adv --no-tty --keyserver keyserver.ubuntu.com --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb https://nginx.org/packages/mainline/debian/ $(lsb_release -sc) nginx" >> /etc/apt/sources.list \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
        gettext-base \
        nginx \
        php${PHP_VERSION}-fpm \
        php${PHP_VERSION}-cli \
        php${PHP_VERSION}-common \
        php${PHP_VERSION}-json \
        php${PHP_VERSION}-opcache \
        php${PHP_VERSION}-readline \
        php${PHP_VERSION}-mbstring \
        php${PHP_VERSION}-curl \
        php${PHP_VERSION}-memcached \
        php${PHP_VERSION}-imagick \
        php${PHP_VERSION}-gd \
        php${PHP_VERSION}-mysql \
        php${PHP_VERSION}-zip \
        php${PHP_VERSION}-pgsql \
        php${PHP_VERSION}-intl \
        php${PHP_VERSION}-xml \
        php${PHP_VERSION}-redis \
        php${PHP_VERSION}-exif \
        php${PHP_VERSION}-bcmath \
        php${PHP_VERSION}-xmlreader \
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && chown -R nginx:nginx /etc/nginx /etc/php/${PHP_VERSION}/fpm /etc/php/${PHP_VERSION}/cli \
    && rm -rf /etc/nginx/conf.d/default.conf \
    && rm /usr/share/nginx/html/* \
    && apt-get purge -y php{$PHP_VERSION}-dev git make python python3 perl; apt-get autoremove -y \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY conf/nginx/* /etc/nginx/
COPY conf/php-fpm /etc/php/${PHP_VERSION}/fpm/
COPY conf/php.ini.tmpl /etc/php/${PHP_VERSION}/fpm/
COPY conf/php.ini.tmpl /etc/php/${PHP_VERSION}/cli/
COPY conf/php.sh /usr/sbin/php.sh
COPY conf/supervisord.conf /etc/supervisord.conf

COPY --chown=nginx:nginx app /srv/www
COPY --from=roquie/smalte:latest /app/smalte /usr/local/bin/smalte
COPY --from=ochinchina/supervisord:latest /usr/local/bin/supervisord /usr/local/bin/supervisord

USER nginx

ADD conf/start.sh /start.sh

VOLUME /srv/www
WORKDIR /srv/www

EXPOSE 8080

CMD ["/start.sh"]
