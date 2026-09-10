<?php

namespace App\Http\Controllers;

use App\Models\Invoice;
use App\Models\Product;
use App\Models\Sale;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class DashboardController extends Controller
{
    /**
     * Display the analytics dashboard.
     */
    public function index(Request $request): View
    {
        $today = Carbon::today()->toDateString();

        // 1. Core KPIs
        $todayRevenue = (float) Invoice::whereDate('date', $today)->sum('total_sales');
        $todayOrdersCount = Invoice::whereDate('date', $today)->count();
        $totalProducts = Product::count();
        $lowStockProducts = Product::lowStock(5)->orderBy('quantity', 'asc')->get();
        $lowStockCount = $lowStockProducts->count();

        // 2. Top-selling product overall
        $topSellerRecord = Sale::select('product_id', DB::raw('SUM(quantity_sold) as total_qty'))
            ->groupBy('product_id')
            ->orderByDesc('total_qty')
            ->with('product')
            ->first();

        $topSellingProduct = $topSellerRecord?->product;
        $topSellingQty = $topSellerRecord?->total_qty ?? 0;

        // 3. Today's Sales per Product (Donut / Pie chart)
        $todayProductSales = DB::table('sales')
            ->join('invoices', 'sales.invoice_id', '=', 'invoices.invoice_id')
            ->join('products', 'sales.product_id', '=', 'products.product_id')
            ->whereDate('invoices.date', $today)
            ->select('products.product_name', DB::raw('SUM(sales.quantity_sold) as total_qty'), DB::raw('SUM(sales.subtotal) as total_amount'))
            ->groupBy('products.product_id', 'products.product_name')
            ->orderByDesc('total_amount')
            ->get();

        // If no sales today, provide top general product distribution for preview
        if ($todayProductSales->isEmpty()) {
            $todayProductSales = DB::table('sales')
                ->join('products', 'sales.product_id', '=', 'products.product_id')
                ->select('products.product_name', DB::raw('SUM(sales.quantity_sold) as total_qty'), DB::raw('SUM(sales.subtotal) as total_amount'))
                ->groupBy('products.product_id', 'products.product_name')
                ->orderByDesc('total_amount')
                ->limit(5)
                ->get();
        }

        // 4. Daily Sales This Week (Last 7 days)
        $daysLabels = [];
        $dailyRevenues = [];
        for ($i = 6; $i >= 0; $i--) {
            $date = Carbon::today()->subDays($i);
            $daysLabels[] = $date->format('M d');
            $rev = (float) Invoice::whereDate('date', $date->toDateString())->sum('total_sales');
            $dailyRevenues[] = $rev;
        }

        // 5. Top 5 Selling Products (Bar chart)
        $top5Products = DB::table('sales')
            ->join('products', 'sales.product_id', '=', 'products.product_id')
            ->select('products.product_name', DB::raw('SUM(sales.quantity_sold) as total_sold'))
            ->groupBy('products.product_id', 'products.product_name')
            ->orderByDesc('total_sold')
            ->limit(5)
            ->get();

        // 6. Recent Invoices
        $recentInvoices = Invoice::with(['user', 'sales.product'])
            ->orderByDesc('created_at')
            ->limit(5)
            ->get();

        return view('dashboard', [
            'todayRevenue' => $todayRevenue,
            'todayOrdersCount' => $todayOrdersCount,
            'totalProducts' => $totalProducts,
            'lowStockCount' => $lowStockCount,
            'lowStockProducts' => $lowStockProducts,
            'topSellingProduct' => $topSellingProduct,
            'topSellingQty' => $topSellingQty,
            'todayProductSales' => $todayProductSales,
            'daysLabels' => $daysLabels,
            'dailyRevenues' => $dailyRevenues,
            'top5Products' => $top5Products,
            'recentInvoices' => $recentInvoices,
        ]);
    }
}
