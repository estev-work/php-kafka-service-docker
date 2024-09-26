FROM php:8.3-fpm

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

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

CMD ["php-fpm"]
