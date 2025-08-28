@echo off
:: 🧠 Script institucional para ejecutar schedule:run y generar HTML

set PROJECT_PATH=C:\xampp\htdocs\insta-automation
set LOG_PATH=%PROJECT_PATH%\storage\logs\insta-automation-run.log
set TIMESTAMP=%DATE% %TIME%

echo [%TIMESTAMP%] 🚀 Ejecutando Laravel schedule:run >> "%LOG_PATH%"
cd /d %PROJECT_PATH%
php artisan schedule:run >> "%LOG_PATH%" 2>&1

echo [%TIMESTAMP%] 🧱 Generando HTML institucional >> "%LOG_PATH%"
php artisan generate:log-html >> "%LOG_PATH%" 2>&1

echo [%TIMESTAMP%] ✅ Flujo completo ejecutado >> "%LOG_PATH%"
