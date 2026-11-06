@extends('layouts.app')

@section('page_title', 'Inventory & Product Catalog')

@section('content')
<div x-data="inventoryManager()" class="space-y-6">

    <!-- KPI Summary Cards (Matches Dashboard KPI Design) -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">

        <!-- 1. Total Catalog SKUs -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(59,130,246,0.06);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Total Catalog SKUs</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(59,130,246,0.12); border: 1px solid rgba(59,130,246,0.3); color: #3b82f6;">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"/>
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: var(--text-primary);">
                    {{ $totalInventoryCount }}
                </h3>
                <p class="text-xs mt-1 flex items-center" style="color: var(--text-muted);">
                    <span class="font-semibold mr-1.5" style="color: var(--text-secondary);">Active products</span> in inventory
                </p>
            </div>
        </div>

        <!-- 2. Low Stock Alert -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(159,18,18,0.08);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Low Stock Alert</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(159,18,18,0.12); border: 1px solid rgba(159,18,18,0.3); color: var(--brand);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/>
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums text-brand">
                    {{ $lowStockCount }} <span class="text-sm font-normal" style="color: var(--text-muted);">critical</span>
                </h3>
                <p class="text-xs mt-1">
                    <a href="{{ route('inventory.index', ['low_stock' => 1]) }}" class="font-semibold text-brand transition hover:underline">
                        Filter low stock items &rarr;
                    </a>
                </p>
            </div>
        </div>

        <!-- 3. Out of Stock -->
        <div class="p-5 rounded-2xl shadow-xl relative overflow-hidden group transition-all duration-200"
             style="background: var(--bg-surface); border: 1px solid var(--border);"
             onmouseover="this.style.borderColor='rgba(159,18,18,0.5)';"
             onmouseout="this.style.borderColor='var(--border)';">
            <div class="absolute -right-4 -bottom-4 w-24 h-24 rounded-full blur-xl pointer-events-none transition-colors"
                 style="background: rgba(239,68,68,0.06);"></div>
            <div class="flex items-center justify-between">
                <span class="text-xs font-bold uppercase tracking-wider" style="color: var(--text-muted);">Out of Stock</span>
                <div class="w-9 h-9 rounded-xl flex items-center justify-center"
                     style="background: rgba(239,68,68,0.12); border: 1px solid rgba(239,68,68,0.3); color: #ef4444;">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"/>
                    </svg>
                </div>
            </div>
            <div class="mt-3">
                <h3 class="text-2xl font-extrabold font-mono-nums" style="color: #ef4444;">
                    {{ $outOfStockCount }}
                </h3>
                <p class="text-xs mt-1 flex items-center" style="color: var(--text-muted);">
                    <span class="font-semibold mr-1.5 text-brand">Requires restocking</span> immediately
                </p>
            </div>
        </div>
    </div>

    <!-- Controls Bar -->
    <div class="p-4 rounded-2xl shadow-xl flex flex-col md:flex-row items-center justify-between gap-4"
         style="background: var(--bg-surface); border: 1px solid var(--border);">

        <form method="GET" action="{{ route('inventory.index') }}" class="flex-1 w-full flex flex-wrap items-center gap-3">
            <!-- Search -->
            <div class="relative flex-1 min-w-[200px]">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                </div>
                <input
                    type="text"
                    name="search"
                    value="{{ $search }}"
                    placeholder="Search by name, brand, location..."
                    class="w-full pl-10 pr-4 py-2 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='var(--brand)';"
                    onblur="this.style.borderColor='var(--border)';"
                >
            </div>

            <!-- Brand Filter -->
            <select
                name="type"
                onchange="this.form.submit()"
                class="px-3 py-2 rounded-xl text-xs font-semibold transition"
                style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
            >
                <option value="All" {{ $selectedCategory === 'All' ? 'selected' : '' }}>All Parts</option>
                @foreach($categories as $cat)
                    <option value="{{ $cat }}" {{ $selectedCategory === $cat ? 'selected' : '' }}>{{ $cat }}</option>
                @endforeach
            </select>

            <!-- Low Stock Toggle -->
            <a
                href="{{ $isLowStockFilter ? route('inventory.index') : route('inventory.index', ['low_stock' => 1]) }}"
                class="px-3 py-2 rounded-xl text-xs font-semibold border transition flex items-center"
                style="{{ $isLowStockFilter ? 'background: var(--brand); color: #fff; border-color: var(--brand);' : 'background: var(--bg-elevated); color: var(--text-secondary); border-color: var(--border);' }}"
            >
                <span class="w-2 h-2 rounded-full mr-1.5" style="{{ $isLowStockFilter ? 'background: rgba(255,255,255,0.7);' : 'background: #f59e0b;' }}"></span>
                Low Stock Only
            </a>

            @if($search || $selectedCategory !== 'All' || $isLowStockFilter)
                <a href="{{ route('inventory.index') }}" class="px-2.5 py-2 text-xs font-semibold transition"
                   style="color: var(--text-muted);"
                   onmouseover="this.style.color='var(--text-primary)';"
                   onmouseout="this.style.color='var(--text-muted)';">Reset</a>
            @endif
        </form>

        <!-- Add Part Button -->
        <button @click="openAddModal()"
                class="w-full md:w-auto px-4 py-2.5 rounded-xl text-white font-bold text-xs uppercase tracking-wider transition flex items-center justify-center whitespace-nowrap glowingbutton btn-brand">
            <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
            Add New Part
        </button>
    </div>

    <!-- Inventory Table -->
    <div class="rounded-2xl shadow-xl overflow-hidden" style="background: var(--bg-surface); border: 1px solid var(--border);">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead>
                    <tr class="text-xs uppercase tracking-wider" style="color: var(--text-muted); border-bottom: 1px solid var(--border); background: var(--bg-elevated);">
                        <th class="py-3.5 px-4">Part Details</th>
                        <th class="py-3.5 px-4">Category</th>
                        <th class="py-3.5 px-4">Brand</th>
                        <th class="py-3.5 px-4">Location</th>
                        <th class="py-3.5 px-4 text-right">Price</th>
                        <th class="py-3.5 px-4 text-center">Stock Status</th>
                        <th class="py-3.5 px-4 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($products as $product)
                        <tr class="transition"
                            style="border-bottom: 1px solid var(--border-subtle);"
                            onmouseover="this.style.background='var(--bg-elevated)';"
                            onmouseout="this.style.background='transparent';">
                            <td class="py-3.5 px-4">
                                <div class="flex items-center space-x-3">
                                    <img src="{{ $product->image ? asset($product->image) : asset('images/products/default.svg') }}"
                                         alt="{{ $product->product_name }}"
                                         class="w-10 h-10 rounded-xl object-cover flex-shrink-0 border p-1 shadow-sm"
                                         style="background: var(--bg-base); border-color: var(--border);"
                                         onerror="this.onerror=null; this.src='{{ asset('images/products/default.svg') }}';"
                                         loading="lazy">
                                    <div class="min-w-0">
                                        <div class="font-bold leading-snug truncate" style="color: var(--text-primary);">{{ $product->product_name }}</div>
                                        @if($product->additional_name)
                                            <div class="text-xs truncate max-w-xs" style="color: var(--text-muted);">{{ $product->additional_name }}</div>
                                        @endif
                                    </div>
                                </div>
                            </td>
                            <td class="py-3.5 px-4">
                                <span class="px-2.5 py-1 rounded-md text-[11px] font-semibold"
                                      style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">
                                    {{ $product->type }}
                                </span>
                            </td>
                            <td class="py-3.5 px-4 text-xs font-medium" style="color: var(--text-secondary);">{{ $product->brand ?? 'OEM' }}</td>
                            <td class="py-3.5 px-4 font-mono-nums text-xs" style="color: var(--text-muted);">{{ $product->location ?? 'General' }}</td>
                            <td class="py-3.5 px-4 text-right font-mono-nums font-bold text-sm text-brand">₱{{ number_format($product->price, 2) }}</td>
                            <td class="py-3.5 px-4 text-center font-mono-nums">
                                @if($product->quantity <= 0)
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-red-500/15 text-red-600 dark:text-red-400 border border-red-500/30">
                                        0 (Out of stock)
                                    </span>
                                @elseif($product->quantity <= 5)
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-red-500/15 text-red-600 dark:text-red-400 border border-red-500/30">
                                        {{ $product->quantity }} (Low stock)
                                    </span>
                                @else
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 border border-emerald-500/30">
                                        {{ $product->quantity }} in stock
                                    </span>
                                @endif
                            </td>
                            <td class="py-3.5 px-4 text-right">
                                <div class="flex items-center justify-end space-x-1.5">
                                    <button @click="openRestockModal({{ json_encode($product) }})"
                                            title="Quick Restock"
                                            class="p-1.5 rounded-lg transition"
                                            style="background: var(--bg-elevated); border: 1px solid var(--border); color: #10b981;">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/></svg>
                                    </button>
                                    <button @click="openEditModal({{ json_encode($product) }})"
                                            title="Edit Product"
                                            class="p-1.5 rounded-lg transition"
                                            style="background: var(--bg-elevated); border: 1px solid var(--border);"
                                            onmouseover="this.style.color='var(--brand)';"
                                            onmouseout="this.style.color='var(--text-muted)';">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                                    </button>
                                    <button type="button"
                                            @click="openDeleteModal({{ json_encode($product) }})"
                                            title="Delete Product"
                                            class="p-1.5 rounded-lg transition cursor-pointer"
                                            style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-muted);"
                                            onmouseover="this.style.color='#dc2626';this.style.borderColor='rgba(220,38,38,0.4)';"
                                            onmouseout="this.style.color='var(--text-muted)';this.style.borderColor='var(--border)';">
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="py-12 text-center" style="color: var(--text-muted);">No products found matching your filter criteria.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
        <div class="p-4" style="border-top: 1px solid var(--border); background: var(--bg-elevated);">
            {{ $products->links() }}
        </div>
    </div>

    <!-- Modal: Add New Product -->
    <div x-show="showAddModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 backdrop-blur-sm" style="background: rgba(0,0,0,0.65);">
        <div class="rounded-2xl max-w-lg w-full p-6 shadow-2xl space-y-4 max-h-[90vh] overflow-y-auto" style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center justify-between pb-3" style="border-bottom: 1px solid var(--border);">
                <div>
                    <h3 class="text-base font-extrabold" style="color: var(--text-primary);">Add New Auto Part</h3>
                    <p class="text-xs" style="color: var(--text-muted);">Fill in the part details and upload a photo for the catalog</p>
                </div>
                <button @click="showAddModal = false" style="color: var(--text-muted);"
                        onmouseover="this.style.color='var(--text-primary)';"
                        onmouseout="this.style.color='var(--text-muted)';">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>

            <form method="POST" action="{{ route('inventory.store') }}" enctype="multipart/form-data" class="space-y-4 text-xs">
                @csrf

                <!-- Fixed-Dimension Centered Image Upload Square -->
                <div class="flex flex-col items-center justify-center pt-1 pb-2">
                    <div
                        @click="$refs.addImageInput.click()"
                        class="rounded-2xl border-2 border-dashed flex items-center justify-center cursor-pointer transition-all relative overflow-hidden group shadow-sm"
                        style="width: 130px; height: 130px; background: var(--bg-elevated); border-color: var(--border);"
                        onmouseover="this.style.borderColor='var(--brand)'; this.style.background='var(--bg-base)';"
                        onmouseout="this.style.borderColor='var(--border)'; this.style.background='var(--bg-elevated)';"
                    >
                        <!-- Image Preview if chosen -->
                        <template x-if="addImagePreview">
                            <div class="w-full h-full relative">
                                <img :src="addImagePreview"
                                     style="width: 130px; height: 130px; object-fit: cover;"
                                     class="rounded-2xl">
                                <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex flex-col items-center justify-center text-center p-2">
                                    <svg class="w-5 h-5 text-white mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                                    <span class="text-[10px] font-bold text-white uppercase tracking-wider">Change</span>
                                </div>
                            </div>
                        </template>

                        <!-- Empty Placeholder State -->
                        <template x-if="!addImagePreview">
                            <div class="text-center p-3 space-y-1.5 flex flex-col items-center justify-center">
                                <div class="w-9 h-9 rounded-full flex items-center justify-center"
                                     style="background: rgba(159, 18, 18, 0.1); color: #dc2626;">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                                    </svg>
                                </div>
                                <span class="text-[11px] font-bold block" style="color: var(--brand);">Upload Photo</span>
                                <span class="text-[9px] block" style="color: var(--text-muted);">Max 2MB</span>
                            </div>
                        </template>

                        <input
                            type="file"
                            name="image"
                            x-ref="addImageInput"
                            @change="previewAddImage($event)"
                            accept="image/jpeg,image/png,image/webp"
                            class="hidden"
                        >
                    </div>
                    <p class="text-[11px] font-medium text-center mt-2" style="color: var(--text-muted);">Click box to upload product photo (JPG, PNG, WebP)</p>
                </div>

                <div style="border-top: 1px solid var(--border);"></div>

                <!-- Form Fields with Generous Spacing -->
                <div style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); column-gap: 20px; row-gap: 34px; padding-top: 18px; padding-bottom: 8px;">
                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Product Name <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="text" name="product_name" required placeholder="e.g. Alternator Carbon Brush" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Category / Type <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="text" name="type" required placeholder="e.g. 37A, Fluids, Filters" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-bold" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Brand / Manufacturer
                        </label>
                        <input type="text" name="brand" placeholder="e.g. FCC, Bosch, Petron" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Additional Specs / Sub-Name
                        </label>
                        <input type="text" name="additional_name" placeholder="e.g. Standard 12V 4-Pin, 5W-30 Synthetic" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Selling Price (₱) <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="number" step="any" name="price" required placeholder="0.00" class="w-full px-4 py-2.5 rounded-xl font-mono font-bold text-xs transition" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Initial Quantity <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="number" name="quantity" required value="10" min="0" class="w-full px-4 py-2.5 rounded-xl font-mono font-bold text-xs transition" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Store / Shelf Location
                        </label>
                        <input type="text" name="location" placeholder="e.g. Shelf B1, Rack 2" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Description / Notes
                        </label>
                        <textarea name="description" rows="2" placeholder="Compatibility or warranty details..." class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';"></textarea>
                    </div>
                </div>

                <div class="pt-3 flex items-center justify-end space-x-2" style="border-top: 1px solid var(--border);">
                    <button type="button" @click="showAddModal = false" class="px-4 py-2.5 rounded-xl text-xs font-semibold transition cursor-pointer" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">Cancel</button>
                    <button type="submit" class="px-5 py-2.5 rounded-xl text-white font-extrabold text-xs transition bg-brand hover:opacity-90 shadow-md shadow-red-600/25 cursor-pointer">Add Part to Catalog</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal: Edit Product -->
    <div x-show="showEditModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 backdrop-blur-sm" style="background: rgba(0,0,0,0.65);">
        <div class="rounded-2xl max-w-lg w-full p-6 shadow-2xl space-y-4 max-h-[90vh] overflow-y-auto" style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center justify-between pb-3" style="border-bottom: 1px solid var(--border);">
                <div>
                    <h3 class="text-base font-extrabold" style="color: var(--text-primary);">Edit Product</h3>
                    <p class="text-xs" style="color: var(--text-muted);" x-text="'Updating #' + (editItem.product_id || '') + ' - ' + (editItem.product_name || '')"></p>
                </div>
                <button @click="showEditModal = false" style="color: var(--text-muted);"
                        onmouseover="this.style.color='var(--text-primary)';"
                        onmouseout="this.style.color='var(--text-muted)';">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>

            <form :action="'/inventory/' + editItem.product_id" method="POST" enctype="multipart/form-data" class="space-y-4 text-xs">
                @csrf
                @method('PUT')

                <!-- Fixed-Dimension Centered Image Edit Square -->
                <div class="flex flex-col items-center justify-center pt-1 pb-2">
                    <div
                        @click="$refs.editImageInput.click()"
                        class="rounded-2xl border-2 border-dashed flex items-center justify-center cursor-pointer transition-all relative overflow-hidden group shadow-sm"
                        style="width: 130px; height: 130px; background: var(--bg-elevated); border-color: var(--border);"
                        onmouseover="this.style.borderColor='var(--brand)'; this.style.background='var(--bg-base)';"
                        onmouseout="this.style.borderColor='var(--border)'; this.style.background='var(--bg-elevated)';"
                    >
                        <img :src="editImagePreview || '/images/products/default.svg'"
                             style="width: 130px; height: 130px; object-fit: cover;"
                             class="rounded-2xl transition group-hover:scale-105"
                             onerror="this.src='/images/products/default.svg'">
                        <div class="absolute inset-0 bg-black/50 opacity-0 group-hover:opacity-100 transition-opacity flex flex-col items-center justify-center text-center p-2">
                            <svg class="w-5 h-5 text-white mb-1" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z"/><path stroke-linecap="round" stroke-linejoin="round" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z"/></svg>
                            <span class="text-[10px] font-bold text-white uppercase tracking-wider">Change Photo</span>
                        </div>

                        <input
                            type="file"
                            name="image"
                            x-ref="editImageInput"
                            @change="previewEditImage($event)"
                            accept="image/jpeg,image/png,image/webp"
                            class="hidden"
                        >
                    </div>
                    <p class="text-[11px] font-medium text-center mt-2" style="color: var(--text-muted);">Click box to change photo (JPG, PNG, WebP)</p>
                </div>

                <div style="border-top: 1px solid var(--border);"></div>

                <!-- Form Fields with Generous Spacing -->
                <div style="display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); column-gap: 20px; row-gap: 34px; padding-top: 18px; padding-bottom: 8px;">
                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Product Name <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="text" name="product_name" x-model="editItem.product_name" required class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Category / Type <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="text" name="type" x-model="editItem.type" required class="w-full px-4 py-2.5 rounded-xl text-xs transition font-bold" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Brand / Manufacturer
                        </label>
                        <input type="text" name="brand" x-model="editItem.brand" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Additional Specs / Sub-Name
                        </label>
                        <input type="text" name="additional_name" x-model="editItem.additional_name" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Selling Price (₱) <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="number" step="any" name="price" x-model="editItem.price" required class="w-full px-4 py-2.5 rounded-xl font-mono font-bold text-xs transition" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div>
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Current Quantity <span style="color: #dc2626;">*</span>
                        </label>
                        <input type="number" name="quantity" x-model="editItem.quantity" required min="0" class="w-full px-4 py-2.5 rounded-xl font-mono font-bold text-xs transition" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>

                    <div style="grid-column: span 2;">
                        <label style="display: block; font-weight: 800; font-size: 11px; text-transform: uppercase; letter-spacing: 0.05em; color: var(--text-secondary); margin-bottom: 10px; margin-top: 4px;">
                            Store / Shelf Location
                        </label>
                        <input type="text" name="location" x-model="editItem.location" class="w-full px-4 py-2.5 rounded-xl text-xs transition font-medium" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;" onfocus="this.style.borderColor='var(--brand)';" onblur="this.style.borderColor='var(--border)';">
                    </div>
                </div>

                <div class="pt-3 flex items-center justify-end space-x-2" style="border-top: 1px solid var(--border);">
                    <button type="button" @click="showEditModal = false" class="px-4 py-2.5 rounded-xl text-xs font-semibold transition cursor-pointer" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">Cancel</button>
                    <button type="submit" class="px-5 py-2.5 rounded-xl text-white font-extrabold text-xs transition bg-brand hover:opacity-90 shadow-md shadow-red-600/25 cursor-pointer">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal: Quick Restock -->
    <div x-show="showRestockModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 backdrop-blur-sm" style="background: rgba(0,0,0,0.5);">
        <div class="rounded-2xl max-w-sm w-full p-6 shadow-2xl space-y-4" style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center justify-between pb-3" style="border-bottom: 1px solid var(--border);">
                <h3 class="text-base font-bold" style="color: var(--text-primary);">Quick Restock</h3>
                <button @click="showRestockModal = false" style="color: var(--text-muted);"
                        onmouseover="this.style.color='var(--text-primary)';"
                        onmouseout="this.style.color='var(--text-muted)';">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>
            <form :action="'/inventory/' + restockItem.product_id + '/restock'" method="POST" class="space-y-4 text-xs">
                @csrf
                <div>
                    <h5 class="font-bold text-sm" style="color: var(--text-primary);" x-text="restockItem.product_name"></h5>
                    <p class="font-mono-nums" style="color: var(--text-muted);" x-text="'Current Stock: ' + restockItem.quantity + ' units'"></p>
                </div>
                <div>
                    <label class="block font-bold mb-1" style="color: var(--text-secondary);">Additional Quantity to Add *</label>
                    <input type="number" name="additional_quantity" required min="1" value="10"
                           class="w-full px-3 py-2 rounded-xl font-mono text-sm transition"
                           style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                           onfocus="this.style.borderColor='var(--brand)';"
                           onblur="this.style.borderColor='var(--border)';">
                </div>
                <div class="pt-2 flex items-center justify-end space-x-2" style="border-top: 1px solid var(--border);">
                    <button type="button" @click="showRestockModal = false" class="px-3 py-2 rounded-xl text-xs transition cursor-pointer" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">Cancel</button>
                    <button type="submit" class="px-4 py-2 rounded-xl text-white font-bold text-xs bg-emerald-600 hover:bg-emerald-500 transition cursor-pointer">Confirm Restock</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal: Delete Product Confirmation -->
    <div x-show="showDeleteModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 backdrop-blur-sm" style="background: rgba(0,0,0,0.65);" @keydown.escape.window="showDeleteModal = false">
        <div @click.away="showDeleteModal = false" class="rounded-2xl max-w-md w-full p-6 shadow-2xl space-y-4" style="background: var(--bg-surface); border: 1px solid var(--border);">
            <div class="flex items-center space-x-3.5 pb-3" style="border-bottom: 1px solid var(--border);">
                <div class="w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0"
                     style="background: rgba(220,38,38,0.12); border: 1px solid rgba(220,38,38,0.3); color: #dc2626;">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                    </svg>
                </div>
                <div>
                    <h3 class="text-base font-bold" style="color: var(--text-primary);">Delete Product</h3>
                    <p class="text-xs" style="color: var(--text-muted);">Confirm removal from catalog</p>
                </div>
            </div>

            <div class="space-y-3 text-xs">
                <p style="color: var(--text-secondary);">
                    Are you sure you want to permanently delete this product?
                </p>

                <!-- Product Preview Card -->
                <div class="p-3.5 rounded-xl space-y-1.5" style="background: var(--bg-elevated); border: 1px solid var(--border);">
                    <div class="font-bold text-sm" style="color: var(--text-primary);" x-text="deleteItem.product_name"></div>
                    <div class="flex items-center space-x-3 text-xs" style="color: var(--text-muted);">
                        <span>SKU: <strong class="font-mono text-xs" style="color: var(--text-secondary);" x-text="deleteItem.sku || 'N/A'"></strong></span>
                        <span>•</span>
                        <span>Stock: <strong class="font-mono text-xs" style="color: var(--text-secondary);" x-text="(deleteItem.quantity || 0) + ' units'"></strong></span>
                        <span>•</span>
                        <span>Price: <strong class="font-mono text-xs" style="color: var(--text-secondary);" x-text="'₱' + Number(deleteItem.selling_price || 0).toLocaleString('en-US', { minimumFractionDigits: 2, maximumFractionDigits: 2 })"></strong></span>
                    </div>
                </div>

                <div class="p-3 rounded-xl flex items-start space-x-2 text-[11px]" style="background: rgba(220,38,38,0.08); border: 1px solid rgba(220,38,38,0.2); color: #dc2626;">
                    <svg class="w-4 h-4 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"/></svg>
                    <span>This action is permanent and cannot be undone. Historical transaction records will preserve sales references.</span>
                </div>
            </div>

            <form :action="'/inventory/' + deleteItem.product_id" method="POST" class="pt-2 flex items-center justify-end space-x-2" style="border-top: 1px solid var(--border);">
                @csrf
                @method('DELETE')
                <button type="button" @click="showDeleteModal = false" class="px-3.5 py-2 rounded-xl text-xs font-semibold transition cursor-pointer" style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);" onmouseover="this.style.color='var(--text-primary)';" onmouseout="this.style.color='var(--text-secondary)';">
                    Cancel
                </button>
                <button type="submit" class="px-4 py-2 rounded-xl text-white font-bold text-xs bg-red-600 hover:bg-red-700 transition cursor-pointer shadow-md">
                    Yes, Delete Product
                </button>
            </form>
        </div>
    </div>
</div>

<script>
function inventoryManager() {
    return {
        showAddModal: false,
        showEditModal: false,
        showRestockModal: false,
        showDeleteModal: false,
        editItem: {},
        restockItem: {},
        deleteItem: {},
        addImagePreview: null,
        editImagePreview: null,

        openAddModal() {
            this.addImagePreview = null;
            this.showAddModal = true;
        },

        openEditModal(p) {
            this.editItem = Object.assign({}, p);
            this.editImagePreview = p.image ? ('/' + p.image).replace(/^\/+/, '/') : null;
            this.showEditModal = true;
        },

        openRestockModal(p) {
            this.restockItem = Object.assign({}, p);
            this.showRestockModal = true;
        },

        openDeleteModal(p) {
            this.deleteItem = Object.assign({}, p);
            this.showDeleteModal = true;
        },

        previewAddImage(e) {
            const file = e.target.files[0];
            if (file) {
                this.addImagePreview = URL.createObjectURL(file);
            }
        },

        previewEditImage(e) {
            const file = e.target.files[0];
            if (file) {
                this.editImagePreview = URL.createObjectURL(file);
            }
        }
    };
}
</script>
@endsection
