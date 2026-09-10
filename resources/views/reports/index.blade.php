@extends('layouts.app')

@section('page_title', 'Sales Records & Invoices')

@section('content')
<div class="space-y-6">

    <!-- Overview Revenue Banner -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div class="p-4 rounded-xl bg-slate-900 border border-slate-800 shadow-md">
            <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Filtered Period Revenue</span>
            <div class="mt-2 flex items-baseline justify-between">
                <span class="text-2xl font-black text-amber-400 font-mono-nums">₱{{ number_format($totalPeriodRevenue, 2) }}</span>
                <span class="text-xs text-slate-500">Gross Sales</span>
            </div>
        </div>

        <div class="p-4 rounded-xl bg-slate-900 border border-slate-800 shadow-md">
            <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Completed Invoices</span>
            <div class="mt-2 flex items-baseline justify-between">
                <span class="text-2xl font-black text-white font-mono-nums">{{ $totalPeriodInvoices }}</span>
                <span class="text-xs text-slate-500">Transactions</span>
            </div>
        </div>

        <div class="p-4 rounded-xl bg-slate-900 border border-slate-800 shadow-md">
            <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Units Sold</span>
            <div class="mt-2 flex items-baseline justify-between">
                <span class="text-2xl font-black text-emerald-400 font-mono-nums">{{ $totalUnitsSold }}</span>
                <span class="text-xs text-slate-500">Parts dispensed</span>
            </div>
        </div>
    </div>

    <!-- Filter & Tab Controls -->
    <div class="p-4 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl flex flex-col md:flex-row items-center justify-between gap-4">
        
        <!-- Tabs -->
        <div class="flex items-center space-x-2 bg-slate-950 p-1.5 rounded-xl border border-slate-800 w-full md:w-auto">
            <a 
                href="{{ route('reports.index', array_merge(request()->query(), ['tab' => 'invoices'])) }}"
                class="px-4 py-2 rounded-lg text-xs font-bold transition flex-1 md:flex-initial text-center {{ $activeTab === 'invoices' ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/20' : 'text-slate-400 hover:text-white' }}"
            >
                Grouped Invoices
            </a>
            <a 
                href="{{ route('reports.index', array_merge(request()->query(), ['tab' => 'sales'])) }}"
                class="px-4 py-2 rounded-lg text-xs font-bold transition flex-1 md:flex-initial text-center {{ $activeTab === 'sales' ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/20' : 'text-slate-400 hover:text-white' }}"
            >
                Individual Product Sales (View)
            </a>
        </div>

        <!-- Date Range & Search Form -->
        <form method="GET" action="{{ route('reports.index') }}" class="flex flex-wrap items-center gap-2 w-full md:w-auto">
            <input type="hidden" name="tab" value="{{ $activeTab }}">
            
            <div class="flex items-center space-x-1 text-xs">
                <input 
                    type="date" 
                    name="start_date" 
                    value="{{ $startDate }}" 
                    class="px-2.5 py-1.5 bg-slate-950 border border-slate-800 rounded-lg text-xs text-white focus:border-amber-500"
                >
                <span class="text-slate-500">to</span>
                <input 
                    type="date" 
                    name="end_date" 
                    value="{{ $endDate }}" 
                    class="px-2.5 py-1.5 bg-slate-950 border border-slate-800 rounded-lg text-xs text-white focus:border-amber-500"
                >
            </div>

            <input 
                type="text" 
                name="search" 
                value="{{ $search }}" 
                placeholder="Search..." 
                class="px-3 py-1.5 bg-slate-950 border border-slate-800 rounded-lg text-xs text-white placeholder-slate-500 focus:border-amber-500"
            >

            <button type="submit" class="px-3 py-1.5 bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs font-semibold rounded-lg transition">
                Filter
            </button>

            @if($search || $startDate !== now()->subDays(30)->toDateString() || $endDate !== now()->toDateString())
                <a href="{{ route('reports.index', ['tab' => $activeTab]) }}" class="px-2 py-1.5 text-xs text-slate-400 hover:text-white transition">
                    Clear
                </a>
            @endif
        </form>
    </div>

    <!-- Tab 1: Grouped Invoices -->
    @if($activeTab === 'invoices')
        <div class="rounded-2xl bg-slate-900 border border-slate-800 shadow-xl overflow-hidden">
            <div class="p-4 border-b border-slate-800 bg-slate-900/80 flex items-center justify-between">
                <h4 class="text-sm font-bold text-white uppercase tracking-wider">Grouped Invoices</h4>
                <span class="text-xs text-slate-400 font-mono-nums">{{ $invoices->total() }} total invoices found</span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead>
                        <tr class="text-xs uppercase tracking-wider text-slate-400 border-b border-slate-800 bg-slate-950/40">
                            <th class="py-3.5 px-4">Invoice #</th>
                            <th class="py-3.5 px-4">Date & Time</th>
                            <th class="py-3.5 px-4">Cashier</th>
                            <th class="py-3.5 px-4">Items</th>
                            <th class="py-3.5 px-4 text-right">Total Sales</th>
                            <th class="py-3.5 px-4 text-right">Customer Payment</th>
                            <th class="py-3.5 px-4 text-right">Change</th>
                            <th class="py-3.5 px-4 text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-800/60 font-mono-nums text-xs">
                        @forelse($invoices as $inv)
                            <tr class="hover:bg-slate-800/40 transition">
                                <td class="py-3.5 px-4 font-bold text-amber-400">{{ $inv->invoice_number }}</td>
                                <td class="py-3.5 px-4 text-slate-300">{{ $inv->date->format('M d, Y') }} <span class="text-slate-500">{{ $inv->time }}</span></td>
                                <td class="py-3.5 px-4 font-sans text-slate-300">{{ $inv->user?->name ?? 'Admin' }}</td>
                                <td class="py-3.5 px-4 text-slate-400 font-sans">
                                    <span class="px-2 py-0.5 rounded bg-slate-800 text-slate-300 text-[11px]">
                                        {{ $inv->sales->count() }} items
                                    </span>
                                </td>
                                <td class="py-3.5 px-4 text-right font-bold text-white">₱{{ number_format($inv->total_sales, 2) }}</td>
                                <td class="py-3.5 px-4 text-right text-slate-300">₱{{ number_format($inv->customer_payment, 2) }}</td>
                                <td class="py-3.5 px-4 text-right text-emerald-400">₱{{ number_format($inv->customer_change, 2) }}</td>
                                <td class="py-3.5 px-4 text-center font-sans">
                                    <a href="{{ route('pos.invoice', $inv->invoice_id) }}" target="_blank" class="px-2.5 py-1 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-200 text-xs transition">
                                        View Receipt
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="8" class="py-12 text-center text-slate-500 font-sans">
                                    No invoices found for this period.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="p-4 border-t border-slate-800 bg-slate-900/80">
                {{ $invoices->links() }}
            </div>
        </div>
    @else
        <!-- Tab 2: Individual Product Sales (using the newsales view) -->
        <div class="rounded-2xl bg-slate-900 border border-slate-800 shadow-xl overflow-hidden">
            <div class="p-4 border-b border-slate-800 bg-slate-900/80 flex items-center justify-between">
                <div>
                    <h4 class="text-sm font-bold text-white uppercase tracking-wider">Individual Line-Item Sales</h4>
                    <p class="text-xs text-slate-400">Extracted from the <code class="text-amber-400">newsales</code> database view</p>
                </div>
                <span class="text-xs text-slate-400 font-mono-nums">{{ $individualSales->total() }} sales recorded</span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead>
                        <tr class="text-xs uppercase tracking-wider text-slate-400 border-b border-slate-800 bg-slate-950/40">
                            <th class="py-3.5 px-4">Invoice #</th>
                            <th class="py-3.5 px-4">Part Name</th>
                            <th class="py-3.5 px-4">Category</th>
                            <th class="py-3.5 px-4">Brand</th>
                            <th class="py-3.5 px-4 text-right">Unit Price</th>
                            <th class="py-3.5 px-4 text-center">Qty Sold</th>
                            <th class="py-3.5 px-4 text-right">Subtotal</th>
                            <th class="py-3.5 px-4 text-center">Date & Time</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-800/60 font-mono-nums text-xs">
                        @forelse($individualSales as $row)
                            <tr class="hover:bg-slate-800/40 transition">
                                <td class="py-3.5 px-4 font-bold text-amber-400">{{ $row->invoice_number }}</td>
                                <td class="py-3.5 px-4 font-sans font-bold text-white">
                                    {{ $row->product_name }}
                                    @if($row->additional_name)
                                        <span class="block text-[10px] text-slate-400 font-normal">{{ $row->additional_name }}</span>
                                    @endif
                                </td>
                                <td class="py-3.5 px-4 font-sans text-slate-300">
                                    <span class="px-2 py-0.5 rounded text-[10px] bg-slate-800 text-slate-300">
                                        {{ $row->type }}
                                    </span>
                                </td>
                                <td class="py-3.5 px-4 font-sans text-slate-300">{{ $row->brand ?? 'OEM' }}</td>
                                <td class="py-3.5 px-4 text-right text-slate-300">₱{{ number_format($row->purchase_sale, 2) }}</td>
                                <td class="py-3.5 px-4 text-center font-bold text-white">{{ $row->quantity_sold }}</td>
                                <td class="py-3.5 px-4 text-right font-bold text-emerald-400">₱{{ number_format($row->subtotal, 2) }}</td>
                                <td class="py-3.5 px-4 text-center text-slate-400">{{ \Carbon\Carbon::parse($row->created_at)->format('M d, Y h:i A') }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="8" class="py-12 text-center text-slate-500 font-sans">
                                    No item sales found for this period.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="p-4 border-t border-slate-800 bg-slate-900/80">
                {{ $individualSales->links() }}
            </div>
        </div>
    @endif
</div>
@endsection
