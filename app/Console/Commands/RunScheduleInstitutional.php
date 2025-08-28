<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Artisan;
use Illuminate\Support\Facades\Log;

class RunScheduleInstitutional extends Command
{
    /**
     * Nombre del comando Artisan.
     */
    protected $signature = 'run:schedule-institutional';

    /**
     * Descripción institucional del comando.
     */
    protected $description = 'Ejecuta schedule:run con logging institucional y trazabilidad completa';

    /**
     * Lógica principal del comando.
     */
    public function handle()
    {
        $timestamp = now()->format('d/m/Y H:i:s');

        // 🚀 Inicio de ejecución
        Log::channel('insta')->info("[$timestamp] 🚀 Ejecutando Laravel schedule:run");

        // Ejecutar schedule:run y capturar salida
        Artisan::call('schedule:run');
        $output = Artisan::output();

        // Registrar cada línea de salida como [INFO]
        foreach (explode("\n", $output) as $line) {
            $line = trim($line);
            if ($line !== '') {
                Log::channel('insta')->info("[INFO] $line");
            }
        }

        // ✅ Fin de ejecución
        $timestamp = now()->format('d/m/Y H:i:s');
        Log::channel('insta')->info("[$timestamp] ✅ schedule:run completado");

        // Mostrar en consola
        $this->info('✅ schedule:run ejecutado con logging institucional');
    }
}
