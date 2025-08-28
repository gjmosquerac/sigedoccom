<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Envio;
use GuzzleHttp\Client;

class ReporteController extends Controller
{
    public function enviarResumen(Request $request)
    {
        $numero = $request->input('numero');
        $archivo = storage_path('app/resumen.txt');

        if (!file_exists($archivo)) {
            return back()->with('error', 'Archivo no encontrado');
        }

        $body = file_get_contents($archivo);

        $sid = env('TWILIO_SID');
        $token = env('TWILIO_TOKEN');
        $from = 'whatsapp:+14155238886';

        $client = new Client();
        $response = $client->post("https://api.twilio.com/2010-04-01/Accounts/$sid/Messages.json", [
            'auth' => [$sid, $token],
            'form_params' => [
                'Body' => $body,
                'From' => $from,
                'To' => "whatsapp:$numero"
            ]
        ]);

        Envio::create([
            'numero' => $numero,
            'estado' => 'Enviado',
            'respuesta' => $response->getBody()
        ]);

        return back()->with('success', 'Resumen enviado por WhatsApp');
    }

    // ✅ Método separado, funcional y trazable
    public function mostrar()
    {
        $archivo = 'test_reporte.html'; // Debe estar en /public/reportes/
        $url_reporte = url('reportes/' . $archivo);

        $mensaje = urlencode("📊 Nuevo reporte institucional:\n$url_reporte\n\n¿Validado por redes?");
        $enlace = "https://wa.me/?text=$mensaje";

        return view('reportes.vista', compact('url_reporte', 'enlace'));
    }
}
