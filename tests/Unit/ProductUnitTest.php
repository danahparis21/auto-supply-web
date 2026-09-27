<?php

namespace Tests\Unit;

use App\Models\Product;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class ProductUnitTest extends TestCase
{
    use RefreshDatabase;

    public function test_product_attributes_and_type_casting(): void
    {
        $product = Product::factory()->create([
            'product_name' => 'Brake Fluid DOT 4',
            'additional_name' => 'Synthetic 500ml',
            'type' => 'Fluid',
            'brand' => 'Brembo',
            'price' => 349.99,
            'quantity' => 15,
            'location' => 'Aisle 3',
        ]);

        $this->assertEquals('Brake Fluid DOT 4', $product->product_name);
        $this->assertEquals('349.99', $product->price);
        $this->assertIsInt($product->quantity);
        $this->assertEquals(15, $product->quantity);
    }

    public function test_scope_low_stock_filters_products_at_or_below_threshold(): void
    {
        // Out of stock (0)
        Product::factory()->create(['product_name' => 'Product Zero', 'quantity' => 0]);
        // Low stock (3)
        Product::factory()->create(['product_name' => 'Product Low', 'quantity' => 3]);
        // Exactly threshold (5)
        Product::factory()->create(['product_name' => 'Product Exact', 'quantity' => 5]);
        // Ample stock (10)
        Product::factory()->create(['product_name' => 'Product Ample', 'quantity' => 10]);

        $lowStockProducts = Product::lowStock()->pluck('product_name');

        $this->assertContains('Product Zero', $lowStockProducts);
        $this->assertContains('Product Low', $lowStockProducts);
        $this->assertContains('Product Exact', $lowStockProducts);
        $this->assertNotContains('Product Ample', $lowStockProducts);
        $this->assertCount(3, $lowStockProducts);
    }

    public function test_scope_low_stock_respects_custom_threshold(): void
    {
        Product::factory()->create(['product_name' => 'P1', 'quantity' => 8]);
        Product::factory()->create(['product_name' => 'P2', 'quantity' => 12]);

        $customLowStock = Product::lowStock(10)->pluck('product_name');

        $this->assertContains('P1', $customLowStock);
        $this->assertNotContains('P2', $customLowStock);
    }

    public function test_product_has_many_sales_relationship(): void
    {
        $product = Product::factory()->create();
        $this->assertInstanceOf(HasMany::class, $product->sales());
    }
}
