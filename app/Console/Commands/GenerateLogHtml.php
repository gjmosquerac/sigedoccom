<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\File;

class GenerateLogHtml extends Command
{
    protected $signature = 'generate:log-html';
    protected $description = 'Genera un HTML institucional limpio con el contenido del log';

    public function handle()
    {
        $logPath = storage_path('logs/insta-automation-run.log');
        $htmlPath = public_path('reports/log.html');
        $timestamp = now()->format('d/m/Y H:i:s');

        if (!File::exists($logPath)) {
            $this->error('❌ No se encontró el archivo de log.');
            return;
        }

        $rawLog = File::get($logPath);

        // 🧼 Eliminar códigos ANSI correctamente
        $cleanLog = preg_replace('/\x1B

\[[0-9;]*[mK]/', '', $rawLog);

        // 🧱 Generar HTML limpio y profesional
        $html = "<html><head><title>Log Institucional</title>
        <style>
            body { font-family: monospace; background: #f9f9f9; padding: 20px; }
            h1 { color: #333; }
            pre { background: #fff; border: 1px solid #ccc; padding: 15px; overflow-x: auto; }
        </style>
        </head><body>";
        $html .= "<h1>Reporte generado: $timestamp</h1><pre>$cleanLog</pre></body></html>";

        File::ensureDirectoryExists(public_path('reports'));
        File::put($htmlPath, $html);

        Log::channel('insta')->info("[$timestamp] ✅ HTML limpio generado en public/reports/log.html");

        $this->info('✅ HTML institucional generado correctamente');
    }
}
