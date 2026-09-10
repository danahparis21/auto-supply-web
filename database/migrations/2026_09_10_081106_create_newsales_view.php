<?php

use Illuminate\Database\Migrations\Migration;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        DB::statement('
            CREATE OR REPLACE VIEW newsales AS
            SELECT 
                s.sales_id,
                s.invoice_id,
                p.product_name,
                p.additional_name,
                p.type,
                p.brand,
                p.price,
                s.quantity_sold,
                s.purchase_sale,
                s.subtotal,
                s.created_at
            FROM sales s
            JOIN products p ON s.product_id = p.product_id
        ');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        DB::statement('DROP VIEW IF EXISTS newsales');
    }
};
