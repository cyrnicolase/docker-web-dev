FROM php:8.1.4-fpm

# 系统准备
RUN \
    echo \
    "deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib\n \
    deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib\n \
    deb https://mirrors.aliyun.com/debian-security/ bullseye-security main\n \
    deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main\n \
    deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib\n \
    deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib\n \
    deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib\n \
    deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib" > /etc/apt/sources.list; \
    \
    apt-get update; \
    apt-get install -y libpng-dev libpq-dev libzip-dev librabbitmq-dev zlib1g-dev librdkafka-dev libevent-dev; \
    apt-get install -y procps git vim wget rsyslog; \
    apt-get purge -y --auto-remove && apt-get autoremove && apt-get autoclean; \
    rm -rf /var/lib/apt/lists/*; \
    \
    echo "alias ll='ls -l'" >> ~/.bashrc; \
    \
    wget https://getcomposer.org/download/2.3.4/composer.phar -O /usr/local/bin/composer && chmod +x /usr/local/bin/composer;

# PHP扩展安装
RUN \
    docker-php-ext-install -j$(nproc) pdo_mysql pdo_pgsql bcmath gd zip pcntl; \
    \
    # 安装sockets 扩展，这里不能使用 docker-php-ext-install 是因为php 在加载扩展顺序上，会导致 sockets 扩展比 event 扩展滞后加载引起问题
    # 最后的 echo "extension=sockets.so" >> /usr/local/etc/php/php.ini 很重要
    cd /usr/src && tar -xvf php.tar.xz && cd php-8.1.4/ext/sockets\
    && phpize && ./configure && make -j$(nproc) && make install \
    && echo "extension=sockets.so" >> /usr/local/etc/php/php.ini; \
    \
    pecl install swoole-4.8.8; \
    pecl install amqp-1.11.0; \
    pecl install rdkafka-6.0.1; \
    pecl install event; \
    pecl install redis; \
    docker-php-ext-enable swoole; \
    docker-php-ext-enable amqp; \
    docker-php-ext-enable rdkafka; \
    docker-php-ext-enable event; \
    docker-php-ext-enable redis; \
    \
    cd /usr/src && rm -rf php-8.1.4;
