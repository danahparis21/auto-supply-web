<?php

namespace App\Http\Controllers;

use App\Models\AuditLog;
use App\Models\Product;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\View\View;

class InventoryController extends Controller
{
    /**
     * Display product inventory management table.
     */
    public function index(Request $request): View
    {
        $query = Product::query()->orderBy('product_id', 'desc');

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('product_name', 'like', "%{$search}%")
                    ->orWhere('brand', 'like', "%{$search}%")
                    ->orWhere('additional_name', 'like', "%{$search}%")
                    ->orWhere('location', 'like', "%{$search}%")
                    ->orWhere('type', 'like', "%{$search}%");
            });
        }

        if ($request->filled('type') && $request->input('type') !== 'All') {
            $query->where('type', $request->input('type'));
        }

        if ($request->boolean('low_stock')) {
            $query->lowStock(5);
        }

        $products = $query->paginate(12)->withQueryString();
        $categories = Product::select('type')->distinct()->pluck('type');

        $totalInventoryCount = Product::count();
        $lowStockCount = Product::lowStock(5)->count();
        $outOfStockCount = Product::where('quantity', '<=', 0)->count();

        return view('inventory.index', [
            'products' => $products,
            'categories' => $categories,
            'selectedCategory' => $request->input('type', 'All'),
            'search' => $request->input('search', ''),
            'isLowStockFilter' => $request->boolean('low_stock'),
            'totalInventoryCount' => $totalInventoryCount,
            'lowStockCount' => $lowStockCount,
            'outOfStockCount' => $outOfStockCount,
        ]);
    }

    /**
     * Store a newly created product in storage.
     */
    public function store(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'product_name' => ['required', 'string', 'max:255'],
            'additional_name' => ['nullable', 'string', 'max:255'],
            'type' => ['required', 'string', 'max:100'],
            'brand' => ['nullable', 'string', 'max:100'],
            'price' => ['required', 'numeric', 'min:0'],
            'quantity' => ['required', 'integer', 'min:0'],
            'location' => ['nullable', 'string', 'max:100'],
            'description' => ['nullable', 'string'],
        ]);

        $product = Product::create($validated);

        AuditLog::record(
            tableName: 'products',
            action: 'CREATE',
            recordId: $product->product_id,
            columnName: null,
            oldValue: null,
            newValue: json_encode($product->only(['product_name', 'brand', 'price', 'quantity'])),
            changedBy: auth()->user()?->name ?? 'Staff'
        );

        return redirect()->route('inventory.index')->with('success', "Product '{$product->product_name}' successfully added!");
    }

    /**
     * Update the specified product.
     */
    public function update(Request $request, Product $product): RedirectResponse
    {
        $validated = $request->validate([
            'product_name' => ['required', 'string', 'max:255'],
            'additional_name' => ['nullable', 'string', 'max:255'],
            'type' => ['required', 'string', 'max:100'],
            'brand' => ['nullable', 'string', 'max:100'],
            'price' => ['required', 'numeric', 'min:0'],
            'quantity' => ['required', 'integer', 'min:0'],
            'location' => ['nullable', 'string', 'max:100'],
            'description' => ['nullable', 'string'],
        ]);

        $oldValues = $product->only(['product_name', 'brand', 'price', 'quantity', 'location']);
        $product->update($validated);

        AuditLog::record(
            tableName: 'products',
            action: 'UPDATE',
            recordId: $product->product_id,
            columnName: 'details',
            oldValue: json_encode($oldValues),
            newValue: json_encode($product->only(['product_name', 'brand', 'price', 'quantity', 'location'])),
            changedBy: auth()->user()?->name ?? 'Staff'
        );

        return redirect()->route('inventory.index')->with('success', "Product '{$product->product_name}' updated successfully!");
    }

    /**
     * Quick restock product.
     */
    public function restock(Request $request, Product $product): RedirectResponse
    {
        $validated = $request->validate([
            'additional_quantity' => ['required', 'integer', 'min:1'],
        ]);

        $oldQty = $product->quantity;
        $newQty = $oldQty + $validated['additional_quantity'];
        $product->update(['quantity' => $newQty]);

        AuditLog::record(
            tableName: 'products',
            action: 'RESTOCK',
            recordId: $product->product_id,
            columnName: 'quantity',
            oldValue: (string) $oldQty,
            newValue: (string) $newQty,
            changedBy: auth()->user()?->name ?? 'Staff'
        );

        return redirect()->route('inventory.index')->with('success', "Added {$validated['additional_quantity']} units to '{$product->product_name}'. New stock: {$newQty}");
    }

    /**
     * Remove the specified product from storage.
     */
    public function destroy(Product $product): RedirectResponse
    {
        $name = $product->product_name;
        $id = $product->product_id;

        AuditLog::record(
            tableName: 'products',
            action: 'DELETE',
            recordId: $id,
            columnName: null,
            oldValue: json_encode($product->only(['product_name', 'brand', 'price', 'quantity'])),
            newValue: null,
            changedBy: auth()->user()?->name ?? 'Staff'
        );

        $product->delete();

        return redirect()->route('inventory.index')->with('success', "Product '{$name}' has been deleted.");
    }
}
