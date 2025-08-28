#!/bin/bash

# ┌────────────────────────────────────────────────────────┐
# │ INSTALACIÓN PLUG-AND-PLAY – SIGEDOCCOM                 │
# │ Autor: Guillermo Mosquera                              │
# │ Función: Instalar, configurar y blindar SIGEDOCCOM     │
# └────────────────────────────────────────────────────────┘

echo "🧱 Clonando repositorio SIGEDOCCOM..."
git clone https://github.com/fanb/sigedoccom.git
cd sigedoccom || exit

echo "🔧 Configurando entorno..."
cp .env.example .env
php artisan key:generate

echo "🛠️ Editando .env con credenciales..."
sed -i 's/DB_DATABASE=.*/DB_DATABASE=sigedoccom/' .env
sed -i 's/DB_USERNAME=.*/DB_USERNAME=root/' .env
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=tuclave/' .env

echo "🗄 Migrando base de datos..."
php artisan migrate

echo "📦 Instalando dependencias..."
composer install
npm install && npm run build

echo "🚀 Activando logs y reporting..."
php artisan vendor:publish --tag=laravel-log
php artisan storage:link

echo "📤 Activando exportación de reportes..."
composer require maatwebsite/excel

echo "📲 Configurando integración multicanal..."
echo "WHATSAPP_API=https://api.whatsapp.com/send" >> .env
echo "TELEGRAM_API=https://api.telegram.org/botXXXX/sendMessage" >> .env

echo "🧠 Generando usuarios institucionales..."
php artisan make:seeder UsuarioSeeder
php artisan db:seed --class=UsuarioSeeder

echo "🖥 Iniciando servidor local..."
php artisan serve

echo "🧪 Ejecutando prueba funcional..."
curl -X POST http://localhost:8000/documentos \
-H "Content-Type: application/json" \
-d '{"tipo":"entrada","grupo":"G1","serial":"DOC-001","fecha_hora":"2025-08-27 11:00:00"}'

echo "✅ SIGEDOCCOM instalado y blindado con éxito. Accede vía: http://localhost:8000"
