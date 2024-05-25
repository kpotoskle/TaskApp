#!/bin/sh

# Si la variable d'environnement APP_ENV est définie à 'local', exécuter les migrations et les seeders
if [ "$APP_ENV" != 'production' ]; then
    php artisan migrate --force
    php artisan db:seed --force
fi

# Lancer le serveur PHP-FPM
exec "$@"
