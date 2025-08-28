<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>@yield('title', 'SIGEDOCCOM')</title>
    <link rel="stylesheet" href="{{ asset('css/militar.css') }}">
</head>
<body>
    <header style="background:#2E4A2B; color:#fff; padding:10px; text-align:center;">
        <img src="{{ asset('images/logo_institucional.png') }}" alt="Logo" height="60">
        <h1>SIGEDOCCOM – Gestión Documental Militar</h1>
    </header>

    <main style="padding:20px;">
        @yield('contenido')
    </main>

    <footer style="background:#2E4A2B; color:#ccc; text-align:center; padding:5px; font-size:12px;">
        Plataforma blindada para defensa operativa y académica. © SIGEDOCCOM
    </footer>
</body>
</html>
