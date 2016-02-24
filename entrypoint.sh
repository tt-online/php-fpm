#!/bin/bash

if [ -f "/var/config-fpm/php.ini" ]; then
    cp /var/config-fpm/nginx.conf /etc/php/7.0/fpm/php.ini
fi

if [ -d "/var/config-fpm/pool.d/" ]; then
    cp /var/config-fpm/pool.d/*  /etc/php/7.0/fpm/pool.d/
fi

if [ "${APPLICATION_ENV}" = "dev" ]; then
    sed -i "s@opcache.validate_timestamps=0@opcache.validate_timestamps=1@" /etc/php/7.0/fpm/php.ini
fi

if [ "${XDEBUG_ENABLED}" = "1" ]; then
    echo "zend_extension=xdebug.so" > /etc/php/7.0/fpm/conf.d/20-xdebug.ini
else
    rm /etc/php/7.0/fpm/conf.d/20-xdebug.ini
fi

if [ -f "/var/config-fpm/script.sh" ]; then
    exec "/var/config-fpm/script.sh"
fi

if [ "$1" != '/usr/sbin/php-fpm7.0 --nodaemonize' ]; then
    /bin/bash -l -c "$*"
fi
