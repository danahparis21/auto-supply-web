@extends('layouts.app')

@section('page_title', 'Analytics Dashboard')

@section('content')
<div class="space-y-6">

    <!-- Top Metric Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">

        <!-- 1. Today's Revenue -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(159,18,18,0.08);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Today's Revenue</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center font-bold text-sm"
                     style="background: rgba(159,18,18,0.12); border: 1px solid rgba(159,18,18,0.3); color: #9f1212;">₱</div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: var(--text-primary);">
                    ₱{{ number_format($todayRevenue, 2) }}
                </h3>
                <p class="text-xs mt-1 flex items-center" style="color: var(--text-muted);">
                    <span class="font-semibold mr-1.5 font-mono-nums" style="color: #10b981;">{{ $todayOrdersCount }}</span>
                    orders recorded today
                </p>
            </div>
        </div>

        <!-- 2. Top-Selling Product -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none"
                 style="background: rgba(159,18,18,0.06);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Top-Selling Product</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(159,18,18,0.12); border: 1px solid rgba(159,18,18,0.3); color: #9f1212;">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-xl font-bold truncate" style="color: var(--text-primary);"
                    title="{{ $topSellingProduct?->product_name ?? 'N/A' }}">
                    {{ $topSellingProduct?->product_name ?? 'N/A' }}
                </h3>
                <p class="text-xs mt-1" style="color: var(--text-muted);">
                    <span class="font-semibold font-mono-nums" style="color: #9f1212;">{{ $topSellingQty }}</span> units sold overall
                </p>
            </div>
        </div>

        <!-- 3. Low Stock Alert -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none"
                 style="background: rgba(159,18,18,0.08);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Low Stock Alert</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(159,18,18,0.12); border: 1px solid rgba(159,18,18,0.3); color: #9f1212;">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: #9f1212;">
                    {{ $lowStockCount }} <span class="text-sm font-normal" style="color: var(--text-muted);">items critical</span>
                </h3>
                <p class="text-xs mt-1" style="color: var(--text-muted);">
                    @if($lowStockProducts->isNotEmpty())
                        e.g., {{ $lowStockProducts->first()->product_name }} ({{ $lowStockProducts->first()->quantity }} left)
                    @else
                        All product levels healthy
                    @endif
                </p>
            </div>
        </div>

        <!-- 4. Total Catalog Items -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(59,130,246,0.4)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none"
                 style="background: rgba(59,130,246,0.06);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Total Catalog</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(59,130,246,0.12); border: 1px solid rgba(59,130,246,0.3); color: #3b82f6;">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: var(--text-primary);">
                    {{ $totalProducts }} <span class="text-sm font-normal" style="color: var(--text-muted);">SKUs</span>
                </h3>
                <p class="text-xs mt-1" style="color: var(--text-muted);">
                    Active parts &amp; lubricants in database
                </p>
            </div>
        </div>
    </div>

    <!-- Charts Row -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">

        <!-- Daily Sales This Week (Area Chart) -->
        <div class="lg:col-span-2 p-6 rounded-2xl shadow-xl"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h4 class="text-base font-bold" style="color: var(--text-primary);">Daily Sales Trend</h4>
                    <p class="text-xs" style="color: var(--text-muted);">Revenue trajectory over the past 7 days</p>
                </div>
                <span class="px-2.5 py-1 rounded-full text-[11px] font-semibold font-mono-nums"
                      style="background: var(--bg-elevated); border: 1px solid var(--border); color: #9f1212;">
                    7 Days
                </span>
            </div>
            <div class="h-64">
                <canvas id="dailyTrendChart"></canvas>
            </div>
        </div>

        <!-- Sales Distribution Donut -->
        <div class="p-6 rounded-2xl shadow-xl"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h4 class="text-base font-bold" style="color: var(--text-primary);">Product Share</h4>
                    <p class="text-xs" style="color: var(--text-muted);">Distribution by revenue</p>
                </div>
                <span class="w-2.5 h-2.5 rounded-full" style="background: #9f1212;"></span>
            </div>
            <div class="h-64 flex items-center justify-center">
                <canvas id="productShareChart"></canvas>
            </div>
        </div>
    </div>

    <!-- Second Row: Top Products & Low Stock Alerts -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">

        <!-- Top 5 Products Bar Chart -->
        <div class="p-6 rounded-2xl shadow-xl"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center justify-between mb-4">
                <div>
                    <h4 class="text-base font-bold" style="color: var(--text-primary);">Top 5 Best-Selling Parts</h4>
                    <p class="text-xs" style="color: var(--text-muted);">Highest volume items sold</p>
                </div>
            </div>
            <div class="h-64">
                <canvas id="topProductsChart"></canvas>
            </div>
        </div>

        <!-- Low Stock Items Warning Table -->
        <div class="p-6 rounded-2xl shadow-xl flex flex-col justify-between"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div>
                <div class="flex items-center justify-between mb-4">
                    <div>
                        <h4 class="text-base font-bold flex items-center" style="color: var(--text-primary);">
                            <span class="w-2 h-2 rounded-full mr-2 animate-ping" style="background: #9f1212;"></span>
                            Low Stock Warnings
                        </h4>
                        <p class="text-xs" style="color: var(--text-muted);">Products requiring immediate restock (≤ 5 units)</p>
                    </div>
                    <a href="{{ route('inventory.index', ['low_stock' => 1]) }}"
                       class="text-xs font-semibold transition"
                       style="color: #9f1212;"
                       onmouseover="this.style.color='#7f0f0f';"
                       onmouseout="this.style.color='#9f1212';">
                        View all →
                    </a>
                </div>

                @if($lowStockProducts->isEmpty())
                    <div class="p-8 text-center text-sm" style="color: var(--text-muted);">
                        <svg class="w-10 h-10 mx-auto mb-2" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24" style="color: rgba(16,185,129,0.6);">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        All inventory items are currently well stocked!
                    </div>
                @else
                    <div class="overflow-x-auto">
                        <table class="w-full text-left text-xs">
                            <thead>
                                <tr style="color: var(--text-muted); border-bottom: 1px solid var(--border);">
                                    <th class="pb-2">Part Name</th>
                                    <th class="pb-2">Location</th>
                                    <th class="pb-2">Price</th>
                                    <th class="pb-2 text-right">In Stock</th>
                                    <th class="pb-2 text-right">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                @foreach($lowStockProducts->take(4) as $item)
                                    <tr style="border-bottom: 1px solid var(--border-subtle);">
                                        <td class="py-2.5 font-semibold" style="color: var(--text-primary);">
                                            {{ $item->product_name }}
                                            <span class="block text-[10px]" style="color: var(--text-muted);">{{ $item->brand }}</span>
                                        </td>
                                        <td class="py-2.5 font-mono-nums" style="color: var(--text-muted);">{{ $item->location ?? 'General' }}</td>
                                        <td class="py-2.5 font-mono-nums" style="color: var(--text-secondary);">₱{{ number_format($item->price, 2) }}</td>
                                        <td class="py-2.5 text-right font-mono-nums">
                                            <span class="px-2 py-0.5 rounded-full text-[10px] font-bold"
                                                  style="background: rgba(159,18,18,0.12); border: 1px solid rgba(159,18,18,0.3); color: #9f1212;">
                                                {{ $item->quantity }} units
                                            </span>
                                        </td>
                                        <td class="py-2.5 text-right">
                                            <a href="{{ route('inventory.index', ['search' => $item->product_name]) }}"
                                               class="px-2 py-1 rounded text-[11px] font-medium transition"
                                               style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);"
                                               onmouseover="this.style.borderColor='rgba(159,18,18,0.4)'; this.style.color='#9f1212';"
                                               onmouseout="this.style.borderColor='var(--border)'; this.style.color='var(--text-secondary)';">
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

            <div class="mt-4 pt-3 flex items-center justify-between text-xs"
                 style="border-top: 1px solid var(--border); color: var(--text-muted);">
                <span>Threshold: ≤ 5 units</span>
                <span style="color: #9f1212;">{{ $lowStockCount }} items flagged</span>
            </div>
        </div>
    </div>

    <!-- Recent Transactions Table -->
    <div class="p-6 rounded-2xl shadow-xl"
         style="background: var(--bg-surface); border: 1px solid var(--border);">
        <div class="flex items-center justify-between mb-4">
            <div>
                <h4 class="text-base font-bold" style="color: var(--text-primary);">Recent POS Transactions</h4>
                <p class="text-xs" style="color: var(--text-muted);">Latest checkout receipts generated</p>
            </div>
            <a href="{{ route('reports.index') }}"
               class="text-xs font-semibold transition"
               style="color: #9f1212;"
               onmouseover="this.style.color='#7f0f0f';"
               onmouseout="this.style.color='#9f1212';">
                View All Records →
            </a>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead>
                    <tr class="text-xs uppercase tracking-wider" style="color: var(--text-muted); border-bottom: 1px solid var(--border);">
                        <th class="py-3 px-3">Invoice #</th>
                        <th class="py-3 px-3">Date &amp; Time</th>
                        <th class="py-3 px-3">Cashier</th>
                        <th class="py-3 px-3">Items</th>
                        <th class="py-3 px-3 text-right">Total Amount</th>
                        <th class="py-3 px-3 text-right">Payment</th>
                        <th class="py-3 px-3 text-right">Change</th>
                        <th class="py-3 px-3 text-center">Receipt</th>
                    </tr>
                </thead>
                <tbody class="font-mono-nums text-xs">
                    @forelse($recentInvoices as $inv)
                        <tr class="transition" style="border-bottom: 1px solid var(--border-subtle);"
                            onmouseover="this.style.background='var(--bg-elevated)';"
                            onmouseout="this.style.background='transparent';">
                            <td class="py-3 px-3 font-bold" style="color: #9f1212;">{{ $inv->invoice_number }}</td>
                            <td class="py-3 px-3" style="color: var(--text-secondary);">
                                {{ $inv->date->format('M d, Y') }}
                                <span style="color: var(--text-muted);">{{ $inv->time }}</span>
                            </td>
                            <td class="py-3 px-3 font-sans" style="color: var(--text-secondary);">{{ $inv->user?->name ?? 'Admin' }}</td>
                            <td class="py-3 px-3" style="color: var(--text-muted);">{{ $inv->sales->count() }} line items</td>
                            <td class="py-3 px-3 text-right font-bold" style="color: var(--text-primary);">₱{{ number_format($inv->total_sales, 2) }}</td>
                            <td class="py-3 px-3 text-right" style="color: var(--text-secondary);">₱{{ number_format($inv->customer_payment, 2) }}</td>
                            <td class="py-3 px-3 text-right" style="color: #10b981;">₱{{ number_format($inv->customer_change, 2) }}</td>
                            <td class="py-3 px-3 text-center">
                                <a href="{{ route('pos.invoice', $inv->invoice_id) }}"
                                   target="_blank"
                                   class="px-2.5 py-1 rounded-lg text-xs font-sans transition"
                                   style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);"
                                   onmouseover="this.style.borderColor='rgba(159,18,18,0.4)'; this.style.color='#9f1212';"
                                   onmouseout="this.style.borderColor='var(--border)'; this.style.color='var(--text-secondary)';">
                                    Print
                                </a>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="8" class="py-6 text-center font-sans" style="color: var(--text-muted);">No recent transactions recorded yet.</td>
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

    /* ─── Detect current mode ────────────────────────────── */
    const isDark = () => document.documentElement.classList.contains('dark');

    /* ─── Responsive color helpers ───────────────────────── */
    const gridColor   = () => isDark() ? 'rgba(63,63,70,0.5)'  : 'rgba(212,212,216,0.6)';
    const tickColor   = () => isDark() ? '#71717a'             : '#71717a';
    const legendColor = () => isDark() ? '#a1a1aa'             : '#52525b';
    const borderColor = () => isDark() ? '#111111'             : '#ffffff';

    /* ─── Crimson palette (matches logo) ─────────────────── */
    const crimsonSolid = isDark() ? '#ef4444' : '#9f1212';
    const crimsonFill  = isDark() ? 'rgba(239,68,68,0.22)' : 'rgba(159,18,18,0.10)';
    const crimsonPoint = isDark() ? '#0a0a0a' : '#ffffff';

    /* ─── Donut palette — red-toned shades (adapts to mode) ─ */
    const donutColors = isDark() ? [
        '#ef4444', '#dc2626', '#f87171', '#b91c1c', '#fca5a5', '#991b1b', '#fee2e2',
    ] : [
        '#9f1212', '#c0392b', '#e74c3c', '#ff6b6b', '#ff9999', '#b71c1c', '#7f0c0c',
    ];


    /* ══════════════════════════════════════════════════════
       1. Daily Sales Trend — Area Line Chart
    ══════════════════════════════════════════════════════ */
    const dailyCtx = document.getElementById('dailyTrendChart')?.getContext('2d');
    if (dailyCtx) {
        new Chart(dailyCtx, {
            type: 'line',
            data: {
                labels: {!! json_encode($daysLabels) !!},
                datasets: [{
                    label: 'Revenue (₱)',
                    data: {!! json_encode($dailyRevenues) !!},
                    borderColor: crimsonSolid,
                    backgroundColor: crimsonFill,
                    borderWidth: 2.5,
                    fill: true,
                    tension: 0.35,
                    pointBackgroundColor: crimsonSolid,
                    pointBorderColor: crimsonPoint,
                    pointBorderWidth: 2,
                    pointRadius: 4,
                    pointHoverRadius: 7,
                    pointHoverBackgroundColor: crimsonSolid,
                    pointHoverBorderColor: '#ffffff',
                    pointHoverBorderWidth: 2,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: isDark() ? '#1a1a1a' : '#ffffff',
                        titleColor: isDark() ? '#fafafa' : '#09090b',
                        bodyColor: isDark() ? '#a1a1aa' : '#52525b',
                        borderColor: isDark() ? '#27272a' : '#e4e4e7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                return '  Revenue: ₱' + context.raw.toLocaleString(undefined, {minimumFractionDigits: 2, maximumFractionDigits: 2});
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { color: gridColor() },
                        ticks: { color: tickColor(), font: { size: 11, family: 'Plus Jakarta Sans' } }
                    },
                    y: {
                        grid: { color: gridColor() },
                        ticks: {
                            color: tickColor(),
                            font: { size: 11, family: 'JetBrains Mono' },
                            callback: function(val) { return '₱' + val.toLocaleString(); }
                        }
                    }
                }
            }
        });
    }

    /* ══════════════════════════════════════════════════════
       2. Product Share — Doughnut Chart (red palette)
    ══════════════════════════════════════════════════════ */
    const shareCtx = document.getElementById('productShareChart')?.getContext('2d');
    if (shareCtx) {
        const productSales = {!! json_encode($todayProductSales) !!};
        const labels = productSales.map(i => i.product_name);
        const data   = productSales.map(i => parseFloat(i.total_amount));

        new Chart(shareCtx, {
            type: 'doughnut',
            data: {
                labels: labels,
                datasets: [{
                    data: data,
                    backgroundColor: donutColors,
                    borderColor: borderColor(),
                    borderWidth: 3,
                    hoverBorderColor: borderColor(),
                    hoverBorderWidth: 3,
                    hoverOffset: 6,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: {
                            color: legendColor(),
                            font: { size: 10, family: 'Plus Jakarta Sans' },
                            boxWidth: 10,
                            padding: 8
                        }
                    },
                    tooltip: {
                        backgroundColor: isDark() ? '#1a1a1a' : '#ffffff',
                        titleColor: isDark() ? '#fafafa' : '#09090b',
                        bodyColor: isDark() ? '#a1a1aa' : '#52525b',
                        borderColor: isDark() ? '#27272a' : '#e4e4e7',
                        borderWidth: 1,
                        callbacks: {
                            label: function(context) {
                                return '  ₱' + context.raw.toLocaleString(undefined, {minimumFractionDigits: 2});
                            }
                        }
                    }
                },
                cutout: '70%'
            }
        });
    }

    /* ══════════════════════════════════════════════════════
       3. Top Products — Bar Chart (crimson gradient bars)
    ══════════════════════════════════════════════════════ */
    const topCtx = document.getElementById('topProductsChart')?.getContext('2d');
    if (topCtx) {
        const topData = {!! json_encode($top5Products) !!};

        /* Build a vertical gradient per bar */
        const gradient = topCtx.createLinearGradient(0, 0, 0, 256);
        gradient.addColorStop(0,   isDark() ? 'rgba(239,68,68,0.95)' : 'rgba(159,18,18,0.95)');
        gradient.addColorStop(0.6, isDark() ? 'rgba(239,68,68,0.70)' : 'rgba(159,18,18,0.70)');
        gradient.addColorStop(1,   isDark() ? 'rgba(239,68,68,0.20)' : 'rgba(159,18,18,0.30)');

        new Chart(topCtx, {
            type: 'bar',
            data: {
                labels: topData.map(i => i.product_name),
                datasets: [{
                    label: 'Units Sold',
                    data: topData.map(i => i.total_sold),
                    backgroundColor: gradient,
                    borderColor: crimsonSolid,
                    borderWidth: 1,
                    borderRadius: 8,
                    borderSkipped: false,
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        backgroundColor: isDark() ? '#1a1a1a' : '#ffffff',
                        titleColor: isDark() ? '#fafafa' : '#09090b',
                        bodyColor: isDark() ? '#a1a1aa' : '#52525b',
                        borderColor: isDark() ? '#27272a' : '#e4e4e7',
                        borderWidth: 1,
                    }
                },
                scales: {
                    x: {
                        grid: { display: false },
                        ticks: { color: tickColor(), font: { size: 10, family: 'Plus Jakarta Sans' } }
                    },
                    y: {
                        grid: { color: gridColor() },
                        ticks: {
                            color: tickColor(),
                            font: { size: 11, family: 'JetBrains Mono' },
                            precision: 0
                        }
                    }
                }
            }
        });
    }
});
</script>
@endsection
