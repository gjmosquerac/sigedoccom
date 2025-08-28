<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

class LogFactory extends Factory
{
    public function definition(): array
    {
        return [
            'user' => $this->faker->email,
            'ip' => $this->faker->ipv4,
            'agent' => $this->faker->userAgent,
            'timestamp' => now(),
            'evento' => '🧪 Evento simulado institucional',
        ];
    }
}
