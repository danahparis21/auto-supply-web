<?php

namespace Tests\Unit;

use App\Models\Invoice;
use App\Models\User;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Tests\TestCase;

class InvoiceUnitTest extends TestCase
{
    use RefreshDatabase;

    public function test_invoice_attributes_and_decimal_casts(): void
    {
        $user = User::factory()->create();

        $invoice = Invoice::create([
            'invoice_number' => 'INV-20260927-9999',
            'total_sales' => 1250.50,
            'customer_payment' => 1500.00,
            'customer_change' => 249.50,
            'date' => '2026-09-27',
            'time' => '14:30:00',
            'user_id' => $user->id,
        ]);

        $this->assertEquals('1250.50', $invoice->total_sales);
        $this->assertEquals('1500.00', $invoice->customer_payment);
        $this->assertEquals('249.50', $invoice->customer_change);
        $this->assertInstanceOf(Carbon::class, $invoice->date);
    }

    public function test_invoice_belongs_to_user(): void
    {
        $user = User::factory()->create(['name' => 'Cashier Juan']);
        $invoice = Invoice::factory()->create(['user_id' => $user->id]);

        $this->assertInstanceOf(User::class, $invoice->user);
        $this->assertEquals('Cashier Juan', $invoice->user->name);
    }

    public function test_invoice_has_many_sales_relationship(): void
    {
        $invoice = Invoice::factory()->create();
        $this->assertInstanceOf(HasMany::class, $invoice->sales());
    }
}
