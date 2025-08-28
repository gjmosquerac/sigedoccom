#!/bin/bash

echo "🔍 Validando instalación de Breeze y rutas de autenticación..."

# Verificar si Breeze está instalado
if composer show laravel/breeze | grep -q "versions"; then
  echo "✅ Breeze está instalado"
else
  echo "❌ Breeze no está instalado. Ejecuta: composer require laravel/breeze --dev"
  exit 1
fi

# Verificar si la ruta login existe
if php artisan route:list | grep -q "login"; then
  echo "✅ Ruta [login] detectada"
else
  echo "❌ Ruta [login] no definida. Reinstala Breeze o revisa el archivo de rutas"
  exit 1
fi

# Verificar si migraciones están aplicadas
if php artisan migrate:status | grep -q "users"; then
  echo "✅ Migraciones aplicadas correctamente"
else
  echo "⚠️ Migraciones pendientes. Ejecuta: php artisan migrate"
fi

# Verificar si los assets están compilados
if [ -d "public/build" ]; then
  echo "✅ Assets compilados con Vite"
else
  echo "⚠️ Assets no compilados. Ejecuta: npm install && npm run dev"
fi

echo "🎯 Validación institucional completada. El flujo de login debería estar operativo."
