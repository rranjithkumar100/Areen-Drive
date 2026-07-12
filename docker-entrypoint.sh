#!/bin/sh
set -e

export DISABLE_CSRF="${DISABLE_CSRF:-true}"

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

if [ -d demo-storage/uploads ]; then
  cp -Rn demo-storage/uploads/. storage/app/uploads/ 2>/dev/null || true
fi

if [ -d demo-storage/branding-images ]; then
  cp -Rn demo-storage/branding-images/. public/storage/branding-images/ 2>/dev/null || true
fi

php artisan config:clear
php artisan cache:clear
php artisan migrate --force || true
php artisan app:fix-upload-backends

exec php artisan serve --host=0.0.0.0 --port="${PORT:-8080}"
