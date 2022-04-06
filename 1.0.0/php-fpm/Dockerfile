FROM php:8.1.4-fpm

RUN apt-get update; \
	apt-get install -y libpq-dev librabbitmq-dev procps; \
	docker-php-ext-install -j$(nproc) pdo_pgsql; \
	pecl install swoole-4.8.8; \
	pecl install redis-5.3.7; \
	pecl install amqp-1.11.0; \
	\
	docker-php-ext-enable redis swoole amqp; \
	\
	apt-get purge -y --auto-remove && apt-get autoremove && apt-get autoclean; \
	\
	rm -rf /var/lib/apt/lists/*;
