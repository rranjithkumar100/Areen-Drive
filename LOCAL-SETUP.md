# Local setup (Herd + Docker MySQL)

## Prerequisites

- [Laravel Herd](https://herd.laravel.com) (PHP 8.2+)
- Docker Desktop (MySQL only)
- Node.js (for frontend dev; `public/build` is already committed)

## 1. Start MySQL

```sh
docker compose -f docker-compose.mysql.yml up -d
```

MySQL is exposed on `127.0.0.1:3307` (user `root`, password `root`, database `areen`).

## 2. Environment

```sh
cp .env.example .env
php artisan key:generate
```

## 3. Import database (first time)

```sh
docker compose -f docker-compose.mysql.yml exec -T mysql mysql -uroot -proot < areen.sql
```

## 4. Herd site

From this directory:

```sh
herd link areen --update-env
```

Open: **http://areen.test**

## 5. Laravel setup

```sh
composer install
php artisan storage:link
```

## Railway (later)

Deploy as a standard PHP Laravel app (Nixpacks). Use Railway MySQL addon and set `DB_*` from the dashboard. Build: `composer install --no-dev` and `npm ci && npm run build`. Web root: `public`.
