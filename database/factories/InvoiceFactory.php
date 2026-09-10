<?php

namespace Database\Factories;

use App\Models\Invoice;
use App\Models\User;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Invoice>
 */
class InvoiceFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $total = fake()->randomFloat(2, 200, 5000);
        $payment = $total + fake()->randomFloat(2, 0, 500);

        return [
            'invoice_number' => 'INV-'.fake()->unique()->numerify('#####'),
            'total_sales' => $total,
            'customer_payment' => $payment,
            'customer_change' => round($payment - $total, 2),
            'date' => fake()->dateTimeBetween('-1 month', 'now')->format('Y-m-d'),
            'time' => fake()->time('H:i:s'),
            'user_id' => User::factory(),
        ];
    }
}
