FROM node:20-bookworm AS assets

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm ci

COPY . .
RUN npm run build

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

RUN printf "upload_max_filesize=512M\npost_max_size=512M\nmemory_limit=512M\nmax_execution_time=300\n" \
    > /usr/local/etc/php/conf.d/uploads.ini

COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

COPY composer.json composer.lock ./
RUN composer install --no-dev --optimize-autoloader --no-interaction --no-scripts --ignore-platform-req=ext-ftp

COPY . .

COPY --from=assets /app/public/build ./public/build

RUN composer install --no-dev --optimize-autoloader --no-interaction --ignore-platform-req=ext-ftp \
    && mkdir -p \
        storage/app/uploads \
        storage/app/temp/zips \
        storage/tus \
        storage/framework/cache/data \
        storage/framework/sessions \
        storage/framework/views \
        storage/logs \
        bootstrap/cache \
        public/storage/branding-images \
    && cp -R demo-storage/uploads/. storage/app/uploads/ \
    && cp -R demo-storage/branding-images/. public/storage/branding-images/ \
    && chmod -R 775 storage bootstrap/cache public/storage \
    && chmod +x docker-entrypoint.sh

ENV PORT=8080
ENV DISABLE_CSRF=true
EXPOSE 8080

CMD ["./docker-entrypoint.sh"]
