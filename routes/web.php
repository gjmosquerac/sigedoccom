<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Http;

// Ruta raíz con vista institucional
Route::get('/', function () {
    return view('welcome'); // Asegúrate de tener welcome.blade.php en resources/views
});

// Dashboard institucional
Route::get('/dashboard', function () {
    return view('dashboard'); // Asegúrate de tener dashboard.blade.php
})->name('dashboard');

// Login institucional con generación de reporte HTML trazable
Route::get('/login-test', function () {
    $email = 'gjmosquerac@gmail.com';
    $password = 'Laravel$2025';

    if (Auth::attempt(['email' => $email, 'password' => $password])) {
        $usuario = Auth::user()->name ?? 'Guillermo Mosquera';
        $accion = 'Login institucional exitoso';
        $timestamp = now()->format('Y-m-d_H-i-s');

        $html = view('reportes.login', compact('usuario', 'accion', 'timestamp'))->render();

        $directorio = public_path('reportes');
        File::ensureDirectoryExists($directorio);
        $nombreArchivo = "$usuario-$timestamp.html";
        File::put("$directorio/$nombreArchivo", $html);

        session(['ultimo_reporte' => $nombreArchivo]);

        return "✅ Login exitoso. Reporte generado: $nombreArchivo";
    }

    return '❌ Fallo en login institucional';
});

// Envío del último reporte generado por WhatsApp
Route::get('/enviar-reporte-whatsapp', function () {
    $archivo = session('ultimo_reporte');
    if (!$archivo) return '❌ No hay reporte generado en esta sesión';

    $ruta = public_path("reportes/$archivo");
    if (!file_exists($ruta)) return '❌ Archivo no encontrado: ' . $archivo;

    $contenido = file_get_contents($ruta);
    $mensaje = urlencode("📄 Reporte institucional:\n\n" . strip_tags($contenido));

    $response = Http::post('https://api.callmebot.com/whatsapp.php', [
        'phone' => '584XXXXXXXXX', // Número del grupo operativo
        'text' => $mensaje,
        'apikey' => 'tu_api_key_callmebot'
    ]);

    return $response->successful()
        ? "✅ Reporte enviado por WhatsApp: $archivo"
        : "❌ Error al enviar: " . $response->body();
});

// Rutas funcionales adicionales
Route::get('/reportes', function () {
    return '📁 Reportes archivados disponibles';
});

Route::get('/logs', function () {
    return '📜 Logs institucionales activos';
});
Route::resource('documentos', DocumentoController::class)->middleware(['auth']);
Route::resource('documentos', DocumentoController::class)->middleware(['auth']);
