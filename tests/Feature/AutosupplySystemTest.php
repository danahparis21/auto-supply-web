<?php

namespace Tests\Feature;

use App\Models\Invoice;
use App\Models\Product;
use App\Models\Sale;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AutosupplySystemTest extends TestCase
{
    use RefreshDatabase;

    protected User $user;

    protected function setUp(): void
    {
        parent::setUp();

        $this->user = User::factory()->create([
            'username' => 'jared',
            'name' => 'Jared Abellera',
            'email' => 'jared@autosupply.test',
            'password' => bcrypt('password'),
        ]);
    }

    public function test_guest_is_redirected_to_login(): void
    {
        $response = $this->get('/dashboard');
        $response->assertRedirect('/login');
    }

    public function test_user_can_login_with_username(): void
    {
        $response = $this->post('/login', [
            'email' => 'jared', // field accepts username or email
            'password' => 'password',
        ]);

        $this->assertAuthenticatedAs($this->user);
        $response->assertRedirect(route('dashboard', absolute: false));
    }

    public function test_authenticated_user_can_view_dashboard(): void
    {
        Product::factory()->create(['quantity' => 20]);

        $response = $this->actingAs($this->user)->get('/dashboard');

        $response->assertOk();
        $response->assertSee('Analytics Dashboard');
        $response->assertSee('Daily Sales Trend');
        $response->assertSee('Total Catalog');
    }

    public function test_authenticated_user_can_view_inventory_and_add_product(): void
    {
        $response = $this->actingAs($this->user)->get('/inventory');
        $response->assertOk();
        $response->assertSee('Inventory & Product Catalog');

        $storeResponse = $this->actingAs($this->user)->post('/inventory', [
            'product_name' => 'Spark Plug Super Gold',
            'additional_name' => 'Laser Iridium',
            'type' => 'Electrical',
            'brand' => 'NGK',
            'price' => 350.00,
            'quantity' => 50,
            'location' => 'Shelf E-1',
            'description' => 'Top tier spark plug',
        ]);

        $storeResponse->assertRedirect('/inventory');
        $this->assertDatabaseHas('products', [
            'product_name' => 'Spark Plug Super Gold',
            'quantity' => 50,
        ]);
    }

    public function test_pos_checkout_creates_invoice_and_deducts_stock(): void
    {
        $product = Product::factory()->create([
            'product_name' => 'Engine Oil 5W-30',
            'price' => 500.00,
            'quantity' => 20,
        ]);

        $response = $this->actingAs($this->user)->postJson('/transactions/checkout', [
            'items' => [
                ['product_id' => $product->product_id, 'quantity' => 3],
            ],
            'customer_payment' => 2000.00,
        ]);

        $response->assertOk();
        $response->assertJsonPath('success', true);

        // Verify product stock decremented: 20 - 3 = 17
        $this->assertEquals(17, $product->fresh()->quantity);

        // Verify invoice recorded: total 1500, payment 2000, change 500
        $this->assertDatabaseHas('invoices', [
            'total_sales' => 1500.00,
            'customer_payment' => 2000.00,
            'customer_change' => 500.00,
        ]);

        // Verify sale record
        $this->assertDatabaseHas('sales', [
            'product_id' => $product->product_id,
            'quantity_sold' => 3,
            'subtotal' => 1500.00,
        ]);

        // Verify audit log
        $this->assertDatabaseHas('audit_logs', [
            'table_name' => 'products',
            'action' => 'POS_SALE',
            'record_id' => $product->product_id,
        ]);
    }

    public function test_user_can_view_sales_records_and_audit_trail(): void
    {
        $response = $this->actingAs($this->user)->get('/sales-records');
        $response->assertOk();
        $response->assertSee('Sales Records & Invoices');

        $auditResponse = $this->actingAs($this->user)->get('/audit-logs');
        $auditResponse->assertOk();
        $auditResponse->assertSee('System Audit Trail');
    }

    public function test_pos_checkout_fails_when_payment_is_insufficient(): void
    {
        $product = Product::factory()->create([
            'price' => 500.00,
            'quantity' => 10,
        ]);

        $response = $this->actingAs($this->user)->postJson('/transactions/checkout', [
            'items' => [
                ['product_id' => $product->product_id, 'quantity' => 2], // Total 1000.00
            ],
            'customer_payment' => 800.00, // Less than 1000.00
        ]);

        $response->assertStatus(422);
        $response->assertJsonPath('success', false);
        $this->assertEquals(10, $product->fresh()->quantity);
        $this->assertDatabaseMissing('invoices', ['customer_payment' => 800.00]);
    }

    public function test_pos_checkout_fails_when_stock_is_insufficient(): void
    {
        $product = Product::factory()->create([
            'product_name' => 'Brake Pad Set',
            'price' => 800.00,
            'quantity' => 2,
        ]);

        $response = $this->actingAs($this->user)->postJson('/transactions/checkout', [
            'items' => [
                ['product_id' => $product->product_id, 'quantity' => 5], // Exceeds available stock
            ],
            'customer_payment' => 5000.00,
        ]);

        $response->assertStatus(422);
        $response->assertJsonPath('success', false);
        $this->assertEquals(2, $product->fresh()->quantity);
        $this->assertDatabaseMissing('invoices', ['total_sales' => 4000.00]);
    }

    public function test_inventory_store_validates_required_fields(): void
    {
        $response = $this->actingAs($this->user)->post('/inventory', []);

        $response->assertSessionHasErrors(['product_name', 'type', 'price', 'quantity']);
    }

    public function test_pos_checkout_consolidates_duplicate_items_and_prevents_oversell(): void
    {
        $product = Product::factory()->create([
            'product_name' => 'Wiper Blade 22"',
            'price' => 250.00,
            'quantity' => 3, // only 3 units in stock
        ]);

        // Cart sends 2 units + 2 units of the same product (total 4 > 3)
        $response = $this->actingAs($this->user)->postJson('/transactions/checkout', [
            'items' => [
                ['product_id' => $product->product_id, 'quantity' => 2],
                ['product_id' => $product->product_id, 'quantity' => 2],
            ],
            'customer_payment' => 2000.00,
        ]);

        $response->assertStatus(422);
        $response->assertJsonPath('success', false);
        $this->assertStringContainsString('Insufficient stock', $response->json('message'));
        $this->assertEquals(3, $product->fresh()->quantity);
    }

    public function test_pos_checkout_consolidates_duplicate_items_and_deducts_accurately(): void
    {
        $product = Product::factory()->create([
            'product_name' => 'Synthetic Motor Oil 1L',
            'price' => 400.00,
            'quantity' => 10,
        ]);

        // Cart sends duplicate lines: 2 + 3 = 5 units
        $response = $this->actingAs($this->user)->postJson('/transactions/checkout', [
            'items' => [
                ['product_id' => $product->product_id, 'quantity' => 2],
                ['product_id' => $product->product_id, 'quantity' => 3],
            ],
            'customer_payment' => 2500.00,
        ]);

        $response->assertOk();
        $response->assertJsonPath('success', true);
        // Stock should be 10 - 5 = 5
        $this->assertEquals(5, $product->fresh()->quantity);
        // Total should be 5 * 400 = 2000.00, Change = 500.00
        $this->assertDatabaseHas('invoices', [
            'total_sales' => 2000.00,
            'customer_payment' => 2500.00,
            'customer_change' => 500.00,
        ]);
        // Only one consolidated sale record with quantity_sold = 5
        $this->assertDatabaseHas('sales', [
            'product_id' => $product->product_id,
            'quantity_sold' => 5,
            'subtotal' => 2000.00,
        ]);
    }
}
