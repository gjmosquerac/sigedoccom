#!/bin/bash

# ┌───────────────────────────────────────────────┐
# │ Script institucional: SIGEDOCCOM completo     │
# │ Autor: Guillermo Mosquera                    │
# │ Función: Generar base operativa defendible   │
# └───────────────────────────────────────────────┘

MODEL="Documento"
CONTROLLER="${MODEL}Controller"
REQUEST="${MODEL}Request"
POLICY="${MODEL}Policy"
MIGRATION="create_${MODEL,,}s_table"
SEEDER="${MODEL}Seeder"
FACTORY="${MODEL}Factory"
VIEW_DIR="resources/views/${MODEL,,}s"
LAYOUT="layouts/militar"

echo "🔧 Generando modelo, migración, factory y seeder..."
php artisan make:model $MODEL -mf

echo "🛡️ Generando FormRequest..."
php artisan make:request $REQUEST

echo "📜 Generando Policy..."
php artisan make:policy $POLICY --model=$MODEL

echo "📦 Generando Resource Controller..."
php artisan make:controller $CONTROLLER --resource --model=$MODEL

echo "🧱 Generando vistas con layout militar..."
mkdir -p $VIEW_DIR
touch $VIEW_DIR/index.blade.php
touch $VIEW_DIR/create.blade.php
touch $VIEW_DIR/edit.blade.php
touch $VIEW_DIR/show.blade.php

for view in index create edit show; do
  echo "@extends('$LAYOUT')" > $VIEW_DIR/$view.blade.php
  echo "@section('contenido')" >> $VIEW_DIR/$view.blade.php
  echo "<h1>$view de $MODEL</h1>" >> $VIEW_DIR/$view.blade.php
  echo "@endsection" >> $VIEW_DIR/$view.blade.php
done

echo "🧭 Agregando ruta protegida..."
ROUTE="Route::resource('${MODEL,,}s', $CONTROLLER::class)->middleware(['auth']);"
echo $ROUTE >> routes/web.php

echo "🌱 Generando Seeder institucional..."
php artisan make:seeder $SEEDER

echo "✅ Script completado. Ejecuta 'php artisan migrate --seed' para aplicar."
