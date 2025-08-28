#!/bin/bash

FECHA=$(date +"%Y-%m-%d")
CARPETA="Interacciones_$FECHA"
mkdir -p "$CARPETA"
LOG="$CARPETA/log_interacciones_$FECHA.txt"
touch "$LOG"

ORIGEN="captures"
DESTINO="$CARPETA"
PROCESADAS="$ORIGEN/procesadas"
mkdir -p "$PROCESADAS"

shopt -s nullglob
IMAGENES=("$ORIGEN"/*.png)
if [ ${#IMAGENES[@]} -eq 0 ]; then
  echo "⚠️ No se encontraron archivos .png en la carpeta '$ORIGEN'."
  exit 1
fi

i=1
for IMG in "${IMAGENES[@]}"; do
  echo "Procesando $IMG..."
  read -p "👤 Usuario asociado: " USUARIO
  read -p "📝 Acción (like, comentario, etiqueta): " ACCION
  BASENAME=$(basename "$IMG")
  NUEVO_NOMBRE=$(printf "%02d_%s_%s.png" "$i" "$USUARIO" "$ACCION")
  mv "$IMG" "$DESTINO/$NUEVO_NOMBRE"
  mv "$DESTINO/$NUEVO_NOMBRE" "$PROCESADAS/$NUEVO_NOMBRE"
  echo "$NUEVO_NOMBRE – Usuario: $USUARIO – Acción: $ACCION – Original: $BASENAME" >> "$LOG"
  ((i++))
done

echo "✅ Capturas procesadas y movidas a '$PROCESADAS'"
echo "🗂️ Log institucional generado: $LOG"
#!/bin/bash

# 📍 Detectar ruta base del proyecto
BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
CAPTURES_DIR="$BASE_DIR/captures"
PROCESADAS_DIR="$CAPTURES_DIR/procesadas"
FECHA=$(date +"%Y-%m-%d")
CARPETA="$BASE_DIR/Interacciones_$FECHA"
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
