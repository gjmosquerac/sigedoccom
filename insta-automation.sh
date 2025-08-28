#!/bin/bash

FECHA=$(date +"%Y-%m-%d")
CARPETA="Interacciones_$FECHA"
mkdir -p "$CARPETA"
LOG="$CARPETA/log_interacciones_$FECHA.txt"
touch "$LOG"

shopt -s nullglob
IMAGENES=(*.png)
if [ ${#IMAGENES[@]} -eq 0 ]; then
  echo "⚠️ No se encontraron archivos .png en el directorio actual."
  exit 1
fi

i=1
for IMG in "${IMAGENES[@]}"; do
  echo "Procesando $IMG..."
  read -p "👤 Usuario asociado: " USUARIO
  read -p "📝 Acción (like, comentario, etiqueta): " ACCION
  NUEVO_NOMBRE=$(printf "%02d_%s_%s.png" "$i" "$USUARIO" "$ACCION")
  mv "$IMG" "$CARPETA/$NUEVO_NOMBRE"
  echo "$NUEVO_NOMBRE – Usuario: $USUARIO – Acción: $ACCION" >> "$LOG"
  ((i++))
done

echo "✅ Capturas organizadas en carpeta: $CARPETA"
echo "🗂️ Log institucional generado: $LOG"
#!/bin/bash

# 📍 Detectar ruta base del script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CAPTURES_DIR="$SCRIPT_DIR/captures"
PROCESADAS_DIR="$CAPTURES_DIR/procesadas"
FECHA=$(date +"%Y-%m-%d")
CARPETA="$SCRIPT_DIR/Interacciones_$FECHA"
LOG="$CARPETA/log_interacciones_$FECHA.txt"

# 📁 Preparar carpetas
mkdir -p "$CARPETA"
mkdir -p "$PROCESADAS_DIR"
touch "$LOG"

# 📸 Buscar imágenes en captures/
shopt -s nullglob
IMAGENES=("$CAPTURES_DIR"/*.png)
if [ ${#IMAGENES[@]} -eq 0 ]; then
  echo "⚠️ No se encontraron archivos .png en la carpeta '$CAPTURES_DIR'."
  exit 1
fi

# 🔄 Procesar imágenes
i=1
for IMG in "${IMAGENES[@]}"; do
  echo "Procesando $(basename "$IMG")..."
  read -p "👤 Usuario asociado: " USUARIO
  read -p "📝 Acción (like, comentario, etiqueta): " ACCION
  NUEVO_NOMBRE=$(printf "%02d_%s_%s.png" "$i" "$USUARIO" "$ACCION")
  mv "$IMG" "$CARPETA/$NUEVO_NOMBRE"
  cp "$CARPETA/$NUEVO_NOMBRE" "$PROCESADAS_DIR/$NUEVO_NOMBRE"
  echo "$NUEVO_NOMBRE – Usuario: $USUARIO – Acción: $ACCION – Original: $(basename "$IMG")" >> "$LOG"
  ((i++))
done

# ✅ Confirmación
echo "✅ Capturas procesadas y movidas a '$PROCESADAS_DIR'"
echo "🗂️ Log institucional generado: $LOG"
