#!/usr/bin/env bash
set -euo pipefail

echo "🚀 Iniciando transformación SIGCOM → SIGEDOCCOM"

# Migraciones
php artisan make:migration createdocumentostable
php artisan make:migration createremisionestable
php artisan make:migration createdevolucionestable
php artisan make:migration createstatusdocumentos_table
php artisan make:migration createalertastable

# Modelos
php artisan make:model Documento
php artisan make:model Remision
php artisan make:model Devolucion
php artisan make:model StatusDocumento
php artisan make:model Alerta

# Controladores
php artisan make:controller DocumentoController --resource
php artisan make:controller RemisionController --resource
php artisan make:controller DevolucionController --resource
php artisan make:controller StatusController --resource
php artisan make:controller AlertaController --resource

# Vistas
mkdir -p resources/views/documentos
mkdir -p resources/views/remisiones
mkdir -p resources/views/devoluciones
mkdir -p resources/views/status
mkdir -p resources/views/alertas
touch resources/views/dashboard.blade.php
touch resources/views/alertas/index.blade.php

# Comando Artisan
php artisan make:command VerificarAlertas

# Registro en Kernel
sed -i "/protected \$commands = 

\[/a \ \ \ \ \App\\\Console\\\Commands\\\VerificarAlertas::class," app/Console/Kernel.php
sed -i "/protected function schedule(Schedule \$schedule): void {/a \ \ \ \ \$schedule->command('verificar:alertas')->everyFifteenMinutes();" app/Console/Kernel.php

# Migraciones
php artisan migrate

# Seeders
php artisan make:seeder DocumentoSeeder
php artisan make:seeder RemisionSeeder
php artisan make:seeder StatusSeeder
php artisan db:seed

# Reporte
php artisan generar:reporte

echo "📲 Accede a: http://localhost/enviar-reporte-whatsapp"
