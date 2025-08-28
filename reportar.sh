#!/bin/bash

LOG_DIR="./logs"
OUTPUT="resumen.txt"

echo "📝 Reporte institucional - $(date)" > "$OUTPUT"
echo "----------------------------------" >> "$OUTPUT"

if [ -d "$LOG_DIR" ]; then
  for file in "$LOG_DIR"/*.log; do
    echo "📁 Log: $(basename "$file")" >> "$OUTPUT"
    tail -n 5 "$file" >> "$OUTPUT"
    echo "----------------------------------" >> "$OUTPUT"
  done
else
  echo "❌ Carpeta de logs no encontrada: $LOG_DIR" >> "$OUTPUT"
fi

echo "✅ Reporte generado: $OUTPUT"

