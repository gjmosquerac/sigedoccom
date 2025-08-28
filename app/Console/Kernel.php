<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

// Comandos personalizados institucionales
use App\Console\Commands\SendLogWhatsApp;
use App\Console\Commands\GenerateLogHtml;
use App\Console\Commands\RunScheduleInstitutional;
use App\Console\Commands\GenerarReporte;

class Kernel extends ConsoleKernel
{
    /**
     * Registro de comandos institucionales.
     */
    protected $commands = [
    // Comandos de reporting multicanal
    SendLogWhatsApp::class,
    GenerateLogHtml::class,

    // Comando institucional de ejecución programada
    RunScheduleInstitutional::class,

    // Comando de generación de reporte HTML
    GenerarReporte::class,    ];

    /**
     * Programación de tareas automáticas.
     */
    protected function schedule(Schedule $schedule): void
    {
        // Ejecutar cada minuto
        $schedule->command('send:log-whatsapp')->everyMinute();

        // Generar HTML cada hora
        $schedule->command('generate:log-html')->hourly();
    }

    /**
     * Carga de comandos disponibles en Artisan.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');
        require base_path('routes/console.php');
    }
}

