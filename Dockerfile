FROM php:8-apache
LABEL maintainer="Mark Kevin Besinga <besingamkb@gmail.com>"

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

RUN \
    docker-php-ext-configure pdo_mysql --with-pdo-mysql=mysqlnd\
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-enable pdo_mysql

RUN pecl install redis \
    && docker-php-ext-enable redis