
# 给php 增加一些扩展

FROM php:7.3.3-fpm

RUN apt-get update; \
    apt-get install -y libpq-dev; \
    \
    docker-php-ext-install -j$(nproc) pdo_pgsql; \
    \
    pecl install redis-4.3.0; \
    docker-php-ext-enable redis;  \
    \
    apt-get purge -y --auto-remove; \
    rm -rf /var/lib/apt/lists/*;
