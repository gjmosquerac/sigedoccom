@echo off
set PROJECT_PATH=C:\xampp\htdocs\insta-automation
set LOG_PATH=%PROJECT_PATH%\storage\logs\insta-automation-run.log
set HTML_PATH=%PROJECT_PATH%\storage\logs\insta-log.html

echo [%DATE% %TIME%] 🚀 Ejecutando Laravel schedule:run >> "%LOG_PATH%"
cd /d "%PROJECT_PATH%"
php artisan schedule:run >> "%LOG_PATH%" 2>&1

echo [%DATE% %TIME%] 🧱 Generando HTML institucional >> "%LOG_PATH%"
php artisan generate:log-html >> "%LOG_PATH%" 2>&1

echo [%DATE% %TIME%] 🌐 Abriendo HTML institucional >> "%LOG_PATH%"
start "" "%HTML_PATH%"
