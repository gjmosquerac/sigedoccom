#!/bin/bash
# 🧠 Script institucional para Laravel schedule + HTML + log

PROJECT_PATH="/c/xampp/htdocs/insta-automation"
LOG_PATH="$PROJECT_PATH/storage/logs/insta-automation-run.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$TIMESTAMP] 🚀 Ejecutando Laravel schedule:run" >> "$LOG_PATH"
cd "$PROJECT_PATH" || exit
php artisan schedule:run >> "$LOG_PATH" 2>&1

echo "[$TIMESTAMP] 🧱 Generando HTML institucional" >> "$LOG_PATH"
php artisan generate:log-html >> "$LOG_PATH" 2>&1

echo "[$TIMESTAMP] ✅ Flujo completo ejecutado" >> "$LOG_PATH"
