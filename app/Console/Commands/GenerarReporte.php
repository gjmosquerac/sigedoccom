<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\File;

class GenerarReporte extends Command
{
    protected $signature = 'generar:reporte';
    protected $description = 'Genera y archiva el reporte institucional en HTML';

    public function handle()
    {
        $usuario = 'Guillermo Mosquera';
        $accion = 'Login institucional exitoso';
        $timestamp = now()->format('Y-m-d_H-i-s');

        $html = view('reportes.login', compact('usuario', 'accion', 'timestamp'))->render();

        $directorio = public_path('reportes');
        File::ensureDirectoryExists($directorio);

        $nombreArchivo = "$usuario-$timestamp.html";
        File::put("$directorio/$nombreArchivo", $html);

        $this->info("✅ Reporte generado: $nombreArchivo");
    }
}

