# ── Stage 1: Build Frontend Assets ─────────────────────
FROM node:20-alpine AS node-builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# ── Stage 2: PHP Application Server ───────────────────
FROM php:8.3-apache

# Install required system packages and PHP extensions
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    unzip \
    libpng-dev \
    libjpeg-dev \
    libwebp-dev \
    libfreetype6-dev \
    libzip-dev \
    libsqlite3-dev \
    sqlite3 \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j$(nproc) \
        pdo_mysql \
        pdo_sqlite \
        bcmath \
        fileinfo \
        zip \
        gd \
        opcache \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Configure Apache DocumentRoot to point to Laravel's /public
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN echo "<Directory /var/www/html/public>\n    AllowOverride All\n    Require all granted\n</Directory>" >> /etc/apache2/apache2.conf

# Set working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Copy compiled frontend assets from node-builder
COPY --from=node-builder /app/public/build /var/www/html/public/build

# Install PHP production dependencies
RUN composer install --no-dev --optimize-autoloader --no-interaction

# Copy entrypoint script and set permissions
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose port (Render overrides with $PORT dynamically)
EXPOSE 80

ENTRYPOINT ["/entrypoint.sh"]

