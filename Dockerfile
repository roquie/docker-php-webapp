FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV NGINX_VERSION 1.15.0-1~stretch
ENV NGINX_WEBROOT /srv/www

RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
       gnupg2 dirmngr curl apt-transport-https lsb-release ca-certificates \
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 \
    && echo "deb https://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list \
    && curl -o /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
        git \
        make \
        gettext-base \
        python-setuptools \
        nginx=${NGINX_VERSION} \
        php7.2-fpm \
        php7.2-cli \
        php7.2-common \
        php7.2-json \
        php7.2-opcache \
        php7.2-readline \
        php7.2-mbstring \
        php7.2-curl \
        php7.2-memcached \
        php7.2-imagick \
        php7.2-gd \
        php7.2-mysql \
        php7.2-zip \
        php7.2-pgsql \
        php7.2-intl \
        php7.2-xml \
        php7.2-redis \
    && easy_install supervisor supervisor-stdout \
    && echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
    && git clone https://github.com/ztombol/varrick.git \
    && cd varrick; make -i install; cd ..; rm -rf varrick \
    && apt-get purge -y git make \
    && chown -R nginx:nginx /etc/nginx /etc/php/7.2/fpm \
    && rm -rf /etc/nginx/conf.d/default.conf \
    && rm /usr/share/nginx/html/* \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

ADD conf/supervisord.conf /etc/supervisord.conf
ADD conf/nginx/* /etc/nginx/
ADD conf/php-fpm /etc/php/7.2/fpm/

COPY --chown=nginx:nginx app /srv/www

USER nginx

ADD conf/start.sh /start.sh

VOLUME /srv/www

EXPOSE 8080

CMD ["/start.sh"]
