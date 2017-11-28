FROM php:7.1-fpm

ARG TIMEZONE

RUN apt-get update && apt-get install -y \
    openssl \
    git \
    unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Install Symfony
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony
RUN symfony --version

# Install extensions
RUN docker-php-ext-install pdo pdo_mysql

# Install xdebug
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/xdebug.ini
RUN echo "xdebug.profiler_enable=1" >> /usr/local/etc/php/conf.d/xdebug.ini

# Configure PHP
RUN echo "error_reporting=E_ALL" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "display_startup_errors=1" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "display_errors=1" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "memory_limit=-1" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "session.gc_maxlifetime=-1" >> /usr/local/etc/php/conf.d/php.ini

# Configure timezone
RUN ln -snf /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && echo ${TIMEZONE} > /etc/timezone
RUN printf '[PHP]\ndate.timezone = "%s"\n', ${TIMEZONE} > /usr/local/etc/php/conf.d/timezone.ini

# Login as www-data
RUN echo "su -s /bin/bash www-data" >> ~/.bashrc

# Set UID 1000 to www-data
RUN usermod -u 1000 www-data

WORKDIR /var/www

