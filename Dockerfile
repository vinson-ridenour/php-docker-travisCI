FROM php:7.1-fpm as builder

COPY composer.json .

# RUN composer install

COPY . .

# RUN apt-get update && apt-get install -y libmcrypt-dev \
    #mysql-client libmagickwand-dev --no-install-recommends \
    #&& pecl install imagick \
    #&& docker-php-ext-enable imagick \
    #&& docker-php-ext-install mcrypt pdo_mysql

RUN chown -R www-data:www-data /var/www 
RUN chmod 755 /var/www

# RUN php artisan key:generate
# RUN php artisan migrate
# RUN php artisan serve


FROM nginx:1.10
EXPOSE 80
ADD vhost.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /var/www/html /usr/share/nginx/html


