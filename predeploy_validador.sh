#!/bin/bash

echo "🔍 Validando estado pre-deploy institucional..."

# Validar existencia del resumen HTML institucional
if [ -f "public/resumen_institucional.html" ]; then
  echo "✅ Resumen HTML institucional detectado"
else
  echo "❌ Resumen HTML no encontrado. Ejecuta el generador correspondiente"
  exit 1
fi

# Validar limpieza de logs ANSI
if grep -q $'\e' storage/logs/laravel.log; then
  echo "⚠️ Logs contienen caracteres ANSI. Ejecuta limpieza antes del deploy"
else
  echo "✅ Logs limpios y listos para reporting"
fi

# Validar existencia de script de envío por WhatsApp
if [ -f "enviar_whatsapp.sh" ]; then
  echo "✅ Script de envío por WhatsApp detectado"
else
  echo "❌ Script de WhatsApp no encontrado. Verifica integración multicanal"
  exit 1
fi

# Validar que el script de WhatsApp sea ejecutable
if [ -x "enviar_whatsapp.sh" ]; then
  echo "✅ Script WhatsApp tiene permisos de ejecución"
else
  echo "⚠️ Asignando permisos de ejecución al script WhatsApp..."
  chmod +x enviar_whatsapp.sh
fi

echo "🚀 Validación pre-deploy completada. Todo listo para puesta en marcha."
