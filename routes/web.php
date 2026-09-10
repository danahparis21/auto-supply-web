<?php

use App\Http\Controllers\DashboardController;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\PosController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReportController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    if (auth()->check()) {
        return redirect()->route('dashboard');
    }

    return redirect()->route('login');
});

Route::middleware(['auth'])->group(function () {
    // 1. Dashboard
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // 2. POS / Transactions
    Route::get('/transactions', [PosController::class, 'index'])->name('pos.index');
    Route::post('/transactions/checkout', [PosController::class, 'checkout'])->name('pos.checkout');
    Route::get('/transactions/invoice/{invoice}', [PosController::class, 'printInvoice'])->name('pos.invoice');

    // 3. Inventory Management (CRUD & Restock)
    Route::get('/inventory', [InventoryController::class, 'index'])->name('inventory.index');
    Route::post('/inventory', [InventoryController::class, 'store'])->name('inventory.store');
    Route::put('/inventory/{product}', [InventoryController::class, 'update'])->name('inventory.update');
    Route::delete('/inventory/{product}', [InventoryController::class, 'destroy'])->name('inventory.destroy');
    Route::post('/inventory/{product}/restock', [InventoryController::class, 'restock'])->name('inventory.restock');

    // 4. Sales Records & Reports
    Route::get('/sales-records', [ReportController::class, 'index'])->name('reports.index');
    Route::get('/audit-logs', [ReportController::class, 'auditLogs'])->name('reports.audit');

    // Profile
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

require __DIR__.'/auth.php';
