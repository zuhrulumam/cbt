FROM php:8.1-apache
COPY . /var/www/html
RUN docker-php-ext-install pdo_mysql mysqli && a2enmod rewrite
RUN chown -R www-data:www-data /var/www/html
