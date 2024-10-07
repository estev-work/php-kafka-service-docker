FROM php:8.3-fpm as base

RUN apt-get update && apt-get install -y \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    curl \
    librdkafka-dev \
    && docker-php-ext-install pdo_mysql mbstring zip \
    && pecl install rdkafka \
    && docker-php-ext-enable rdkafka
COPY php.ini /usr/local/etc/php/

FROM base as xdebug
# xdebug
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions xdebug
ENV PHP_IDE_CONFIG 'serverName=debug.php'
RUN echo "xdebug.mode=debug" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.start_with_request = yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.client_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.log=/var/log/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.idekey = PHPSTORM" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
COPY php.ini /usr/local/etc/php/

FROM xdebug as run
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY php-fpm.conf /usr/local/etc/php-fpm.d/www.conf
WORKDIR /var/www/html
CMD ["php-fpm"]
