FROM php:8.1.4-fpm

RUN echo "deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib\n \
	deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib\n \
	deb https://mirrors.aliyun.com/debian-security/ bullseye-security main\n \
	deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main\n \
	deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib\n \
	deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib\n \
	deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib\n \
	deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib" > /etc/apt/sources.list; \
	\
	apt-get update; \
	apt-get install -y libpng-dev libpq-dev libzip-dev librabbitmq-dev zlib1g-dev; \
	apt-get install -y procps git vim wget; \
	apt-get purge -y --auto-remove && apt-get autoremove && apt-get autoclean; \
	rm -rf /var/lib/apt/lists/*; \
	\
	echo "alias ll='ls -l'" >> ~/.bashrc; 

RUN docker-php-ext-install -j$(nproc) pdo_pgsql bcmath gd zip; \
	pecl install protobuf-3.20.1RC1; \
	pecl install grpc-1.45.0; \
	pecl install swoole-4.8.8; \
	pecl install redis-5.3.7; \
	pecl install amqp-1.11.0; \
	docker-php-ext-enable protobuf; \
	docker-php-ext-enable grpc; \
	docker-php-ext-enable swoole; \
	docker-php-ext-enable redis; \
	docker-php-ext-enable amqp; \
	\
	wget https://getcomposer.org/download/2.3.4/composer.phar -O /usr/local/bin/composer \
	&& chmod +x /usr/local/bin/composer;

