
# 给php 增加一些扩展

FROM php:7.3.3-fpm


# 最后要修改用户uid，目的是让Container内的用户可以访问到Host的文件;
# 这里需要提前知道uid  (id -u $USER)
RUN apt-get update; \
    apt-get install -y libpq-dev librabbitmq-dev procps; \
    docker-php-ext-install -j$(nproc) pdo_pgsql; \
    \
    pecl install swoole-4.3.1; \
    pecl install redis-4.3.0; \
    pecl install amqp-1.9.4; \
    \
    docker-php-ext-enable redis swoole amqp; \
    \
    apt-get purge -y --auto-remove && apt-get autoremove && apt-get autoclean; \
    rm -rf /var/lib/apt/lists/*; \
	\
	usermod -u 1000 www-data;
