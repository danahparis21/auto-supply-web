<?php

namespace Database\Seeders;

use App\Models\AuditLog;
use App\Models\Invoice;
use App\Models\Product;
use App\Models\Sale;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // 1. Create Default Admin & Staff
        $admin = User::firstOrCreate(
            ['email' => 'jared@autosupply.test'],
            [
                'name' => 'Jared Abellera',
                'username' => 'jared',
                'fname' => 'Jared',
                'mname' => 'M.',
                'surname' => 'Abellera',
                'contact_num' => '0917-123-4567',
                'role' => 'admin',
                'password' => Hash::make('password'),
            ]
        );

        $staff = User::firstOrCreate(
            ['email' => 'cashier@autosupply.test'],
            [
                'name' => 'Joy Staff',
                'username' => 'joycashier',
                'fname' => 'Joy',
                'surname' => 'Jeffrey',
                'contact_num' => '0918-987-6543',
                'role' => 'staff',
                'password' => Hash::make('password'),
            ]
        );

        // 2. Real Product Catalog (Imported from database/ams_db.sql)
        $this->call(AmsProductsSeeder::class);
        $createdProducts = Product::take(12)->get();

        // 3. Seed Realistic Invoices and Sales for the past 7 days (including Today)
        $today = Carbon::today();

        // Sample sales distribution for the past 6 days
        for ($daysAgo = 6; $daysAgo >= 1; $daysAgo--) {
            $date = $today->copy()->subDays($daysAgo);
            $numInvoices = rand(2, 4);

            for ($i = 1; $i <= $numInvoices; $i++) {
                $invNumber = 'INV-'.$date->format('Ymd').'-'.str_pad($i, 3, '0', STR_PAD_LEFT);
                $invoice = Invoice::create([
                    'invoice_number' => $invNumber,
                    'total_sales' => 0,
                    'customer_payment' => 0,
                    'customer_change' => 0,
                    'date' => $date->toDateString(),
                    'time' => Carbon::createFromTime(rand(9, 17), rand(0, 59))->toTimeString(),
                    'user_id' => $admin->id,
                ]);

                $total = 0;
                $sampleProducts = collect($createdProducts)->random(rand(1, 3));
                foreach ($sampleProducts as $product) {
                    $qty = rand(1, 3);
                    $subtotal = $qty * $product->price;
                    $total += $subtotal;

                    Sale::create([
                        'product_id' => $product->product_id,
                        'invoice_id' => $invoice->invoice_id,
                        'quantity_sold' => $qty,
                        'purchase_sale' => $product->price,
                        'subtotal' => $subtotal,
                    ]);
                }

                $payment = ceil($total / 100) * 100;
                if ($payment < $total) {
                    $payment = $total + 50;
                }

                $invoice->update([
                    'total_sales' => $total,
                    'customer_payment' => $payment,
                    'customer_change' => $payment - $total,
                ]);
            }
        }

        // Today's Sales (creating sales with total matching realistic figures like ~4,680.00 from the proposal screenshot)
        $todayInvoices = [
            [
                'time' => '09:15:00',
                'items' => [
                    ['product_name' => 'Bearing', 'qty' => 4],
                    ['product_name' => 'Lock Washer', 'qty' => 8],
                ],
            ],
            [
                'time' => '11:30:00',
                'items' => [
                    ['product_name' => 'Motor Oil', 'qty' => 2],
                    ['product_name' => 'Oil Filter', 'qty' => 1],
                    ['product_name' => 'Bolt', 'qty' => 4],
                ],
            ],
            [
                'time' => '13:45:00',
                'items' => [
                    ['product_name' => 'Gasoline Engine Oil', 'qty' => 1],
                    ['product_name' => 'Transmission Fluid', 'qty' => 1],
                    ['product_name' => 'Silicon Radiator Cap', 'qty' => 1],
                ],
            ],
            [
                'time' => '15:20:00',
                'items' => [
                    ['product_name' => 'Bearing', 'qty' => 2],
                    ['product_name' => 'Gear Oil', 'qty' => 1],
                ],
            ],
        ];

        $todayInvCount = 1;
        foreach ($todayInvoices as $todayInv) {
            $invNumber = 'INV-'.$today->format('Ymd').'-'.str_pad($todayInvCount++, 3, '0', STR_PAD_LEFT);
            $invoice = Invoice::create([
                'invoice_number' => $invNumber,
                'total_sales' => 0,
                'customer_payment' => 0,
                'customer_change' => 0,
                'date' => $today->toDateString(),
                'time' => $todayInv['time'],
                'user_id' => $admin->id,
            ]);

            $total = 0;
            foreach ($todayInv['items'] as $item) {
                $product = collect($createdProducts)->firstWhere('product_name', $item['product_name']);
                if ($product) {
                    $subtotal = $item['qty'] * $product->price;
                    $total += $subtotal;

                    Sale::create([
                        'product_id' => $product->product_id,
                        'invoice_id' => $invoice->invoice_id,
                        'quantity_sold' => $item['qty'],
                        'purchase_sale' => $product->price,
                        'subtotal' => $subtotal,
                    ]);
                }
            }

            $payment = ceil($total / 500) * 500;
            if ($payment < $total) {
                $payment = $total + 100;
            }

            $invoice->update([
                'total_sales' => $total,
                'customer_payment' => $payment,
                'customer_change' => $payment - $total,
            ]);
        }

        // 4. Initial Audit Log
        AuditLog::record(
            tableName: 'products',
            action: 'INITIAL_SEED',
            recordId: null,
            columnName: null,
            oldValue: null,
            newValue: 'Seeded initial product catalog and past transaction history',
            changedBy: 'System'
        );
    }
}
