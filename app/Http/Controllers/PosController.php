<?php

namespace App\Http\Controllers;

use App\Models\AuditLog;
use App\Models\Invoice;
use App\Models\Product;
use App\Models\Sale;
use Carbon\Carbon;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class PosController extends Controller
{
    /**
     * Display POS transaction terminal.
     */
    public function index(Request $request): View
    {
        $query = Product::query()->orderBy('product_name', 'asc');

        if ($request->filled('search')) {
            $search = $request->input('search');
            $query->where(function ($q) use ($search) {
                $q->where('product_name', 'like', "%{$search}%")
                    ->orWhere('brand', 'like', "%{$search}%")
                    ->orWhere('additional_name', 'like', "%{$search}%")
                    ->orWhere('type', 'like', "%{$search}%");
            });
        }

        if ($request->filled('type') && $request->input('type') !== 'All') {
            $query->where('type', $request->input('type'));
        }

        $products = $query->get();
        $categories = Product::select('type')->distinct()->pluck('type');

        return view('pos.index', [
            'products' => $products,
            'categories' => $categories,
            'selectedCategory' => $request->input('type', 'All'),
            'search' => $request->input('search', ''),
        ]);
    }

    /**
     * Process POS checkout.
     */
    public function checkout(Request $request): JsonResponse|RedirectResponse
    {
        $validated = $request->validate([
            'items' => ['required', 'array', 'min:1'],
            'items.*.product_id' => ['required', 'exists:products,product_id'],
            'items.*.quantity' => ['required', 'integer', 'min:1'],
            'customer_payment' => ['required', 'numeric', 'min:0'],
        ]);

        return DB::transaction(function () use ($validated, $request) {
            $now = Carbon::now();
            $totalSales = 0.0;
            $itemsToProcess = [];

            // 1. Verify stock and calculate total
            foreach ($validated['items'] as $item) {
                $product = Product::lockForUpdate()->findOrFail($item['product_id']);

                if ($product->quantity < $item['quantity']) {
                    $errorMsg = "Insufficient stock for '{$product->product_name}'. Available: {$product->quantity}, Requested: {$item['quantity']}";
                    if ($request->wantsJson()) {
                        return response()->json(['success' => false, 'message' => $errorMsg], 422);
                    }

                    return back()->withErrors(['items' => $errorMsg]);
                }

                $subtotal = round($product->price * $item['quantity'], 2);
                $totalSales += $subtotal;

                $itemsToProcess[] = [
                    'product' => $product,
                    'quantity' => $item['quantity'],
                    'price' => $product->price,
                    'subtotal' => $subtotal,
                ];
            }

            if ($validated['customer_payment'] < $totalSales) {
                $errorMsg = 'Customer payment amount is less than total sales.';
                if ($request->wantsJson()) {
                    return response()->json(['success' => false, 'message' => $errorMsg], 422);
                }

                return back()->withErrors(['customer_payment' => $errorMsg]);
            }

            $customerChange = round($validated['customer_payment'] - $totalSales, 2);

            // 2. Generate unique invoice number
            $invoiceNumber = 'INV-'.$now->format('Ymd').'-'.strtoupper(substr(uniqid(), -4));

            $invoice = Invoice::create([
                'invoice_number' => $invoiceNumber,
                'total_sales' => $totalSales,
                'customer_payment' => $validated['customer_payment'],
                'customer_change' => $customerChange,
                'date' => $now->toDateString(),
                'time' => $now->toTimeString(),
                'user_id' => auth()->id(),
            ]);

            // 3. Record Sales and Deduct Stock
            foreach ($itemsToProcess as $proc) {
                /** @var Product $prod */
                $prod = $proc['product'];
                $oldQty = $prod->quantity;
                $newQty = $oldQty - $proc['quantity'];

                Sale::create([
                    'product_id' => $prod->product_id,
                    'invoice_id' => $invoice->invoice_id,
                    'quantity_sold' => $proc['quantity'],
                    'purchase_sale' => $proc['price'],
                    'subtotal' => $proc['subtotal'],
                ]);

                $prod->update(['quantity' => $newQty]);

                // Record Audit Log for inventory change
                AuditLog::record(
                    tableName: 'products',
                    action: 'POS_SALE',
                    recordId: $prod->product_id,
                    columnName: 'quantity',
                    oldValue: (string) $oldQty,
                    newValue: (string) $newQty,
                    changedBy: auth()->user()?->name ?? 'Cashier'
                );
            }

            $invoice->load(['sales.product', 'user']);

            if ($request->wantsJson()) {
                return response()->json([
                    'success' => true,
                    'message' => 'Transaction successfully recorded!',
                    'invoice' => $invoice,
                ]);
            }

            return redirect()->route('pos.index')->with([
                'success' => "Transaction #{$invoice->invoice_number} recorded successfully!",
                'last_invoice' => $invoice,
            ]);
        });
    }

    /**
     * Print or view invoice receipt.
     */
    public function printInvoice(Invoice $invoice): View
    {
        $invoice->load(['sales.product', 'user']);

        return view('pos.receipt', ['invoice' => $invoice]);
    }
}
