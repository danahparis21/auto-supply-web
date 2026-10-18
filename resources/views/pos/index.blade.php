@extends('layouts.app')

@section('page_title', 'Point of Sale (POS) Terminal')

@section('content')
<div x-data="posSystem()" class="grid grid-cols-1 lg:grid-cols-12 gap-6 h-[calc(100vh-7.5rem)]">

    <!-- Left Column: Product Catalog & Search (7 Cols) -->
    <div class="lg:col-span-7 flex flex-col h-full rounded-2xl overflow-hidden shadow-xl"
         style="background: var(--bg-surface); border: 1px solid var(--border);">

        <!-- Search & Category Header -->
        <div class="p-4 space-y-3 flex-shrink-0" style="border-bottom: 1px solid var(--border); background: var(--bg-elevated);">
            <div class="flex items-center space-x-3">
                <div class="relative flex-1">
                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </div>
                    <input
                        type="text"
                        x-model="searchTerm"
                        placeholder="Search auto parts by name, model, brand, location..."
                        class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition font-medium"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                        onfocus="this.style.borderColor='var(--brand)'; this.style.boxShadow='0 0 0 2px var(--brand-dim)';"
                        onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                    >
                </div>
                <button @click="searchTerm = ''; selectedType = 'All'"
                        class="px-3.5 py-2.5 text-xs font-bold rounded-xl transition cursor-pointer"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-muted);"
                        onmouseover="this.style.color='var(--text-primary)'"
                        onmouseout="this.style.color='var(--text-muted)'">
                    Clear
                </button>
            </div>

            <!-- Category / Type Filter Chips -->
            <div class="flex items-center space-x-2 overflow-x-auto pb-1 text-xs font-semibold scrollbar-thin">
                <button
                    @click="selectedType = 'All'"
                    :class="selectedType === 'All' ? 'bg-red-600 text-white font-bold shadow-md shadow-red-600/30' : 'bg-gray-100 dark:bg-zinc-800 text-gray-700 dark:text-zinc-300 hover:bg-gray-200 dark:hover:bg-zinc-700'"
                    class="px-3.5 py-2 rounded-xl whitespace-nowrap transition-all flex-shrink-0 cursor-pointer"
                >All Parts</button>
                @foreach($categories as $cat)
                    <button
                        @click="selectedType = '{{ $cat }}'"
                        :class="selectedType === '{{ $cat }}' ? 'bg-red-600 text-white font-bold shadow-md shadow-red-600/30' : 'bg-gray-100 dark:bg-zinc-800 text-gray-700 dark:text-zinc-300 hover:bg-gray-200 dark:hover:bg-zinc-700'"
                        class="px-3.5 py-2 rounded-xl whitespace-nowrap transition-all flex-shrink-0 cursor-pointer"
                    >{{ $cat }}</button>
                @endforeach
            </div>
        </div>

        <!-- Product Cards Grid (Prominent Tablet-Friendly POS Design) -->
        <div class="flex-1 overflow-y-auto p-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-4">
                <template x-for="product in filteredProducts" :key="product.product_id">
                    <div
                        @click="if(product.quantity > 0 && getCartQty(product.product_id) < product.quantity) addToCart(product)"
                        class="group p-3.5 rounded-2xl transition-all duration-200 flex flex-col justify-between cursor-pointer relative"
                        :class="product.quantity <= 0 ? 'opacity-50 cursor-not-allowed' : 'hover:-translate-y-0.5 hover:shadow-lg'"
                        style="background: var(--bg-elevated); border: 1px solid var(--border);"
                        @mouseover="if(product.quantity > 0) $event.currentTarget.style.borderColor = 'var(--brand)'"
                        @mouseleave="$event.currentTarget.style.borderColor = 'var(--border)'"
                    >
                        <!-- Top Badges Row -->
                        <div class="flex items-center justify-between gap-1.5 mb-2.5">
                            <!-- Prominent Category / Model / Type Pill -->
                            <span class="inline-flex items-center px-2.5 py-1 rounded-lg text-xs font-extrabold uppercase tracking-wide border shadow-sm"
                                  style="background: rgba(159, 18, 18, 0.12); color: #dc2626; border-color: rgba(159, 18, 18, 0.25);"
                                  x-text="product.type || 'Standard'"></span>

                            <!-- Stock Status Badge -->
                            <span
                                class="text-[11px] font-mono font-bold px-2 py-0.5 rounded-full"
                                :class="product.quantity <= 0
                                    ? 'bg-red-500/15 text-red-500 dark:text-red-400'
                                    : (product.quantity <= 5
                                        ? 'bg-amber-500/15 text-amber-600 dark:text-amber-400'
                                        : 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400')"
                                x-text="product.quantity <= 0 ? 'Out of stock' : product.quantity + ' in stock'"
                            ></span>
                        </div>

                        <!-- Big Center Product Image -->
                        <div class="w-full h-32 rounded-xl overflow-hidden flex items-center justify-center p-2 mb-3 border transition-colors group-hover:border-red-500/30"
                             style="background: var(--bg-base); border-color: var(--border);">
                            <img :src="getProductImage(product)"
                                 :alt="product.product_name"
                                 class="w-full h-full object-contain filter group-hover:scale-105 transition-transform duration-200"
                                 onerror="this.src='/images/products/default.svg'"
                                 loading="lazy">
                        </div>

                        <!-- Product Title & Details -->
                        <div class="flex-1">
                            <h5 class="text-sm font-extrabold leading-snug line-clamp-2" style="color: var(--text-primary);" x-text="product.product_name"></h5>

                            <!-- Clean sub-specification / brand (only show if not repeating name) -->
                            <div class="mt-1 flex items-center justify-between text-xs" style="color: var(--text-muted);">
                                <span class="font-medium truncate" x-text="getSecondarySpec(product)"></span>
                                <span class="text-[11px] font-mono flex items-center flex-shrink-0" x-text="'Loc: ' + (product.location || 'Shelf')"></span>
                            </div>
                        </div>

                        <!-- Bottom Price & Action -->
                        <div class="mt-3 pt-2.5 flex items-center justify-between" style="border-top: 1px solid var(--border);">
                            <div>
                                <span class="text-[10px] uppercase font-bold block" style="color: var(--text-muted);">Price</span>
                                <span class="text-base font-extrabold font-mono-nums text-brand" x-text="'₱' + parseFloat(product.price).toFixed(2)"></span>
                            </div>

                            <button
                                @click.stop="addToCart(product)"
                                :disabled="product.quantity <= 0 || getCartQty(product.product_id) >= product.quantity"
                                class="px-3.5 py-2 rounded-xl text-xs font-extrabold transition flex items-center gap-1.5 shadow-sm cursor-pointer"
                                :class="(product.quantity <= 0 || getCartQty(product.product_id) >= product.quantity)
                                    ? 'cursor-not-allowed opacity-40 bg-gray-200 dark:bg-zinc-800 text-gray-500 dark:text-zinc-500'
                                    : 'bg-red-600 hover:bg-red-500 text-white shadow-md shadow-red-600/25'"
                            >
                                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                                <span>Add</span>
                            </button>
                        </div>
                    </div>
                </template>
            </div>

            <!-- Empty State -->
            <div x-show="filteredProducts.length === 0" class="py-16 text-center" style="color: var(--text-muted);">
                <svg class="w-12 h-12 mx-auto mb-2 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20 12H4M12 4v16"/></svg>
                <p class="text-sm font-semibold">No products found matching your search.</p>
                <p class="text-xs mt-1">Try clearing your filters or typing another keyword.</p>
            </div>
        </div>
    </div>

    <!-- Right Column: Order Details & Payment (Active Ticket) (5 Cols) -->
    <div class="lg:col-span-5 flex flex-col h-full rounded-2xl overflow-hidden shadow-xl"
         style="background: var(--bg-surface); border: 1px solid var(--border);">

        <!-- Order Header -->
        <div class="p-4 flex items-center justify-between flex-shrink-0"
             style="border-bottom: 1px solid var(--border); background: var(--bg-elevated);">
            <div class="flex items-center gap-2.5">
                <div class="w-9 h-9 rounded-xl flex items-center justify-center font-bold text-white shadow-sm"
                     style="background: linear-gradient(135deg, #9f1212 0%, #7f0c0c 100%);">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/></svg>
                </div>
                <div>
                    <h4 class="text-base font-extrabold" style="color: var(--text-primary);">Active Ticket</h4>
                    <p class="text-xs font-mono-nums font-semibold" style="color: var(--text-muted);" x-text="cart.length + ' item(s) selected'"></p>
                </div>
            </div>

            <button @click="resetCart()" x-show="cart.length > 0"
                    class="px-3 py-1.5 text-xs font-bold rounded-xl transition flex items-center gap-1 cursor-pointer"
                    style="background: rgba(159,18,18,0.1); color: #dc2626; border: 1px solid rgba(159,18,18,0.2);">
                <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                Reset Order
            </button>
        </div>

        <!-- Order Items with Product Thumbnails -->
        <div class="flex-1 overflow-y-auto p-4 space-y-3">
            <template x-for="(item, index) in cart" :key="item.product_id">
                <div class="p-3 rounded-xl flex items-center justify-between gap-3 transition"
                     style="background: var(--bg-elevated); border: 1px solid var(--border);">

                    <!-- Item Thumbnail Image -->
                    <div class="w-12 h-12 rounded-xl overflow-hidden flex-shrink-0 border p-1 flex items-center justify-center shadow-sm"
                         style="background: var(--bg-base); border-color: var(--border);">
                        <img :src="item.image"
                             :alt="item.product_name"
                             class="w-full h-full object-contain"
                             onerror="this.src='/images/products/default.svg'">
                    </div>

                    <!-- Item Details -->
                    <div class="flex-1 min-w-0 pr-1">
                        <h6 class="text-xs font-extrabold leading-snug truncate" style="color: var(--text-primary);" x-text="item.product_name"></h6>
                        <div class="flex items-center gap-1.5 mt-0.5">
                            <span class="text-[10px] font-bold px-1.5 py-0.2 rounded" style="background: rgba(159,18,18,0.12); color: #dc2626;" x-text="item.type || 'Part'"></span>
                            <span class="text-[11px] font-mono font-semibold" style="color: var(--text-muted);" x-text="'₱' + parseFloat(item.price).toFixed(2) + ' each'"></span>
                        </div>
                    </div>

                    <!-- Stepper Quantity Controls -->
                    <div class="flex items-center space-x-1 flex-shrink-0">
                        <button @click="decrementItem(item)"
                                class="w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold transition cursor-pointer"
                                style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-primary);"
                                onmouseover="this.style.borderColor='var(--brand)'"
                                onmouseout="this.style.borderColor='var(--border)'">-</button>
                        <span class="w-8 text-center text-xs font-black font-mono-nums" style="color: var(--text-primary);" x-text="item.quantity"></span>
                        <button @click="incrementItem(item)" :disabled="item.quantity >= item.max_stock"
                                class="w-7 h-7 rounded-lg flex items-center justify-center text-xs font-bold transition disabled:opacity-40 cursor-pointer"
                                style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-primary);"
                                onmouseover="this.style.borderColor='var(--brand)'"
                                onmouseout="this.style.borderColor='var(--border)'">+</button>
                    </div>

                    <!-- Line Total & Red Trash Button -->
                    <div class="text-right flex items-center justify-end space-x-2 flex-shrink-0">
                        <span class="text-xs font-extrabold font-mono-nums min-w-[55px] text-right" style="color: var(--text-primary);" x-text="'₱' + (item.quantity * item.price).toFixed(2)"></span>
                        <button @click="removeItem(index)"
                                class="w-7 h-7 rounded-lg flex items-center justify-center transition cursor-pointer"
                                style="background: rgba(239,68,68,0.1); color: #ef4444; border: 1px solid rgba(239,68,68,0.2);"
                                onmouseover="this.style.background='rgba(239,68,68,0.2)'"
                                onmouseout="this.style.background='rgba(239,68,68,0.1)'"
                                title="Remove item">
                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                        </button>
                    </div>
                </div>
            </template>

            <!-- Empty Cart Notice -->
            <div x-show="cart.length === 0" class="h-full flex flex-col items-center justify-center text-center py-16" style="color: var(--text-muted);">
                <div class="w-16 h-16 rounded-2xl flex items-center justify-center mb-3" style="background: var(--bg-elevated); border: 1px dashed var(--border);">
                    <svg class="w-8 h-8 opacity-40" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                    </svg>
                </div>
                <p class="text-sm font-bold" style="color: var(--text-secondary);">Ticket is currently empty</p>
                <p class="text-xs mt-1 max-w-[220px]">Click any auto part card on the catalog to add it to this transaction.</p>
            </div>
        </div>

        <!-- Payment & Checkout Section -->
        <div class="p-4 space-y-3 flex-shrink-0" style="border-top: 1px solid var(--border); background: var(--bg-elevated);">
            <!-- Totals Overview -->
            <div class="space-y-1 text-xs">
                <div class="flex justify-between" style="color: var(--text-muted);">
                    <span class="font-medium">Subtotal Amount:</span>
                    <span class="font-mono-nums font-bold" style="color: var(--text-secondary);" x-text="'₱' + totalAmount.toFixed(2)"></span>
                </div>
                <div class="flex justify-between items-baseline pt-1.5" style="border-top: 1px solid var(--border);">
                    <span class="text-sm font-black tracking-wide" style="color: var(--text-primary);">TOTAL PAYMENT DUE:</span>
                    <span class="text-2xl font-black font-mono-nums text-brand" x-text="'₱' + totalAmount.toFixed(2)"></span>
                </div>
            </div>

            <!-- Customer Payment Input -->
            <div class="space-y-2 pt-2" style="border-top: 1px solid var(--border);">
                <label class="block text-xs font-extrabold uppercase tracking-wider" style="color: var(--text-secondary);">Customer Payment Tendered (₱):</label>
                <div class="flex items-center space-x-2">
                    <input
                        type="number"
                        step="any"
                        x-model.number="paymentAmount"
                        placeholder="0.00"
                        class="flex-1 px-3.5 py-2.5 rounded-xl text-lg font-black font-mono-nums transition"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                        onfocus="this.style.borderColor='var(--brand)';"
                        onblur="this.style.borderColor='var(--border)';"
                    >
                    <button @click="paymentAmount = totalAmount"
                            class="px-4 py-2.5 text-xs font-bold rounded-xl transition cursor-pointer"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);"
                            onmouseover="this.style.color='var(--text-primary)'"
                            onmouseout="this.style.color='var(--text-secondary)'">Exact</button>
                </div>

                <!-- Quick Cash Quick-Buttons -->
                <div class="flex items-center space-x-1.5 text-xs font-mono font-bold">
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 100"
                            class="flex-1 py-1.5 rounded-lg transition cursor-pointer"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);"
                            onmouseover="this.style.borderColor='var(--brand)'"
                            onmouseout="this.style.borderColor='var(--border)'">+₱100</button>
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 500"
                            class="flex-1 py-1.5 rounded-lg transition cursor-pointer"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);"
                            onmouseover="this.style.borderColor='var(--brand)'"
                            onmouseout="this.style.borderColor='var(--border)'">+₱500</button>
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 1000"
                            class="flex-1 py-1.5 rounded-lg transition cursor-pointer"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);"
                            onmouseover="this.style.borderColor='var(--brand)'"
                            onmouseout="this.style.borderColor='var(--border)'">+₱1000</button>
                </div>

                <!-- Change Calculation -->
                <div class="flex justify-between items-center p-3 rounded-xl shadow-inner"
                     style="background: var(--bg-base); border: 1px solid var(--border);">
                    <span class="text-xs font-extrabold uppercase tracking-wide" style="color: var(--text-secondary);">Change Due:</span>
                    <span class="text-xl font-black font-mono-nums"
                          :class="changeAmount >= 0 ? 'text-emerald-600 dark:text-emerald-400' : 'text-red-600 dark:text-red-400'"
                          x-text="'₱' + (changeAmount >= 0 ? changeAmount.toFixed(2) : '0.00')"></span>
                </div>
            </div>

            <!-- Complete Sale Button -->
            <button
                @click="submitCheckout()"
                :disabled="cart.length === 0 || paymentAmount < totalAmount || isSubmitting"
                class="w-full py-3.5 rounded-xl font-extrabold text-sm uppercase tracking-wider transition-all duration-150 flex items-center justify-center cursor-pointer"
                :class="(cart.length === 0 || paymentAmount < totalAmount || isSubmitting)
                    ? 'cursor-not-allowed bg-gray-100 dark:bg-zinc-800 text-gray-400 dark:text-zinc-500'
                    : 'bg-red-600 hover:bg-red-500 text-white shadow-lg shadow-red-600/30'"
            >
                <template x-if="isSubmitting"><span>Recording Transaction...</span></template>
                <template x-if="!isSubmitting">
                    <span class="flex items-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        Complete Sale &amp; Print Receipt
                    </span>
                </template>
            </button>
        </div>
    </div>

    <!-- Receipt Modal -->
    <div x-show="showReceiptModal" x-cloak
         class="fixed inset-0 z-50 flex items-center justify-center p-4 backdrop-blur-sm"
         style="background: rgba(0,0,0,0.65);">
        <div class="rounded-2xl w-full shadow-2xl flex flex-col overflow-hidden"
             style="max-width: 440px; max-height: 90vh; background: var(--bg-surface); border: 1px solid var(--border);">

            <!-- Modal Header -->
            <div class="flex items-center justify-between px-5 py-4 flex-shrink-0"
                 style="border-bottom: 1px solid var(--border); background: var(--bg-elevated);">
                <div class="flex items-center gap-2.5">
                    <div class="w-9 h-9 rounded-full flex items-center justify-center"
                         style="background: rgba(16,185,129,0.15); color: #10b981;">
                        <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                    </div>
                    <div>
                        <h3 class="text-sm font-bold" style="color: var(--text-primary);">Sale Complete!</h3>
                        <p class="text-[11px] font-mono" style="color: var(--text-muted);" x-text="'Invoice #' + (completedInvoice?.invoice_number || '')"></p>
                    </div>
                </div>
                <button @click="showReceiptModal = false" style="color: var(--text-muted);"
                        onmouseover="this.style.color='var(--text-primary)'"
                        onmouseout="this.style.color='var(--text-muted)'">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>

            <!-- Receipt Body Preview -->
            <div class="overflow-y-auto flex-1 px-5 py-4 space-y-4 font-mono text-xs" style="color: var(--text-primary);">
                <!-- Shop Header -->
                <div class="text-center space-y-0.5">
                    <p class="font-extrabold text-sm tracking-wide">JOY JEFFREY AUTO SUPPLY</p>
                    <p style="color: var(--text-muted);">High Performance Auto Parts &amp; Lubricants</p>
                    <p style="color: var(--text-muted);">Nasugbu, Batangas, Philippines</p>
                </div>

                <div style="border-top: 1px dashed var(--border);"></div>

                <!-- Invoice Info -->
                <div class="space-y-1" style="color: var(--text-secondary);">
                    <div class="flex justify-between">
                        <span>INVOICE:</span>
                        <span class="font-bold" style="color: var(--text-primary);" x-text="completedInvoice?.invoice_number || ''"></span>
                    </div>
                    <div class="flex justify-between">
                        <span>DATE:</span>
                        <span style="color: var(--text-primary);" x-text="(completedInvoice?.date || '') + ' ' + (completedInvoice?.time || '')"></span>
                    </div>
                </div>

                <div style="border-top: 1px dashed var(--border);"></div>

                <!-- Line Items -->
                <div class="space-y-2">
                    <template x-for="item in (completedInvoice?.items || [])" :key="item.product_id">
                        <div>
                            <div class="font-bold truncate" style="color: var(--text-primary);" x-text="item.product_name"></div>
                            <div class="flex justify-between mt-0.5" style="color: var(--text-secondary);">
                                <span x-text="item.quantity + ' x ₱' + parseFloat(item.price).toFixed(2)"></span>
                                <span class="font-bold" style="color: var(--text-primary);" x-text="'₱' + (item.quantity * parseFloat(item.price)).toFixed(2)"></span>
                            </div>
                        </div>
                    </template>
                </div>

                <div style="border-top: 1px dashed var(--border);"></div>

                <!-- Totals -->
                <div class="space-y-1.5">
                    <div class="flex justify-between" style="color: var(--text-secondary);">
                        <span>TOTAL AMOUNT:</span>
                        <span class="font-bold" style="color: var(--text-primary);" x-text="'₱' + parseFloat(completedInvoice?.total_sales || 0).toFixed(2)"></span>
                    </div>
                    <div class="flex justify-between" style="color: var(--text-secondary);">
                        <span>CASH TENDERED:</span>
                        <span style="color: var(--text-primary);" x-text="'₱' + parseFloat(completedInvoice?.customer_payment || 0).toFixed(2)"></span>
                    </div>
                    <div class="flex justify-between text-sm font-extrabold pt-1.5" style="border-top: 1px solid var(--border); color: #10b981;">
                        <span>CHANGE:</span>
                        <span x-text="'₱' + parseFloat(completedInvoice?.customer_change || 0).toFixed(2)"></span>
                    </div>
                </div>

                <div class="text-center text-[10px] pt-1" style="color: var(--text-muted);">
                    Thank you for choosing Joy Jeffrey Auto Supply!
                </div>
            </div>

            <!-- Footer Actions -->
            <div class="flex items-center gap-3 px-5 py-4 flex-shrink-0"
                 style="border-top: 1px solid var(--border); background: var(--bg-elevated);">
                <button @click="printLastReceipt()"
                        class="flex-1 py-3 rounded-xl text-white font-extrabold text-xs uppercase tracking-wider transition flex items-center justify-center gap-1.5 shadow-md bg-red-600 hover:bg-red-500 cursor-pointer">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a1 1 0 00-1-1H8a1 1 0 00-1 1v4a2 2 0 002 2zm1-4h.01"/></svg>
                    Print Thermal Receipt
                </button>
                <button @click="showReceiptModal = false"
                        class="py-3 px-4 rounded-xl font-bold text-xs uppercase tracking-wider transition cursor-pointer"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);"
                        onmouseover="this.style.borderColor='var(--brand)'; this.style.color='var(--text-primary)'"
                        onmouseout="this.style.borderColor='var(--border)'; this.style.color='var(--text-secondary)'">
                    New Sale
                </button>
            </div>
        </div>
    </div>
