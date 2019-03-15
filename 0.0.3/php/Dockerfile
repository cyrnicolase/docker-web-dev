
# 给php 增加一些扩展

FROM php:7.3.3-fpm

RUN apt-get update; \
    apt-get install -y libpq-dev librabbitmq-dev; \
    docker-php-ext-install -j$(nproc) pdo_pgsql; \
    \
    pecl install swoole-4.3.1; \
    pecl install redis-4.3.0; \
    pecl install amqp-1.9.4; \
    \
    docker-php-ext-enable redis swoole amqp; \
    \
    apt-get purge -y --auto-remove && apt-get autoremove && apt-get autoclean; \
    rm -rf /var/lib/apt/lists/*;
