<?php

namespace App\Http\Controllers;

use App\Models\AuditLog;
use App\Models\Invoice;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\View\View;

class ReportController extends Controller
{
    /**
     * Display sales records and reports.
     */
    public function index(Request $request): View
    {
        $startDate = $request->input('start_date', Carbon::today()->subDays(30)->toDateString());
        $endDate = $request->input('end_date', Carbon::today()->toDateString());
        $search = $request->input('search', '');
        $activeTab = $request->input('tab', 'invoices'); // 'invoices' or 'sales'

        // 1. Invoices Query
        $invoicesQuery = Invoice::with(['user', 'sales.product'])
            ->whereBetween('date', [$startDate, $endDate])
            ->orderBy('date', 'desc')
            ->orderBy('time', 'desc');

        if ($search) {
            $invoicesQuery->where(function ($q) use ($search) {
                $q->where('invoice_number', 'like', "%{$search}%")
                    ->orWhereHas('user', function ($uq) use ($search) {
                        $uq->where('name', 'like', "%{$search}%")
                            ->orWhere('username', 'like', "%{$search}%");
                    });
            });
        }

        $invoices = $invoicesQuery->paginate(15, ['*'], 'invoices_page')->withQueryString();

        // 2. Individual Line-Item Sales Query (using the 'newsales' VIEW created in migration)
        $salesQuery = DB::table('newsales')
            ->join('invoices', 'newsales.invoice_id', '=', 'invoices.invoice_id')
            ->whereBetween('invoices.date', [$startDate, $endDate])
            ->orderBy('invoices.date', 'desc')
            ->orderBy('invoices.time', 'desc');

        if ($search) {
            $salesQuery->where(function ($q) use ($search) {
                $q->where('newsales.product_name', 'like', "%{$search}%")
                    ->orWhere('newsales.brand', 'like', "%{$search}%")
                    ->orWhere('invoices.invoice_number', 'like', "%{$search}%");
            });
        }

        $individualSales = $salesQuery->paginate(15, ['*'], 'sales_page')->withQueryString();

        // 3. Overall Summary for date range
        $totalPeriodRevenue = (float) Invoice::whereBetween('date', [$startDate, $endDate])->sum('total_sales');
        $totalPeriodInvoices = Invoice::whereBetween('date', [$startDate, $endDate])->count();
        $totalUnitsSold = (int) DB::table('sales')
            ->join('invoices', 'sales.invoice_id', '=', 'invoices.invoice_id')
            ->whereBetween('invoices.date', [$startDate, $endDate])
            ->sum('quantity_sold');

        return view('reports.index', [
            'invoices' => $invoices,
            'individualSales' => $individualSales,
            'startDate' => $startDate,
            'endDate' => $endDate,
            'search' => $search,
            'activeTab' => $activeTab,
            'totalPeriodRevenue' => $totalPeriodRevenue,
            'totalPeriodInvoices' => $totalPeriodInvoices,
            'totalUnitsSold' => $totalUnitsSold,
        ]);
    }

    /**
     * Display the audit log trail.
     */
    public function auditLogs(Request $request): View
    {
        $logs = AuditLog::orderBy('grade_id', 'desc')->paginate(20);

        return view('reports.audit', ['logs' => $logs]);
    }
}
