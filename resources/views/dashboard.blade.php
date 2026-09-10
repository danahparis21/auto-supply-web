@extends('layouts.app')

@section('page_title', 'Analytics Dashboard')

@section('content')
<div class="space-y-6">

    <!-- Top Metric Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
        
        <!-- 1. Today's Revenue -->
        <div class="p-5 rounded-2xl bg-gradient-to-br from-slate-900 to-slate-900/90 border border-slate-800 shadow-xl relative overflow-hidden group hover:border-amber-500/40 transition-all duration-200">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 bg-amber-500/10 rounded-full blur-xl pointer-events-none group-hover:bg-amber-500/20 transition-colors"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider text-slate-400">Today's Revenue</span>
                <div class="w-9 h-9 rounded-xl bg-amber-500/15 border border-amber-500/30 flex items-center justify-center text-amber-400">
                    <span class="font-bold text-sm">₱</span>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold text-white font-mono-nums">
                    ₱{{ number_format($todayRevenue, 2) }}
                </h3>
                <p class="text-xs text-slate-400 mt-1 flex items-center">
                    <span class="text-emerald-400 font-semibold mr-1.5 font-mono-nums">{{ $todayOrdersCount }}</span> orders recorded today
                </p>
            </div>
        </div>

        <!-- 2. Top-Selling Product -->
        <div class="p-5 rounded-2xl bg-gradient-to-br from-slate-900 to-slate-900/90 border border-slate-800 shadow-xl relative overflow-hidden group hover:border-orange-500/40 transition-all duration-200">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 bg-orange-500/10 rounded-full blur-xl pointer-events-none group-hover:bg-orange-500/20 transition-colors"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider text-slate-400">Top-Selling Product</span>
                <div class="w-9 h-9 rounded-xl bg-orange-500/15 border border-orange-500/30 flex items-center justify-center text-orange-400">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-xl font-bold text-white truncate" title="{{ $topSellingProduct?->product_name ?? 'N/A' }}">
                    {{ $topSellingProduct?->product_name ?? 'N/A' }}
                </h3>
                <p class="text-xs text-slate-400 mt-1">
                    <span class="text-orange-400 font-semibold font-mono-nums">{{ $topSellingQty }}</span> units sold overall
                </p>
            </div>
        </div>

        <!-- 3. Low Stock Alert -->
        <div class="p-5 rounded-2xl bg-gradient-to-br from-slate-900 to-slate-900/90 border border-slate-800 shadow-xl relative overflow-hidden group hover:border-red-500/40 transition-all duration-200">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 bg-red-500/10 rounded-full blur-xl pointer-events-none group-hover:bg-red-500/20 transition-colors"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider text-slate-400">Low Stock Alert</span>
                <div class="w-9 h-9 rounded-xl bg-red-500/15 border border-red-500/30 flex items-center justify-center text-red-400">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold text-red-400 font-mono-nums">
                    {{ $lowStockCount }} <span class="text-sm font-normal text-slate-400">items critical</span>
                </h3>
                <p class="text-xs text-slate-400 mt-1">
                    @if($lowStockProducts->isNotEmpty())
                        e.g., {{ $lowStockProducts->first()->product_name }} ({{ $lowStockProducts->first()->quantity }} left)
                    @else
                        All product levels healthy
                    @endif
                </p>
            </div>
        </div>

        <!-- 4. Total Catalog Items -->
        <div class="p-5 rounded-2xl bg-gradient-to-br from-slate-900 to-slate-900/90 border border-slate-800 shadow-xl relative overflow-hidden group hover:border-blue-500/40 transition-all duration-200">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 bg-blue-500/10 rounded-full blur-xl pointer-events-none group-hover:bg-blue-500/20 transition-colors"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider text-slate-400">Total Catalog</span>
                <div class="w-9 h-9 rounded-xl bg-blue-500/15 border border-blue-500/30 flex items-center justify-center text-blue-400">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold text-white font-mono-nums">
                    {{ $totalProducts }} <span class="text-sm font-normal text-slate-400">SKUs</span>
                </h3>
                <p class="text-xs text-slate-400 mt-1">
                    Active parts & lubricants in database
                </p>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
        
        <!-- Daily Sales This Week (Area Chart) -->
        <div class="lg:col-span-2 p-6 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h4 class="text-base font-bold text-white">Daily Sales Trend</h4>
                    <p class="text-xs text-slate-400">Revenue trajectory over the past 7 days</p>
                </div>
                <span class="px-2.5 py-1 rounded-full bg-slate-800 border border-slate-700 text-[11px] font-semibold text-amber-400 font-mono-nums">
                    7 Days
                </span>
            </div>
            <div class="h-64">
                <canvas id="dailyTrendChart"></canvas>
            </div>
        </div>

        <!-- Sales Distribution Donut -->
        <div class="p-6 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h4 class="text-base font-bold text-white">Product Share</h4>
                    <p class="text-xs text-slate-400">Distribution by revenue</p>
                </div>
                <span class="w-2.5 h-2.5 rounded-full bg-amber-500"></span>
            </div>
            <div class="h-64 flex items-center justify-center">
                <canvas id="productShareChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Second Row: Top Products & Low Stock Alerts -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
        
        <!-- Top 5 Products Bar Chart -->
        <div class="p-6 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h4 class="text-base font-bold text-white">Top 5 Best-Selling Parts</h4>
                    <p class="text-xs text-slate-400">Highest volume items sold</p>
                </div>
            </div>
            <div class="h-64">
                <canvas id="topProductsChart"></canvas>
            </div>
        </div>

        <!-- Low Stock Items Warning Table -->
        <div class="p-6 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl flex flex-col justify-between">
            <div>
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h4 class="text-base font-bold text-white flex items-center">
                            <span class="w-2 h-2 rounded-full bg-red-500 mr-2 animate-ping"></span>
                            Low Stock Warnings
                        </h4>
                        <p class="text-xs text-slate-400">Products requiring immediate restock (≤ 5 units)</p>
                    </div>
                    <a href="{{ route('inventory.index', ['low_stock' => 1]) }}" class="text-xs font-semibold text-amber-400 hover:text-amber-300">
                        View all →
                    </a>
                </div>

                @if($lowStockProducts->isEmpty())
                    <div class="p-8 text-center text-slate-400 text-sm">
                        <svg class="w-10 h-10 mx-auto text-emerald-400/60 mb-2" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        All inventory items are currently well stocked!
                    </div>
                @else
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-xs">
                            <thead>
                                <tr class="text-slate-400 border-b border-slate-800">
                                    <th class="pb-2">Part Name</th>
                                    <th class="pb-2">Location</th>
                                    <th class="pb-2">Price</th>
                                    <th class="pb-2 text-right">In Stock</th>
                                    <th class="pb-2 text-right">Action</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-800/60">
                                @foreach($lowStockProducts->take(4) as $item)
                                    <tr class="hover:bg-slate-800/30">
                                        <td class="py-2.5 font-semibold text-white">
                                            {{ $item->product_name }}
                                            <span class="block text-[10px] text-slate-400">{{ $item->brand }}</span>
                                        </td>
                                        <td class="py-2.5 text-slate-400 font-mono-nums">{{ $item->location ?? 'General' }}</td>
                                        <td class="py-2.5 text-slate-300 font-mono-nums">₱{{ number_format($item->price, 2) }}</td>
                                        <td class="py-2.5 text-right font-mono-nums">
                                            <span class="px-2 py-0.5 rounded-full text-[10px] font-bold {{ $item->quantity <= 0 ? 'bg-red-500/20 text-red-400 border border-red-500/30' : 'bg-amber-500/20 text-amber-400 border border-amber-500/30' }}">
                                                {{ $item->quantity }} units
                                            </span>
                                        </td>
                                        <td class="py-2.5 text-right">
                                            <a href="{{ route('inventory.index', ['search' => $item->product_name]) }}" class="px-2 py-1 rounded bg-slate-800 hover:bg-slate-700 text-slate-200 text-[11px] font-medium transition">
                                                Restock
                                            </a>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                @endif
            </div>

            <div class="mt-4 pt-3 border-t border-slate-800/80 flex items-center justify-between text-xs text-slate-400">
                <span>Threshold: ≤ 5 units</span>
                <span class="text-amber-400">{{ $lowStockCount }} items flagged</span>
            </div>
        </div>
    </div>

    <!-- Recent Transactions Table -->
    <div class="p-6 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl">
        <div class="flex items-center justify-between mb-4">
            <div>
                <h4 class="text-base font-bold text-white">Recent POS Transactions</h4>
                <p class="text-xs text-slate-400">Latest checkout receipts generated</p>
            </div>
            <a href="{{ route('reports.index') }}" class="text-xs font-semibold text-amber-400 hover:text-amber-300">
                View All Records →
            </a>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead>
                    <tr class="text-xs uppercase tracking-wider text-slate-400 border-b border-slate-800">
                        <th class="py-3 px-3">Invoice #</th>
                        <th class="py-3 px-3">Date & Time</th>
                        <th class="py-3 px-3">Cashier</th>
                        <th class="py-3 px-3">Items</th>
                        <th class="py-3 px-3 text-right">Total Amount</th>
                        <th class="py-3 px-3 text-right">Payment</th>
                        <th class="py-3 px-3 text-right">Change</th>
                        <th class="py-3 px-3 text-center">Receipt</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800/60 font-mono-nums text-xs">
                    @forelse($recentInvoices as $inv)
                        <tr class="hover:bg-slate-800/40 transition">
                            <td class="py-3 px-3 font-bold text-amber-400">{{ $inv->invoice_number }}</td>
                            <td class="py-3 px-3 text-slate-300">{{ $inv->date->format('M d, Y') }} <span class="text-slate-500">{{ $inv->time }}</span></td>
                            <td class="py-3 px-3 font-sans text-slate-300">{{ $inv->user?->name ?? 'Admin' }}</td>
                            <td class="py-3 px-3 text-slate-400">{{ $inv->sales->count() }} line items</td>
                            <td class="py-3 px-3 text-right font-bold text-white">₱{{ number_format($inv->total_sales, 2) }}</td>
                            <td class="py-3 px-3 text-right text-slate-300">₱{{ number_format($inv->customer_payment, 2) }}</td>
                            <td class="py-3 px-3 text-right text-emerald-400">₱{{ number_format($inv->customer_change, 2) }}</td>
                            <td class="py-3 px-3 text-center">
                                <a href="{{ route('pos.invoice', $inv->invoice_id) }}" target="_blank" class="px-2.5 py-1 rounded-lg bg-slate-800 hover:bg-slate-700 text-slate-300 text-xs font-sans transition">
                                    Print
                                </a>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="8" class="py-6 text-center text-slate-500 font-sans">No recent transactions recorded yet.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Chart.js Setup Scripts -->
