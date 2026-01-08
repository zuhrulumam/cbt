FROM php:8.1-apache

# Copy all files first
COPY . /var/www/html

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mysqli && a2enmod rewrite

# Create all possible session/cache/upload folders CodeIgniter might need
RUN mkdir -p /var/www/html/application/sessions \
    && mkdir -p /var/www/html/application/cache \
    && mkdir -p /var/www/html/application/logs \
    && mkdir -p /var/www/html/writable \
    && mkdir -p /var/www/html/uploads \
    && mkdir -p /tmp/ci_sessions \
    && mkdir -p /var/lib/php/sessions \
    && chown -R www-data:www-data /var/www/html \
    && chown -R www-data:www-data /tmp/ci_sessions \
    && chown -R www-data:www-data /var/lib/php/sessions \
    && chmod -R 777 /var/www/html/application/sessions \
    && chmod -R 777 /var/www/html/application/cache \
    && chmod -R 777 /var/www/html/application/logs \
    && chmod -R 777 /var/www/html/writable \
    && chmod -R 777 /var/www/html/uploads \
    && chmod -R 777 /tmp/ci_sessions \
    && chmod -R 777 /var/lib/php/sessions

# Set PHP session save path globally
RUN echo "session.save_path = \"/tmp/ci_sessions\"" > /usr/local/etc/php/conf.d/sessions.ini

# Enable Apache .htaccess
RUN sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
