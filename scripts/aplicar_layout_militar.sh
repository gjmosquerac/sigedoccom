#!/bin/bash

echo "🎖️ Generando layout militar institucional..."
mkdir -p resources/views/layouts
cat <<EOL > resources/views/layouts/militar.blade.php
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
EOL

echo "🧵 Generando CSS institucional..."
mkdir -p public/css
cat <<EOL > public/css/militar.css
body {
    background-image: url('../images/fondo_militar.jpg');
    background-size: cover;
    background-attachment: fixed;
    font-family: 'Segoe UI', sans-serif;
    color: #1c1c1c;
}
h1 {
    text-transform: uppercase;
    border-bottom: 2px solid #444;
    padding-bottom: 5px;
}
EOL

echo "📁 Aplicando layout militar a vistas..."
for dir in documentos remisiones devoluciones status alertas; do
    mkdir -p resources/views/\$dir
    for view in index create edit show; do
        FILE="resources/views/\$dir/\$view.blade.php"
        echo "@extends('layouts.militar')" > \$FILE
        echo "@section('contenido')" >> \$FILE
        echo "<h1>\${view^} de \$dir</h1>" >> \$FILE
        echo "@endsection" >> \$FILE
    done
done

echo "📸 Verifica que tengas estos archivos en public/images/:"
echo " - logo_institucional.png"
echo " - fondo_militar.jpg"

echo "✅ Layout militar aplicado a todas las vistas. Branding institucional activo desde el primer render."