</div>

<script>
function posSystem() {
    return {
        products: {!! json_encode($products) !!},
        searchTerm: '{{ $search }}',
        selectedType: '{{ $selectedCategory }}',
        cart: [],
        paymentAmount: 0,
        isSubmitting: false,
        showReceiptModal: false,
        completedInvoice: null,

        getProductImage(product) {
            if (product.image) {
                return ('/' + product.image).replace(/^\/+/, '/');
            }
            return '/images/products/default.svg';
        },

        getSecondarySpec(product) {
            if (product.additional_name && product.additional_name.trim().toLowerCase() !== product.product_name.trim().toLowerCase()) {
                return product.additional_name;
            }
            return product.brand || 'Auto Part';
        },

        get filteredProducts() {
            return this.products.filter(item => {
                const matchesPart = this.selectedType === 'All' || item.product_name.startsWith(this.selectedType);
                const search = this.searchTerm.toLowerCase().trim();
                const matchesSearch = !search ||
                    item.product_name.toLowerCase().includes(search) ||
                    (item.brand && item.brand.toLowerCase().includes(search)) ||
                    (item.additional_name && item.additional_name.toLowerCase().includes(search)) ||
                    (item.type && item.type.toLowerCase().includes(search)) ||
                    (item.location && item.location.toLowerCase().includes(search));
                return matchesPart && matchesSearch;
            });
        },

        get totalAmount() {
            return this.cart.reduce((sum, item) => sum + (item.quantity * parseFloat(item.price)), 0);
        },

        get changeAmount() {
            return this.paymentAmount - this.totalAmount;
        },

        getCartQty(productId) {
            const item = this.cart.find(c => c.product_id === productId);
            return item ? item.quantity : 0;
        },

        addToCart(product) {
            const existing = this.cart.find(c => c.product_id === product.product_id);
            if (existing) {
                if (existing.quantity < product.quantity) existing.quantity++;
            } else {
                this.cart.push({
                    product_id: product.product_id,
                    product_name: product.product_name,
                    additional_name: product.additional_name,
                    type: product.type,
                    brand: product.brand,
                    image: this.getProductImage(product),
                    price: parseFloat(product.price),
                    quantity: 1,
                    max_stock: product.quantity
                });
            }
        },

        incrementItem(item) {
            if (item.quantity < item.max_stock) item.quantity++;
        },

        decrementItem(item) {
            if (item.quantity > 1) {
                item.quantity--;
            } else {
                this.cart = this.cart.filter(c => c.product_id !== item.product_id);
            }
        },

        removeItem(index) {
            this.cart.splice(index, 1);
        },

        resetCart() {
            this.cart = [];
            this.paymentAmount = 0;
        },

        async submitCheckout() {
            if (this.cart.length === 0 || this.paymentAmount < this.totalAmount) return;
            this.isSubmitting = true;

            const cartSnapshot = this.cart.map(i => ({
                product_id: i.product_id,
                product_name: i.product_name,
                price: i.price,
                quantity: i.quantity,
                image: i.image,
                type: i.type
            }));

            const payload = {
                items: cartSnapshot.map(i => ({ product_id: i.product_id, quantity: i.quantity })),
                customer_payment: this.paymentAmount
            };

            try {
                const response = await fetch('{{ route('pos.checkout') }}', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json',
                        'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
                    },
                    body: JSON.stringify(payload)
                });

                const data = await response.json();
                if (response.ok && data.success) {
                    cartSnapshot.forEach(cartItem => {
                        const prod = this.products.find(p => p.product_id === cartItem.product_id);
                        if (prod) prod.quantity -= cartItem.quantity;
                    });
                    this.completedInvoice = { ...data.invoice, items: cartSnapshot };
                    this.showReceiptModal = true;
                    this.resetCart();
                } else {
                    alert(data.message || 'Error processing transaction.');
                }
            } catch (err) {
                console.error(err);
                alert('Network error while processing transaction.');
            } finally {
                this.isSubmitting = false;
            }
        },

        printLastReceipt() {
            if (this.completedInvoice) {
                // Open standard 80mm thermal receipt window with auto-print
                window.open('/transactions/invoice/' + this.completedInvoice.invoice_id, '_blank', 'width=420,height=680');
            }
        }
    };
}
</script>
@endsection
