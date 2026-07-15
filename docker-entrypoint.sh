#!/bin/sh
set -e

export DISABLE_CSRF="${DISABLE_CSRF:-true}"

# Railway blocks outbound SMTP on non-Pro plans; use Brevo HTTPS API instead.
export OUTGOING_EMAIL_ENABLED=true
export MAIL_MAILER=brevo
export BREVO_API_KEY="${BREVO_API_KEY:-}"
export MAIL_FROM_ADDRESS="${MAIL_FROM_ADDRESS:-rranjithkumar100@gmail.com}"
export MAIL_FROM_NAME="${MAIL_FROM_NAME:-Areen}"
export MAIL_SETUP=true
export ADMIN_EMAIL="${ADMIN_EMAIL:-rranjithkumar100@gmail.com}"

upsert_env() {
  key="$1"
  value="$2"
  if [ -z "$value" ]; then
    return 0
  fi
  if [ -f .env ] && grep -q "^${key}=" .env; then
    sed -i "s|^${key}=.*|${key}=${value}|" .env
  elif [ -f .env ]; then
    printf '%s=%s\n' "$key" "$value" >> .env
  fi
}

# Railway injects env vars but does not create a .env file; admin settings need one.
if [ ! -f .env ] && [ -f .env.example ]; then
  : > .env
  grep -E '^[A-Z][A-Z0-9_]*=' .env.example | cut -d= -f1 | while read -r key; do
    val=$(printenv "$key" || true)
    if [ -n "$val" ]; then
      printf '%s=%s\n' "$key" "$val" >> .env
    fi
  done
fi

# .env is not baked into the image (.dockerignore); always apply mail settings at boot.
if [ -f .env ]; then
  upsert_env OUTGOING_EMAIL_ENABLED "$OUTGOING_EMAIL_ENABLED"
  upsert_env MAIL_MAILER "$MAIL_MAILER"
  upsert_env MAIL_FROM_ADDRESS "$MAIL_FROM_ADDRESS"
  upsert_env MAIL_FROM_NAME "$MAIL_FROM_NAME"
  upsert_env MAIL_SETUP "$MAIL_SETUP"
  if [ -n "$BREVO_API_KEY" ]; then
    upsert_env BREVO_API_KEY "$BREVO_API_KEY"
  fi
fi

php -r "
\$file = '.env';
if (!file_exists(\$file)) {
    return;
}
\$vars = [
    'MAIL_MAILER' => getenv('MAIL_MAILER') ?: 'brevo',
    'BREVO_API_KEY' => getenv('BREVO_API_KEY') ?: '',
    'MAIL_FROM_ADDRESS' => getenv('MAIL_FROM_ADDRESS') ?: '',
    'MAIL_FROM_NAME' => getenv('MAIL_FROM_NAME') ?: '',
    'OUTGOING_EMAIL_ENABLED' => getenv('OUTGOING_EMAIL_ENABLED') ?: 'true',
    'MAIL_SETUP' => getenv('MAIL_SETUP') ?: 'true',
];
\$lines = file_exists(\$file) ? file(\$file, FILE_IGNORE_NEW_LINES) : [];
\$out = [];
\$seen = [];
foreach (\$lines as \$line) {
    if (!preg_match('/^([A-Z0-9_]+)=/', \$line, \$m)) {
        \$out[] = \$line;
        continue;
    }
    \$key = \$m[1];
    if (isset(\$vars[\$key]) && \$vars[\$key] !== '') {
        \$out[] = \$key . '=' . \$vars[\$key];
        \$seen[\$key] = true;
    } else {
        \$out[] = \$line;
    }
}
foreach (\$vars as \$key => \$value) {
    if (\$value !== '' && empty(\$seen[\$key])) {
        \$out[] = \$key . '=' . \$value;
    }
}
file_put_contents(\$file, implode(PHP_EOL, \$out) . PHP_EOL);
" || true

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

php -r "
require 'vendor/autoload.php';
\$app = require 'bootstrap/app.php';
\$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
\$key = getenv('BREVO_API_KEY') ?: env('BREVO_API_KEY');
echo 'mail_mailer=' . (getenv('MAIL_MAILER') ?: env('MAIL_MAILER')) . PHP_EOL;
echo 'brevo_api_key=' . (\$key ? 'set' : 'MISSING') . PHP_EOL;
" || true

if [ -n "$ADMIN_EMAIL" ]; then
  php -r "
require 'vendor/autoload.php';
\$app = require 'bootstrap/app.php';
\$app->make(Illuminate\Contracts\Console\Kernel::class)->bootstrap();
\$email = getenv('ADMIN_EMAIL');
if (!\$email) {
    return;
}
\$updated = Illuminate\Support\Facades\DB::table('users')
    ->where('id', 1)
    ->update(['email' => \$email, 'name' => 'Areen', 'updated_at' => now()]);
if (!\$updated) {
    \$updated = Illuminate\Support\Facades\DB::table('users')
        ->where('email', 'admin@admin.com')
        ->orWhere('email', \$email)
        ->update(['email' => \$email, 'name' => 'Areen', 'updated_at' => now()]);
}
echo \$updated ? \"Set admin user email to \$email\n\" : \"Admin email unchanged\n\";
" || true
fi

exec php artisan serve --host=0.0.0.0 --port="${PORT:-8080}"
