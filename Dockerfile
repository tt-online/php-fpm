FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y language-pack-en-base software-properties-common
RUN LC_ALL=en_GB.UTF-8 add-apt-repository ppa:ondrej/php -y
RUN apt-get update && apt-get install -y \
    git \
    curl \
    php-cli \
    php7.0 \
    php7.0-fpm \
    php7.0-common \
    php-json \
    php-xml \
    php-intl \
    php-mysql \
    php-mcrypt \
    php-apcu \
    php-soap \
    php-redis \
    php-curl \
    php-xdebug

RUN usermod -u 1000 www-data
RUN usermod -G staff www-data

RUN mkdir -p /run/php

ENV APPLICATION_ENV prod
RUN mkdir -p /var/log/fpm/

VOLUME ["/var/config-fpm/","/var/log/fpm"]

ADD entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh

EXPOSE 9000

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]