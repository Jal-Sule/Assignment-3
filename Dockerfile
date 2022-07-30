FROM php:7.4-apache

RUN apt-get update \
  && apt-get install -y --no-install-recommends openssl libssl-dev libcurl4-openssl-dev git \
  && pecl install mongodb \
  && cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
  && echo "extension=mongodb.so" >> /usr/local/etc/php/php.ini \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* 

WORKDIR /var/www/html
RUN composer require mongodb/mongodb

COPY ./app /var/www/html

EXPOSE 80
