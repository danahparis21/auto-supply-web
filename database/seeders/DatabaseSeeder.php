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

        // 2. Realistic Product Catalog (from project proposal and diagram)
        $productsData = [
            [
                'product_name' => 'Bearing',
                'additional_name' => 'Deep Groove Ball 6204-2RS',
                'type' => 'Engine & Mechanical',
                'brand' => 'NSK Japan',
                'price' => 250.00,
                'quantity' => 45,
                'location' => 'Shelf B-1',
                'description' => 'High precision sealed deep groove ball bearing for automotive alternators and wheels.',
            ],
            [
                'product_name' => 'Gasoline Engine Oil',
                'additional_name' => '5W-30 Full Synthetic 4L',
                'type' => 'Fluids & Oils',
                'brand' => 'Shell Helix Ultra',
                'price' => 1650.00,
                'quantity' => 18,
                'location' => 'Rack A-2',
                'description' => 'Fully synthetic motor oil designed for maximum engine performance and fuel efficiency.',
            ],
            [
                'product_name' => 'Motor Oil',
                'additional_name' => '10W-40 Premium Mineral 1L',
                'type' => 'Fluids & Oils',
                'brand' => 'Castrol GTX',
                'price' => 380.00,
                'quantity' => 34,
                'location' => 'Rack A-3',
                'description' => 'Anti-sludge protection formula for gasoline and diesel utility vehicles.',
            ],
            [
                'product_name' => 'Transmission Fluid',
                'additional_name' => 'ATF Multi-Vehicle 1L',
                'type' => 'Fluids & Oils',
                'brand' => 'Mobil 1',
                'price' => 480.00,
                'quantity' => 12,
                'location' => 'Rack A-1',
                'description' => 'Premium automatic transmission fluid formulated for smooth gear shifting.',
            ],
            [
                'product_name' => 'Gear Oil',
                'additional_name' => '80W-90 GL-5 1L',
                'type' => 'Fluids & Oils',
                'brand' => 'Motul',
                'price' => 320.00,
                'quantity' => 15,
                'location' => 'Rack A-4',
                'description' => 'Extreme pressure gear lubricant for differentials and manual gearboxes.',
            ],
            [
                'product_name' => 'Oil Filter',
                'additional_name' => 'Spin-On High Performance',
                'type' => 'Filters & Maintenance',
                'brand' => 'Bosch',
                'price' => 190.00,
                'quantity' => 3, // LOW STOCK
                'location' => 'Shelf B-2',
                'description' => 'Advanced filter media with high particulate capacity and silicone anti-drain valve.',
            ],
            [
                'product_name' => 'Silicon Radiator Cap',
                'additional_name' => '1.1 Bar High Pressure',
                'type' => 'Cooling System',
                'brand' => 'Denso',
                'price' => 280.00,
                'quantity' => 4, // LOW STOCK
                'location' => 'Shelf B-3',
                'description' => 'High temperature resistant silicon seal radiator cap preventing coolant overflow.',
            ],
            [
                'product_name' => 'Plug-in Fuse',
                'additional_name' => 'Standard Blade Fuse Set 15A',
                'type' => 'Electrical',
                'brand' => 'Stanley',
                'price' => 15.00,
                'quantity' => 95,
                'location' => 'Bin C-2',
                'description' => 'Color-coded automotive zinc alloy blade fuse for electrical circuit protection.',
            ],
            [
                'product_name' => 'Lock Washer',
                'additional_name' => 'Split Spring M12 Grade 8',
                'type' => 'Hardware',
                'brand' => 'OEM',
                'price' => 10.00,
                'quantity' => 180,
                'location' => 'Bin C-3',
                'description' => 'Zinc plated split spring lock washer preventing vibration loosening.',
            ],
            [
                'product_name' => 'Bolt',
                'additional_name' => 'High Tensile Flange M10x1.25',
                'type' => 'Hardware',
                'brand' => 'OEM',
                'price' => 25.00,
                'quantity' => 140,
                'location' => 'Bin C-1',
                'description' => 'Grade 10.9 high tensile automotive chassis flange bolt.',
            ],
            [
                'product_name' => 'Brake Pad Set',
                'additional_name' => 'Ceramic Low-Dust Front Set',
                'type' => 'Brakes & Suspension',
                'brand' => 'Brembo',
                'price' => 1450.00,
                'quantity' => 8,
                'location' => 'Shelf D-1',
                'description' => 'Premium ceramic brake pads providing superior stopping power and low rotor wear.',
            ],
            [
                'product_name' => 'Spark Plug',
                'additional_name' => 'Iridium IX Long Life',
                'type' => 'Electrical',
                'brand' => 'NGK',
                'price' => 320.00,
                'quantity' => 26,
                'location' => 'Shelf D-2',
                'description' => 'Fine wire iridium center electrode for maximum ignitability and throttle response.',
            ],
        ];

        $createdProducts = [];
        foreach ($productsData as $data) {
            $createdProducts[] = Product::create($data);
        }

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