<script>
document.addEventListener('DOMContentLoaded', function () {
    if (typeof Chart === 'undefined') return;

    // 1. Daily Sales Trend Chart
    const dailyCtx = document.getElementById('dailyTrendChart')?.getContext('2d');
    if (dailyCtx) {
        new Chart(dailyCtx, {
            type: 'line',
            data: {
                labels: {!! json_encode($daysLabels) !!},
                datasets: [{
                    label: 'Revenue (₱)',
                    data: {!! json_encode($dailyRevenues) !!},
                    borderColor: '#f59e0b',
                    backgroundColor: 'rgba(245, 158, 11, 0.15)',
                    borderWidth: 2.5,
                    fill: true,
                    tension: 0.35,
                    pointBackgroundColor: '#f59e0b',
                    pointBorderColor: '#0f172a',
                    pointBorderWidth: 2,
                    pointRadius: 4,
                    pointHoverRadius: 6,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return ' Revenue: ₱' + context.raw.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(51, 65, 85, 0.3)' },
                        ticks: { color: '#94a3b8', font: { size: 11 } }
                    },
                    y: {
                        grid: { color: 'rgba(51, 65, 85, 0.3)' },
                        ticks: {
                            color: '#94a3b8',
                            font: { size: 11 },
                            callback: function(val) { return '₱' + val.toLocaleString(); }
                        }
                    }
                }
            }
        });
    }

    // 2. Product Share Chart
    const shareCtx = document.getElementById('productShareChart')?.getContext('2d');
    if (shareCtx) {
        const productSales = {!! json_encode($todayProductSales) !!};
        const labels = productSales.map(i => i.product_name);
        const data = productSales.map(i => parseFloat(i.total_amount));

        new Chart(shareCtx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: [
                        '#f59e0b', '#3b82f6', '#10b981', '#ef4444', '#8b5cf6', '#06b6d4', '#f97316'
                    ],
                    borderColor: '#0f172a',
                    borderWidth: 2,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { color: '#cbd5e1', font: { size: 10 }, boxWidth: 10, padding: 8 }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return ' ₱' + context.raw.toLocaleString(undefined, {minimumFractionDigits: 2});
                            }
                        }
                    }
                },
                cutout: '70%'
            }
        });
    }

    // 3. Top Products Chart
    const topCtx = document.getElementById('topProductsChart')?.getContext('2d');
    if (topCtx) {
        const topData = {!! json_encode($top5Products) !!};
        new Chart(topCtx, {
            type: 'bar',
            data: {
                labels: topData.map(i => i.product_name),
                datasets: [{
                    label: 'Units Sold',
                    data: topData.map(i => i.total_sold),
                    backgroundColor: 'rgba(245, 158, 11, 0.85)',
                    borderRadius: 6,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { color: '#94a3b8', font: { size: 10 } }
                    },
                    y: {
                        grid: { color: 'rgba(51, 65, 85, 0.3)' },
                        ticks: { color: '#94a3b8', font: { size: 11 }, precision: 0 }
                    }
                }
            }
        });
    }
});
</script>
@endsection
