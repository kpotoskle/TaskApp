# Utiliser une image PHP officielle avec les extensions requises
FROM php:8.1-fpm

# Installer les dépendances du système
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl \
    libpq-dev

# Installer les extensions PHP requises
RUN docker-php-ext-install pdo pdo_mysql pdo_pgsql mbstring exif pcntl bcmath gd

# Installer Composer
COPY --from=composer:2.1 /usr/bin/composer /usr/bin/composer

# Définir le répertoire de travail
WORKDIR /var/www

# Copier les fichiers de l'application
COPY . .

# Installer les dépendances PHP
RUN composer install --no-dev --optimize-autoloader

# Copier le fichier d'exécution de l'entrée de conteneur
COPY docker-entrypoint.sh /usr/local/bin/

# Donner les permissions d'exécution au script d'entrée
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Exposer le port 8000 et définir le script d'entrée
EXPOSE 8000
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["php-fpm"]
