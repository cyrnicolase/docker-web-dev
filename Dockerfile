

FROM centos

# build nginx
# 工作目录: /data/wwwroot
# nginx配置文件路径: /usr/local/etc/nginx/nginx.conf
# 以上都是在启动的时候需要进行挂载的

# 软件源文件目录
# NGINX配置文件目录
ENV SOFT_DIR=/root/soft   
ENV NGINX_CONF_PATH=/usr/local/etc/nginx/nginx.conf
ENV WORK_DIR=/data/wwwroot

# volume 
# VOLUME ["/usr/local/etc/", "/data"]

# 将需要的软件包提前准备好，避免重复下载
# COPY source /opt

RUN yum install -y wget gcc pcre pcre-devel zlib zlib-devel openssl openssl-devel daemon \
    && /usr/sbin/useradd -s /sbin/nologin www \
    && mkdir -p /data/logs/www \
    && mkdir -p /data/wwwroot \
    && chown -R www.www /data \
    && mkdir -p $SOFT_DIR \
    && cd $SOFT_DIR \
    && wget http://nginx.org/download/nginx-1.14.0.tar.gz -O nginx-1.14.0.tar.gz \
    && tar -xf nginx-1.14.0.tar.gz && cd nginx-1.14.0 \
    && ./configure \
        --prefix=/usr/local/nginx/1.14.0 \
        --sbin-path=/usr/local/sbin \
        --user=www \
        --group=www \
        --conf-path=$NGINX_CONF_PATH \
        --error-log-path=/data/logs/www  \
    && make -j "$(nproc)" && make install \

    && yum install -y curl-devel unzip \
                      ntp gcc-c++ autoconf bzip2-devel \
                      ncurses-devel libjpeg-devel libpng-devel libtiff-devel freetype-devel \
                      libXpm-devel gettext-devel libxml2-devel  postgresql-devel \

    && cd $SOFT_DIR \
    && if [ -f /opt/php-7.1.19.tar.gz ]; then /bin/cp /opt/php-7.1.19.tar.gz $SOFT_DIR ;\
       else wget http://cn.php.net/distributions/php-7.1.19.tar.gz; fi \
    && tar xf php-7.1.19.tar.gz && cd php-7.1.19 \
    && ./configure --prefix=/usr/local/php/7.1.19/ \
                    --enable-fpm \
                    --with-fpm-user=www \
                    --with-fpm-group=www \
                    --with-config-file-path=/usr/local/etc/php \
                    --enable-bcmath \
                    --enable-exif \
                    --enable-ftp \
                    --enable-mbstring \
                    --enable-pcntl \
                    --enable-soap \
                    --enable-sockets \
                    --enable-zip \
                    --enable-mysqlnd \
                    --with-pdo-mysql=mysqlnd \
                    --with-mysqli=mysqlnd \
                    --with-pdo-pgsql \
                    --with-mhash \
                    --with-gd \
                    --with-curl \
                    --with-openssl \
                    --with-zlib \
    && make -j "$(nproc)" && make install \

    && cd $SOFT_DIR \
    && if [ -f /opt/v4.0.0.zip ]; then /bin/cp /opt/v4.0.0.zip $SOFT_DIR; \
       else wget https://gitee.com/swoole/swoole/repository/archive/v4.0.0.zip; fi \
    && unzip v4.0.0.zip && cd swoole \
    && /usr/local/php/7.1.19/bin/phpize \
    && ./configure --with-php-config=/usr/local/php/7.1.19/bin/php-config \
    && make -j "$(nproc)" && make install \

    && cd $SOFT_DIR \
    && if [ -f /opt/redis-4.0.2.tgz ];then /bin/cp /opt/redis-4.0.2.tgz $SOFT_DIR; \
       else wget http://pecl.php.net/get/redis-4.0.2.tgz; fi \
    && tar xf redis-4.0.2.tgz && cd redis-4.0.2 \
    && /usr/local/php/7.1.19/bin/phpize \
    && ./configure --with-php-config=/usr/local/php/7.1.19/bin/php-config \
    && make -j "$(nproc)" && make install \

    && rm -fr $SOFT_DIR \
    && yum clean all && rm -rf /var/cache/yum

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]

