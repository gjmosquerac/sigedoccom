#!/bin/bash

echo "🔧 Iniciando puesta en marcha institucional..."

# Paso 1: Copiar .env limpio
cp .env.example .env

# Paso 2: Reemplazar SQLite por MySQL en .env
sed -i 's/DB_CONNECTION=sqlite/DB_CONNECTION=mysql/' .env
sed -i 's/# DB_HOST=/DB_HOST=127.0.0.1/' .env
sed -i 's/# DB_PORT=/DB_PORT=3306/' .env
sed -i 's/# DB_DATABASE=/DB_DATABASE=laravel/' .env
sed -i 's/# DB_USERNAME=/DB_USERNAME=root/' .env
sed -i 's/# DB_PASSWORD=/DB_PASSWORD=/' .env

echo "✅ .env configurado con MySQL"

# Paso 3: Instalar dependencias
composer install

# Paso 4: Generar clave
php artisan key:generate

# Paso 5: Migrar base de datos
php artisan migrate

# Paso 6: Levantar servidor
php artisan serve
