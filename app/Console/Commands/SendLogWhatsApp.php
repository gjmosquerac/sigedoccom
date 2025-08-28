<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

class SendLogWhatsApp extends Command
{
    protected $signature = 'send:log-whatsapp';
    protected $description = 'Envía el log institucional por WhatsApp (simulado)';

    public function handle()
    {
        $timestamp = now()->format('d/m/Y H:i:s');

        // Simulación de envío por WhatsApp
        Log::channel('insta')->info("[$timestamp] ✅ Log enviado por WhatsApp");

        $this->info('✅ Log enviado por WhatsApp (simulado)');
    }
}
