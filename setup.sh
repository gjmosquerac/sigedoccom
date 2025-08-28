#!/usr/bin/env bash
set -euo pipefail

# 1. Generar docker-compose.yml
cat > docker-compose.yml << 'EOF'
services:
  web:
    image: php:8.1-apache
    container_name: insta-web
    ports:
      - "8081:80"
    volumes:
      - ./:/var/www/html
    depends_on:
      - db

  db:
    image: mariadb:10.4
    container_name: insta-db
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: rootpass
      MYSQL_DATABASE: laravel
      MYSQL_USER: laravel
      MYSQL_PASSWORD: secret
    volumes:
      - db_data:/var/lib/mysql

  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    container_name: insta-pma
    restart: always
    ports:
      - "8082:80"
    environment:
      PMA_HOST: db
      PMA_PORT: 3306

volumes:
  db_data:
EOF

# 2. Levantar/reiniciar Docker
docker compose down --remove-orphans
docker compose up -d --build

# 3. Verificar estado
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}"

# 4. Preparar Laravel
cp .env.example .env
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=db/' .env

docker compose exec web composer install --no-interaction --optimize-autoloader
docker compose exec web php artisan key:generate
docker compose exec web php artisan migrate --force
docker compose exec web php artisan storage:link

# 5. Mostrar logs del contenedor web
docker compose logs -f web
