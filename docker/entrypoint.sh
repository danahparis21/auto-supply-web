#!/bin/sh
set -e

# Create storage directory structure if not exists
mkdir -p /var/www/html/storage/framework/cache /var/www/html/storage/framework/sessions /var/www/html/storage/framework/views /var/www/html/storage/logs /var/www/html/bootstrap/cache

# Ensure proper permissions
chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Create SQLite database file if DB_CONNECTION is sqlite and file doesn't exist
if [ "${DB_CONNECTION}" = "sqlite" ] || [ -z "${DB_CONNECTION}" ]; then
    touch /var/www/html/database/database.sqlite
    chown www-data:www-data /var/www/html/database/database.sqlite
    chmod 664 /var/www/html/database/database.sqlite
fi

# Link storage
php artisan storage:link --force || true

# Run database migrations and seeders
php artisan migrate --force || true

# Run seeders if database is empty
php artisan db:seed --force || true

# Cache configs and routes for performance
php artisan config:cache || true
php artisan route:cache || true
php artisan view:cache || true

# Apache port configuration (Render dynamically sets $PORT, default 80 or 10000)
PORT_NUM=${PORT:-80}
sed -i "s/Listen 80/Listen ${PORT_NUM}/g" /etc/apache2/ports.conf
sed -i "s/<VirtualHost \*:80>/<VirtualHost \*:${PORT_NUM}>/g" /etc/apache2/sites-available/000-default.conf

# Start Apache in foreground
exec apache2-foreground

