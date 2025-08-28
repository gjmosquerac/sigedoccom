<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Log;

class AdminUserSeeder extends Seeder
{
    public function run()
    {
        $user = User::firstOrCreate(
            ['email' => 'admin@institucional.com'],
            [
                'name' => 'Admin',
                'password' => bcrypt('admin123'),
            ]
        );

        Log::info('✅ Usuario institucional creado', [
            'id' => $user->id,
            'email' => $user->email,
            'timestamp' => now()->toDateTimeString(),
        ]);

        echo "✅ Usuario institucional creado: {$user->email}\n";
    }
}
