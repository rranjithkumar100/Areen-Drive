#!/bin/sh
set -e

mkdir -p \
  storage/app/uploads \
  storage/app/temp/zips \
  storage/tus \
  storage/framework/cache/data \
  storage/framework/sessions \
  storage/framework/views \
  storage/logs \
  bootstrap/cache \
  public/storage/branding-images

chmod -R 775 storage bootstrap/cache public/storage 2>/dev/null || true

php artisan config:clear
php artisan migrate --force || true

exec php artisan serve --host=0.0.0.0 --port="${PORT:-8080}"
