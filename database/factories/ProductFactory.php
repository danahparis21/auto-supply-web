<?php

namespace Database\Factories;

use App\Models\Product;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<Product>
 */
class ProductFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $types = ['Fluids & Oils', 'Engine & Mechanical', 'Brakes & Suspension', 'Electrical & Lighting', 'Filters & Maintenance'];
        $brands = ['Castrol', 'Motul', 'Shell', 'Bosch', 'Denso', 'Brembo', 'Mobil 1', 'NGK', 'Stanley'];

        return [
            'product_name' => fake()->randomElement(['Motor Oil', 'Oil Filter', 'Wheel Bearing', 'Spark Plug', 'Brake Pad Set', 'Transmission Fluid', 'Plug-in Fuse', 'Radiator Cap']),
            'additional_name' => fake()->randomElement(['5W-30 Full Synthetic', '10W-40 Premium', 'Heavy Duty', 'OEM Spec', 'Multi-Vehicle', '10A / 15A', 'Standard']),
            'type' => fake()->randomElement($types),
            'brand' => fake()->randomElement($brands),
            'price' => fake()->randomFloat(2, 50, 2500),
            'quantity' => fake()->numberBetween(0, 100),
            'location' => 'Aisle '.fake()->randomLetter().'-'.fake()->randomDigitNotNull(),
            'description' => fake()->sentence(),
        ];
    }
}
