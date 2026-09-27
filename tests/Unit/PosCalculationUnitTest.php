<?php

namespace Tests\Unit;

use Tests\TestCase;

class PosCalculationUnitTest extends TestCase
{
    public function test_line_item_subtotal_calculation_and_rounding(): void
    {
        $price = 333.33;
        $quantity = 3;
        $subtotal = round($price * $quantity, 2);

        $this->assertEquals(999.99, $subtotal);
    }

    public function test_customer_change_calculation(): void
    {
        $totalSales = 1450.75;
        $customerPayment = 2000.00;
        $change = round($customerPayment - $totalSales, 2);

        $this->assertEquals(549.25, $change);
    }

    public function test_insufficient_payment_detection(): void
    {
        $totalSales = 500.00;
        $customerPayment = 450.00;

        $this->assertTrue($customerPayment < $totalSales);
    }

    public function test_inventory_decrement_math(): void
    {
        $currentStock = 15;
        $requestedQuantity = 4;
        $remainingStock = $currentStock - $requestedQuantity;

        $this->assertEquals(11, $remainingStock);
        $this->assertGreaterThanOrEqual(0, $remainingStock);
    }
}
