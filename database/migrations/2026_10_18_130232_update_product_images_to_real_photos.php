<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        $mappings = [
            // Specific products first
            ['pattern' => '%Air-Horn%', 'image' => '/images/products/air-horn.jpg'],
            ['pattern' => '%Air Horn%', 'image' => '/images/products/air-horn.jpg'],
            ['pattern' => '%Starter Carbon Brush%', 'image' => '/images/products/starter-carbon-brush.jpg'],
            ['pattern' => '%Alternator Carbon Brush%', 'image' => '/images/products/alternator.jpeg'],
            ['pattern' => '%Battery Terminal%', 'image' => '/images/products/battery-terminal.jpeg'],
            ['pattern' => '%Eye Terminal%', 'image' => '/images/products/eye-terminal.avif'],
            ['pattern' => '%Female Terminal%', 'image' => '/images/products/female-terminal.webp'],
            ['pattern' => '%Knuckle Bearing%', 'image' => '/images/products/knuckle-bearing.jpeg'],
            ['pattern' => '%Bearing%', 'image' => '/images/products/bearing.jpg'],
            ['pattern' => '%Lock Bolt%', 'image' => '/images/products/lock-bolt.webp'],
            ['pattern' => '%Bolt%', 'image' => '/images/products/bolt.webp'],
            ['pattern' => '%Nut%', 'image' => '/images/products/nut.jpeg'],
            ['pattern' => '%Lock Washer%', 'image' => '/images/products/washer.jpg'],
            ['pattern' => '%Washer%', 'image' => '/images/products/washer.jpg'],
            ['pattern' => '%Bosny%', 'image' => '/images/products/bosny.webp'],
            ['pattern' => '%Spray Paint%', 'image' => '/images/products/bosny.webp'],
            ['pattern' => '%Break Fluid%', 'image' => '/images/products/brakefluid.jpg'],
            ['pattern' => '%Brake Fluid%', 'image' => '/images/products/brakefluid.jpg'],
            ['pattern' => '%Radiator Coolant%', 'image' => '/images/products/radiator-coolant.jpg'],
            ['pattern' => '%Coolant%', 'image' => '/images/products/coolant.webp'],
            ['pattern' => '%Diesel Engine Oil%', 'image' => '/images/products/diesel-engine-oil.jpg'],
            ['pattern' => '%Gasoline Engine Oil%', 'image' => '/images/products/gasoline-engine-oil.png'],
            ['pattern' => '%Scooter Oil%', 'image' => '/images/products/scooter-oil.jpeg'],
            ['pattern' => '%Gear Oil%', 'image' => '/images/products/gear-oil.jpeg'],
            ['pattern' => '%Transmission Fluid%', 'image' => '/images/products/transmission-fluid.webp'],
            ['pattern' => '%Motor Oil%', 'image' => '/images/products/motor-oil.jpg'],
            ['pattern' => '%Electrical Tape%', 'image' => '/images/products/electrical tape.jpeg'],
            ['pattern' => '%Mini Plug-in Fuse%', 'image' => '/images/products/mini-plug-in-fuse.jpg'],
            ['pattern' => '%Plug-in Fuse%', 'image' => '/images/products/plug-in-fuse.jpeg'],
            ['pattern' => '%Fuse%', 'image' => '/images/products/plug-in-fuse.jpeg'],
            ['pattern' => '%Fuel Filter%', 'image' => '/images/products/fuel-filter.webp'],
            ['pattern' => '%Oil Filter%', 'image' => '/images/products/oil-filter.jpg'],
            ['pattern' => '%Filter%', 'image' => '/images/products/oil-filter.jpg'],
            ['pattern' => '%Gasket%', 'image' => '/images/products/gasket.jpeg'],
            ['pattern' => '%Heater Plug%', 'image' => '/images/products/heater-plug.jpeg'],
            ['pattern' => '%Ignition Switch%', 'image' => '/images/products/ignition-switch.jpeg'],
            ['pattern' => '%Priming Pump%', 'image' => '/images/products/priming-pump.jpeg'],
            ['pattern' => '%Rubber Cup%', 'image' => '/images/products/rubber-cup.webp'],
            ['pattern' => '%Sand Paper%', 'image' => '/images/products/sandpaper.jpg'],
            ['pattern' => '%Sandpaper%', 'image' => '/images/products/sandpaper.jpg'],
            ['pattern' => '%Silicon Radiator Cap%', 'image' => '/images/products/silicon-radiator-cap.jpeg'],
            ['pattern' => '%Radiator Cap%', 'image' => '/images/products/silicon-radiator-cap.jpeg'],
            ['pattern' => '%Spark Plug%', 'image' => '/images/products/spark-plug.jpg'],
            ['pattern' => '%Temperature Sending Unit%', 'image' => '/images/products/temperature-sending-unit.jpeg'],
        ];

        foreach ($mappings as $map) {
            DB::table('products')
                ->where('product_name', 'like', $map['pattern'])
                ->orWhere('additional_name', 'like', $map['pattern'])
                ->update(['image' => $map['image']]);
        }
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        //
    }
};
