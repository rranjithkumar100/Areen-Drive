FROM php:8.4-cli-bookworm

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    unzip \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libicu-dev \
    libonig-dev \
    libcurl4-openssl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j"$(nproc)" \
        bcmath \
        curl \
        fileinfo \
        gd \
        intl \
        mbstring \
        pcntl \
        pdo_mysql \
        zip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts --ignore-platform-req=ext-ftp

COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction --ignore-platform-req=ext-ftp

ENV PORT=8080
EXPOSE 8080

CMD php artisan config:clear && (php artisan migrate --force || true) && php artisan serve --host=0.0.0.0 --port=${PORT:-8080}
