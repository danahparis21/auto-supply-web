@extends('layouts.app')

@section('page_title', 'Sales Records & Invoices')

@section('content')
<div class="space-y-6">

    <!-- KPI Summary Cards (Matches Dashboard KPI Design) -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">

        <!-- 1. Filtered Period Revenue -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(159,18,18,0.08);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Filtered Period Revenue</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center font-bold text-sm"
                     style="background: rgba(159,18,18,0.12); border: 1px solid rgba(159,18,18,0.3); color: var(--brand);">₱</div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums text-brand">
                    ₱{{ number_format($totalPeriodRevenue, 2) }}
                </h3>
                <p class="text-xs mt-1 flex items-center" style="color: var(--text-muted);">
                    <span class="font-semibold mr-1.5" style="color: var(--text-secondary);">Gross sales</span> for selected range
                </p>
            </div>
        </div>

        <!-- 2. Completed Invoices -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(59,130,246,0.06);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Completed Invoices</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(59,130,246,0.12); border: 1px solid rgba(59,130,246,0.3); color: #3b82f6;">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: var(--text-primary);">
                    {{ $totalPeriodInvoices }}
                </h3>
                <p class="text-xs mt-1 flex items-center" style="color: var(--text-muted);">
                    <span class="font-semibold mr-1.5" style="color: #10b981;">Processed</span> transactions
                </p>
            </div>
        </div>

        <!-- 3. Total Units Sold -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(16,185,129,0.06);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Total Units Sold</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(16,185,129,0.12); border: 1px solid rgba(16,185,129,0.3); color: #10b981;">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: #10b981;">
                    {{ $totalUnitsSold }}
                </h3>
                <p class="text-xs mt-1 flex items-center" style="color: var(--text-muted);">
                    <span class="font-semibold mr-1.5" style="color: var(--text-secondary);">Parts &amp; fluids</span> dispensed
                </p>
            </div>
        </div>
    </div>

    <!-- Filter & Tab Controls -->
    <div class="p-4 rounded-2xl shadow-xl flex flex-col md:flex-row items-center justify-between gap-4 transition-colors"
         style="background: var(--bg-surface); border: 1px solid var(--border);">

        <!-- Tabs -->
        <div class="flex items-center space-x-2 p-1.5 rounded-xl border w-full md:w-auto"
             style="background: var(--bg-elevated); border-color: var(--border);">
            <a
                href="{{ route('reports.index', array_merge(request()->query(), ['tab' => 'invoices'])) }}"
                class="px-4 py-2 rounded-lg text-xs font-bold transition flex-1 md:flex-initial text-center {{ $activeTab === 'invoices' ? 'bg-brand text-white shadow-brand' : '' }}"
                style="{{ $activeTab !== 'invoices' ? 'color: var(--text-secondary);' : '' }}"
            >
                Grouped Invoices
            </a>
            <a
                href="{{ route('reports.index', array_merge(request()->query(), ['tab' => 'sales'])) }}"
                class="px-4 py-2 rounded-lg text-xs font-bold transition flex-1 md:flex-initial text-center {{ $activeTab === 'sales' ? 'bg-brand text-white shadow-brand' : '' }}"
                style="{{ $activeTab !== 'sales' ? 'color: var(--text-secondary);' : '' }}"
            >
                Individual Product Sales (View)
            </a>
        </div>

        <!-- Date Range & Search Form -->
        <form method="GET" action="{{ route('reports.index') }}" class="flex flex-wrap items-center gap-2 w-full md:w-auto">
            <input type="hidden" name="tab" value="{{ $activeTab }}">

            <div class="flex items-center space-x-1.5 text-xs">
                <input
                    type="date"
                    name="start_date"
                    value="{{ $startDate }}"
                    class="px-3 py-1.5 rounded-lg text-xs font-mono-nums transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='var(--brand)';"
                    onblur="this.style.borderColor='var(--border)';"
                >
                <span class="text-xs font-medium" style="color: var(--text-muted);">to</span>
                <input
                    type="date"
                    name="end_date"
                    value="{{ $endDate }}"
                    class="px-3 py-1.5 rounded-lg text-xs font-mono-nums transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='var(--brand)';"
                    onblur="this.style.borderColor='var(--border)';"
                >
            </div>

            <div class="relative flex-1 sm:flex-initial">
                <input
                    type="text"
                    name="search"
                    value="{{ $search }}"
                    placeholder="Search invoices..."
                    class="px-3 py-1.5 rounded-lg text-xs transition min-w-[140px]"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='var(--brand)';"
                    onblur="this.style.borderColor='var(--border)';"
                >
            </div>

            <button type="submit" class="glowingbutton px-3.5 py-1.5 rounded-lg text-xs font-bold text-white transition">
                Filter
            </button>

            @if($search || $startDate !== now()->subDays(30)->toDateString() || $endDate !== now()->toDateString())
                <a href="{{ route('reports.index', ['tab' => $activeTab]) }}"
                   class="px-2.5 py-1.5 text-xs font-semibold rounded-lg transition"
                   style="color: var(--text-muted);"
                   onmouseover="this.style.color='var(--text-primary)';"
                   onmouseout="this.style.color='var(--text-muted)';">
                    Clear
                </a>
            @endif
        </form>
    </div>

    <!-- Tab 1: Grouped Invoices -->
    @if($activeTab === 'invoices')
        <div class="rounded-2xl shadow-xl overflow-hidden"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="p-4 flex items-center justify-between"
                 style="background: var(--bg-elevated); border-bottom: 1px solid var(--border);">
                <h4 class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-primary);">Grouped Invoices</h4>
                <span class="text-xs font-mono-nums font-semibold" style="color: var(--text-muted);">{{ $invoices->total() }} total invoices found</span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead>
                        <tr class="text-xs uppercase tracking-wider font-semibold"
                            style="background: var(--bg-elevated); border-bottom: 1px solid var(--border); color: var(--text-muted);">
                            <th class="py-3.5 px-4">Invoice #</th>
                            <th class="py-3.5 px-4">Date &amp; Time</th>
                            <th class="py-3.5 px-4">Cashier</th>
                            <th class="py-3.5 px-4">Items</th>
                            <th class="py-3.5 px-4 text-right">Total Sales</th>
                            <th class="py-3.5 px-4 text-right">Customer Payment</th>
                            <th class="py-3.5 px-4 text-right">Change</th>
                            <th class="py-3.5 px-4 text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y font-mono-nums text-xs" style="border-color: var(--border-subtle);">
                        @forelse($invoices as $inv)
                            <tr class="transition"
                                style="border-bottom: 1px solid var(--border-subtle);"
                                onmouseover="this.style.background='var(--bg-elevated)';"
                                onmouseout="this.style.background='transparent';">
                                <td class="py-3.5 px-4 font-bold text-brand">{{ $inv->invoice_number }}</td>
                                <td class="py-3.5 px-4" style="color: var(--text-secondary);">
                                    {{ $inv->date->format('M d, Y') }} <span style="color: var(--text-muted);">{{ $inv->time }}</span>
                                </td>
                                <td class="py-3.5 px-4 font-sans font-medium" style="color: var(--text-primary);">
                                    {{ $inv->user?->name ?? 'Admin' }}
                                </td>
                                <td class="py-3.5 px-4 font-sans">
                                    <span class="px-2 py-0.5 rounded text-[11px] font-semibold"
                                          style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">
                                        {{ $inv->sales->count() }} items
                                    </span>
                                </td>
                                <td class="py-3.5 px-4 text-right font-extrabold" style="color: var(--text-primary);">
                                    ₱{{ number_format($inv->total_sales, 2) }}
                                </td>
                                <td class="py-3.5 px-4 text-right" style="color: var(--text-secondary);">
                                    ₱{{ number_format($inv->customer_payment, 2) }}
                                </td>
                                <td class="py-3.5 px-4 text-right font-bold text-emerald-600 dark:text-emerald-400">
                                    ₱{{ number_format($inv->customer_change, 2) }}
                                </td>
                                <td class="py-3.5 px-4 text-center font-sans">
                                    <a href="{{ route('pos.invoice', $inv->invoice_id) }}" target="_blank"
                                       class="px-2.5 py-1 rounded-lg text-xs font-semibold transition inline-flex items-center"
                                       style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);"
                                       onmouseover="this.style.borderColor='var(--brand)'; this.style.color='var(--brand)';"
                                       onmouseout="this.style.borderColor='var(--border)'; this.style.color='var(--text-secondary)';">
                                        View Receipt
                                    </a>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="8" class="py-12 text-center font-sans" style="color: var(--text-muted);">
                                    No invoices found for this period.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="p-4" style="background: var(--bg-surface); border-top: 1px solid var(--border);">
                {{ $invoices->links() }}
            </div>
        </div>
    @else
        <!-- Tab 2: Individual Product Sales (using the newsales view) -->
        <div class="rounded-2xl shadow-xl overflow-hidden"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="p-4 flex items-center justify-between"
                 style="background: var(--bg-elevated); border-bottom: 1px solid var(--border);">
                <div>
                    <h4 class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-primary);">Individual Line-Item Sales</h4>
                    <p class="text-[11px] mt-0.5" style="color: var(--text-muted);">Extracted from the <code class="text-brand font-bold">newsales</code> database view</p>
                </div>
                <span class="text-xs font-mono-nums font-semibold" style="color: var(--text-muted);">{{ $individualSales->total() }} sales recorded</span>
            </div>

            <div class="overflow-x-auto">
                <table class="w-full text-left text-sm">
                    <thead>
                        <tr class="text-xs uppercase tracking-wider font-semibold"
                            style="background: var(--bg-elevated); border-bottom: 1px solid var(--border); color: var(--text-muted);">
                            <th class="py-3.5 px-4">Invoice #</th>
                            <th class="py-3.5 px-4">Part Name</th>
                            <th class="py-3.5 px-4">Category</th>
                            <th class="py-3.5 px-4">Brand</th>
                            <th class="py-3.5 px-4 text-right">Unit Price</th>
                            <th class="py-3.5 px-4 text-center">Qty Sold</th>
                            <th class="py-3.5 px-4 text-right">Subtotal</th>
                            <th class="py-3.5 px-4 text-center">Date &amp; Time</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y font-mono-nums text-xs" style="border-color: var(--border-subtle);">
                        @forelse($individualSales as $row)
                            <tr class="transition"
                                style="border-bottom: 1px solid var(--border-subtle);"
                                onmouseover="this.style.background='var(--bg-elevated)';"
                                onmouseout="this.style.background='transparent';">
                                <td class="py-3.5 px-4 font-bold text-brand">{{ $row->invoice_number }}</td>
                                <td class="py-3.5 px-4 font-sans font-bold" style="color: var(--text-primary);">
                                    {{ $row->product_name }}
                                    @if($row->additional_name)
                                        <span class="block text-[10px] font-normal" style="color: var(--text-muted);">{{ $row->additional_name }}</span>
                                    @endif
                                </td>
                                <td class="py-3.5 px-4 font-sans">
                                    <span class="px-2 py-0.5 rounded text-[10px] font-semibold"
                                          style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">
                                        {{ $row->type }}
                                    </span>
                                </td>
                                <td class="py-3.5 px-4 font-sans" style="color: var(--text-secondary);">{{ $row->brand ?? 'OEM' }}</td>
                                <td class="py-3.5 px-4 text-right" style="color: var(--text-secondary);">₱{{ number_format($row->purchase_sale, 2) }}</td>
                                <td class="py-3.5 px-4 text-center font-extrabold" style="color: var(--text-primary);">{{ $row->quantity_sold }}</td>
                                <td class="py-3.5 px-4 text-right font-extrabold text-emerald-600 dark:text-emerald-400">₱{{ number_format($row->subtotal, 2) }}</td>
                                <td class="py-3.5 px-4 text-center" style="color: var(--text-muted);">{{ \Carbon\Carbon::parse($row->created_at)->format('M d, Y h:i A') }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="8" class="py-12 text-center font-sans" style="color: var(--text-muted);">
                                    No item sales found for this period.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="p-4" style="background: var(--bg-surface); border-top: 1px solid var(--border);">
                {{ $individualSales->links() }}
            </div>
        </div>
    @endif
</div>
@endsection
