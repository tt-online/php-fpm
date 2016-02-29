FROM ttonline/php7:latest

COPY entrypoint.sh /entrypoint.sh

ENV XDEBUG_ENABLED=0

RUN chmod 777 /entrypoint.sh \
 && usermod -u 1000 www-data && usermod -G staff www-data \
 && mkdir -p /var/log/fpm/

VOLUME ["/var/config-fpm/"]

EXPOSE 9000

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]