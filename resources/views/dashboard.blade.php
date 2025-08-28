<!DOCTYPE html>
<html>
<head>
    <title>Dashboard Institucional</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
        a { color: #007bff; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>📊 Dashboard Institucional</h1>
    <p>Reportes generados por el sistema:</p>

    @php
        $reportes = [];
        $ruta = public_path('reportes');
        if (file_exists($ruta)) {
            $archivos = scandir($ruta);
            foreach ($archivos as $archivo) {
                if (str_ends_with($archivo, '.html')) {
                    $reportes[] = $archivo;
                }
            }
        }
    @endphp

    @if(count($reportes) > 0)
        <table>
            <tr>
                <th>Archivo</th>
                <th>Acción</th>
            </tr>
            @foreach($reportes as $reporte)
                <tr>
                    <td>{{ $reporte }}</td>
                    <td><a href="{{ asset('reportes/' . $reporte) }}" target="_blank">🔍 Ver reporte</a></td>
                </tr>
            @endforeach
        </table>
    @else
        <p>⚠️ No se encontraron reportes generados.</p>
    @endif
</body>
</html>