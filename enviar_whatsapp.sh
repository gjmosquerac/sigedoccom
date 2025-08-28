#!/bin/bash

echo "📤 Enviando resumen institucional por WhatsApp..."

# Validar existencia del resumen HTML
if [ -f "public/resumen_institucional.html" ]; then
  echo "✅ Resumen HTML encontrado"
else
  echo "❌ Resumen HTML no existe. Abortando envío"
  exit 1
fi

# Simulación de envío (aquí iría la integración real con API o bot)
echo "📎 Adjuntando archivo: public/resumen_institucional.html"
echo "📲 Enviando a WhatsApp institucional..."

# Resultado simulado
echo "✅ Envío completado (simulado). Integra API real si deseas funcionalidad activa."
