<?php

use Illuminate\Support\Facades\Auth;

$email = 'gjmosquerac@gmail.com';
$password = 'Laravel$2025';

if (Auth::attempt(['email' => $email, 'password' => $password])) {
    echo "✅ Login institucional exitoso";
} else {
    echo "❌ Fallo en login institucional";
}
