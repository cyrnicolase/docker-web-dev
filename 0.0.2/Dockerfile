

FROM hc-vod-web

RUN yum install -y cmake \
    && mkdir /root/soft \

    # install rabbitmq-c
    && cd /root/soft \
    && if [ -f /opt/v0.9.0.tar.gz ];then /bin/cp /opt/v0.9.0.tar.gz /root/soft; \
       else wget https://github.com/alanxz/rabbitmq-c/archive/v0.9.0.tar.gz; fi \
    && tar xf v0.9.0.tar.gz && cd rabbitmq-c-0.9.0 \
    && cmake . \
    && cmake --build . --target install \
    && ln -s /usr/local/lib64/librabbitmq.so.4 /usr/local/lib/librabbitmq.so.4 \

    # install amqp
    && cd /root/soft \
    && if [ -f /opt/amqp-1.7.0.tgz ];then /bin/cp /opt/amqp-1.7.0.tgz /root/soft; \
       else wget http://pecl.php.net/get/amqp-1.7.0.tgz; fi \
    && tar xf amqp-1.7.0.tgz && cd amqp-1.7.0 \
    && /usr/local/php/7.1.19/bin/phpize \
    && ./configure --with-php-config=/usr/local/php/7.1.19/bin/php-config --with-amqp\
    && make -j "$(nproc)" && make install \

    # install swoole
    && cd /root/soft \
    && if [ -f /opt/v4.0.0.zip ]; then /bin/cp /opt/v4.0.0.zip /root/soft; \
       else wget https://gitee.com/swoole/swoole/repository/archive/v4.0.0.zip; fi \
    && unzip v4.0.0.zip && cd swoole \
    && /usr/local/php/7.1.19/bin/phpize \
    && ./configure --with-php-config=/usr/local/php/7.1.19/bin/php-config \
    && make -j "$(nproc)" && make install \

    # install redis
    && cd /root/soft \
    && if [ -f /opt/redis-4.0.2.tgz ];then /bin/cp /opt/redis-4.0.2.tgz /root/soft; \
       else wget http://pecl.php.net/get/redis-4.0.2.tgz; fi \
    && tar xf redis-4.0.2.tgz && cd redis-4.0.2 \
    && /usr/local/php/7.1.19/bin/phpize \
    && ./configure --with-php-config=/usr/local/php/7.1.19/bin/php-config \
    && make -j "$(nproc)" && make install \

    && rm -fr /root/soft \
    && rm -fr /opt \
    && rm -fr /var/cache/yum \
    && yum clean all


