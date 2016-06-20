FROM ttonline/php:7.0

COPY entrypoint.sh /entrypoint.sh

ENV XDEBUG_ENABLED=0

RUN chmod 777 /entrypoint.sh \
 && mkdir -p /var/log/fpm/

VOLUME ["/var/config-fpm/"]

EXPOSE 9000

WORKDIR /var/www

ENTRYPOINT ["/entrypoint.sh"]