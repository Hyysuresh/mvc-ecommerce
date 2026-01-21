# FROM php:8.5-fpm-alpine AS builder

# WORKDIR /app

# COPY . .

# FROM php:8.5-apache

# WORKDIR /var/www/html
# RUN apt-get update && apt-get install -y \
# 		libfreetype-dev \
# 		libjpeg62-turbo-dev \
# 		libpng-dev \
# 	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
# 	&& docker-php-ext-install -j$(nproc) gd

# RUN echo "ServerName localhost" > /etc/apache2/conf-available/servername.conf \
#     && a2enconf servername
# # PHP extensions (DB ke liye)
# RUN docker-php-ext-install pdo pdo_mysql mysqli

# RUN a2enmod rewrite

# COPY --from=builder /app /var/www/html/

# # Permissions (IMPORTANT for images & uploads)
# RUN chown -R www-data:www-data /var/www/html \
#  && chmod -R 755 /var/www/html

# EXPOSE 80

# CMD ["apache2-foreground"]

FROM php:8.5-fpm-alpine

WORKDIR /var/www/html

RUN apk add --no-cache \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
    gd \
    pdo \
    pdo_mysql \
    mysqli \
    && rm -rf /tmp/*

USER www-data

