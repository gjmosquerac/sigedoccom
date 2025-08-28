<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>@yield('title', 'SIGEDOCCOM')</title>
  <style>
    body {
      margin: 0;
      padding: 0 40px;
      font-family: Arial, sans-serif;
      background: #f5f5f5 url('{{ public_path("images/pattern-military.png") }}') repeat;
      color: #333;
    }
    header {
      position: relative;
      height: 120px;
      margin-bottom: 20px;
    }
    .logo-left, .logo-right {
      position: absolute;
      top: 0;
      width: 120px;
      height: 120px;
    }
    .logo-left { left: 0; }
    .logo-right { right: 0; }
    .logo-left img, .logo-right img {
      width: 100%;
      height: auto;
    }
    .header-center {
      text-align: center;
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      padding-top: 20px;
    }
    .header-center h1 {
      margin: 0;
      font-size: 18px;
      font-weight: bold;
      color: #2E4A2B;
    }
    .header-center p {
      margin: 4px 0;
      font-size: 12px;
    }
    main {
      margin-top: 140px;
    }
  </style>
</head>
<body>
  <header>
    <div class="logo-left">
      <img src="{{ public_path('images/logo-izquierdo.png') }}" alt="Logo Izquierdo">
    </div>
    <div class="logo-right">
      <img src="{{ public_path('images/logo-derecho.png') }}" alt="Logo Derecho">
    </div>
    <div class="header-center">
      <h1>FUERZA ARMADA NACIONAL BOLIVARIANA</h1>
      <p>Centro de Comunicaciones · Estado Carabobo</p>
      <p>SIGEDOCCOM – Gestión Documental Blindada</p>
    </div>
  </header>
  <main>
    @yield('content')
  </main>
</body>
</html>
