#!/usr/bin/env bash

case "$1" in
  up) docker-compose up -d ;;
  down) docker-compose down ;;
  composer) docker exec app composer install ;;
  migrate) docker exec app php artisan migrate ;;
  ssh) docker exec -it app bash ;;
  logs) docker-compose logs -f ;;
  db) docker exec -it db mysql -uroot -p ;;
  npm) docker exec app npm install ;;
  tests) docker exec app php artisan test ;;
  *) echo "Uso: $0 {up|down|composer|migrate|ssh|logs|db|npm|tests}" ;;
esac
