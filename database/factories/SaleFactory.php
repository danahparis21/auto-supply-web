<?php

namespace Database\Factories;

use App\Models\Invoice;
use App\Models\Product;
use App\Models\Sale;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Sale>
 */
class SaleFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $qty = fake()->numberBetween(1, 5);
        $price = fake()->randomFloat(2, 80, 1200);

        return [
            'product_id' => Product::factory(),
            'invoice_id' => Invoice::factory(),
            'quantity_sold' => $qty,
            'purchase_sale' => $price,
            'subtotal' => round($qty * $price, 2),
        ];
    }
}
