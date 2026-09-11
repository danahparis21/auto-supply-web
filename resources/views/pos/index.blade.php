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
                        placeholder="Search auto parts by name, brand, location..."
                        class="w-full pl-10 pr-4 py-2 rounded-xl text-sm transition"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                        onfocus="this.style.borderColor='var(--brand)'; this.style.boxShadow='0 0 0 2px var(--brand-dim)';"
                        onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                    >
                </div>
                <button @click="searchTerm = ''; selectedType = 'All'"
                        class="px-3 py-2 text-xs font-semibold rounded-xl transition"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-muted);">
                    Clear
                </button>
            </div>

            <!-- Brand Filter Chips -->
            <div class="flex items-center space-x-1.5 overflow-x-auto pb-1 text-xs font-medium">
                <button
                    @click="selectedType = 'All'"
                    :class="selectedType === 'All' ? 'bg-red-600 text-white font-bold shadow-md shadow-red-600/25' : 'bg-gray-100 dark:bg-zinc-800 text-gray-700 dark:text-zinc-300 hover:bg-gray-200 dark:hover:bg-zinc-700'"
                    class="px-3 py-1.5 rounded-lg whitespace-nowrap transition flex-shrink-0"
                >All Parts</button>
                @foreach($categories as $cat)
                    <button
                        @click="selectedType = '{{ $cat }}'"
                        :class="selectedType === '{{ $cat }}' ? 'bg-red-600 text-white font-bold shadow-md shadow-red-600/25' : 'bg-gray-100 dark:bg-zinc-800 text-gray-700 dark:text-zinc-300 hover:bg-gray-200 dark:hover:bg-zinc-700'"
                        class="px-3 py-1.5 rounded-lg whitespace-nowrap transition flex-shrink-0"
                    >{{ $cat }}</button>
                @endforeach
            </div>
        </div>

        <!-- Product Cards Grid -->
        <div class="flex-1 overflow-y-auto p-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-3">
                <template x-for="product in filteredProducts" :key="product.product_id">
                    <div
                        class="p-3.5 rounded-xl transition-all duration-150 flex flex-col justify-between"
                        :class="product.quantity <= 0 ? 'opacity-60' : 'hover:shadow-md'"
                        style="background: var(--bg-elevated); border: 1px solid var(--border);"
                        @mouseover="if(product.quantity > 0) $event.currentTarget.style.borderColor = 'var(--brand-border)'"
                        @mouseleave="$event.currentTarget.style.borderColor = 'var(--border)'"
                    >
                        <div>
                            <div class="flex items-start justify-between gap-1">
                                <span class="text-[10px] uppercase font-bold tracking-wider px-2 py-0.5 rounded"
                                      style="background: var(--bg-base); color: var(--text-muted);"
                                      x-text="product.type"></span>
                                <span
                                    class="text-[11px] font-mono font-bold px-2 py-0.5 rounded-full"
                                    :class="product.quantity <= 0
                                        ? 'bg-red-500/15 text-red-500 dark:text-red-400'
                                        : (product.quantity <= 5
                                            ? 'bg-red-500/12 text-red-600 dark:text-red-400'
                                            : 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400')"
                                    x-text="product.quantity <= 0 ? 'Out of stock' : product.quantity + ' in stock'"
                                ></span>
                            </div>
                            <div class="flex items-center space-x-3 mt-2.5">
                                <img :src="product.image || '/images/products/default.svg'"
                                     :alt="product.product_name"
                                     class="w-11 h-11 rounded-xl object-cover flex-shrink-0 border p-1 shadow-sm"
                                     style="background: var(--bg-base); border-color: var(--border);"
                                     onerror="this.src='/images/products/default.svg'"
                                     loading="lazy">
                                <div class="min-w-0 flex-1">
                                    <h5 class="text-sm font-bold leading-snug truncate" style="color: var(--text-primary);" x-text="product.product_name"></h5>
                                    <p class="text-xs truncate" style="color: var(--text-muted);" x-text="product.additional_name || product.brand"></p>
                                    <p class="text-[10px] mt-0.5" style="color: var(--text-muted);" x-text="'Loc: ' + (product.location || 'General')"></p>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 pt-3 flex items-center justify-between" style="border-top: 1px solid var(--border);">
                            <span class="text-sm font-extrabold font-mono-nums text-brand" x-text="'₱' + parseFloat(product.price).toFixed(2)"></span>
                            <button
                                @click="addToCart(product)"
                                :disabled="product.quantity <= 0 || getCartQty(product.product_id) >= product.quantity"
                                class="px-3 py-1.5 rounded-lg text-xs font-bold transition flex items-center"
                                :class="(product.quantity <= 0 || getCartQty(product.product_id) >= product.quantity)
                                    ? 'cursor-not-allowed opacity-40 bg-gray-200 dark:bg-zinc-800 text-gray-500 dark:text-zinc-500'
                                    : 'bg-red-600 hover:bg-red-500 text-white shadow-md shadow-red-600/20'"
                            >
                                <svg class="w-3.5 h-3.5 mr-1" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                                Add
                            </button>
                        </div>
                    </div>
                </template>
            </div>

            <!-- Empty State -->
            <div x-show="filteredProducts.length === 0" class="py-12 text-center" style="color: var(--text-muted);">
                <svg class="w-12 h-12 mx-auto mb-2 opacity-30" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20 12H4M12 4v16"/></svg>
                <p class="text-sm">No products found matching your search.</p>
            </div>
        </div>
    </div>

    <!-- Right Column: Cart & Payment (5 Cols) -->
    <div class="lg:col-span-5 flex flex-col h-full rounded-2xl overflow-hidden shadow-xl"
         style="background: var(--bg-surface); border: 1px solid var(--border);">

        <!-- Order Header -->
        <div class="p-4 flex items-center justify-between flex-shrink-0"
             style="border-bottom: 1px solid var(--border); background: var(--bg-elevated);">
            <div>
                <h4 class="text-base font-bold" style="color: var(--text-primary);">Active Ticket</h4>
                <p class="text-xs font-mono-nums" style="color: var(--text-muted);" x-text="cart.length + ' item(s) selected'"></p>
            </div>
            <button @click="resetCart()" x-show="cart.length > 0"
                    class="px-2.5 py-1 text-xs font-semibold rounded-lg transition text-brand"
                    style="background: var(--brand-dim);">
                Reset Order
            </button>
        </div>

        <!-- Order Items -->
        <div class="flex-1 overflow-y-auto p-4">
            <template x-for="(item, index) in cart" :key="item.product_id">
                <div class="py-3 flex items-center justify-between" style="border-bottom: 1px solid var(--border-subtle);">
                    <div class="flex-1 pr-3">
                        <h6 class="text-xs font-bold leading-tight" style="color: var(--text-primary);" x-text="item.product_name"></h6>
                        <span class="text-[11px] font-mono-nums" style="color: var(--text-muted);" x-text="'₱' + parseFloat(item.price).toFixed(2) + ' each'"></span>
                    </div>
                    <div class="flex items-center space-x-1.5">
                        <button @click="decrementItem(item)"
                                class="w-6 h-6 rounded flex items-center justify-center text-xs font-bold transition"
                                style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary);">-</button>
                        <span class="w-8 text-center text-xs font-bold font-mono-nums" style="color: var(--text-primary);" x-text="item.quantity"></span>
                        <button @click="incrementItem(item)" :disabled="item.quantity >= item.max_stock"
                                class="w-6 h-6 rounded flex items-center justify-center text-xs font-bold transition disabled:opacity-40"
                                style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary);">+</button>
                    </div>
                    <div class="w-24 text-right flex items-center justify-end space-x-2">
                        <span class="text-xs font-extrabold font-mono-nums" style="color: var(--text-primary);" x-text="'₱' + (item.quantity * item.price).toFixed(2)"></span>
                        <button @click="removeItem(index)"
                                class="transition"
                                style="color: var(--text-muted);"
                                onmouseover="this.style.color='var(--brand)';"
                                onmouseout="this.style.color='var(--text-muted)';">
                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                        </button>
                    </div>
                </div>
            </template>

            <div x-show="cart.length === 0" class="h-full flex flex-col items-center justify-center text-center py-16" style="color: var(--text-muted);">
                <svg class="w-12 h-12 mb-3 opacity-20" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                </svg>
                <p class="text-sm font-medium">Cart is empty</p>
                <p class="text-xs mt-1">Select products from the catalog to add to order</p>
            </div>
        </div>

        <!-- Payment Section -->
        <div class="p-4 space-y-3 flex-shrink-0" style="border-top: 1px solid var(--border); background: var(--bg-elevated);">
            <!-- Totals -->
            <div class="space-y-1 text-xs">
                <div class="flex justify-between" style="color: var(--text-muted);">
                    <span>Subtotal:</span>
                    <span class="font-mono-nums" style="color: var(--text-secondary);" x-text="'₱' + totalAmount.toFixed(2)"></span>
                </div>
                <div class="flex justify-between items-baseline pt-1" style="border-top: 1px solid var(--border);">
                    <span class="text-sm font-bold" style="color: var(--text-primary);">TOTAL DUE:</span>
                    <span class="text-2xl font-black font-mono-nums text-brand" x-text="'₱' + totalAmount.toFixed(2)"></span>
                </div>
            </div>

            <!-- Payment Input -->
            <div class="space-y-2 pt-2" style="border-top: 1px solid var(--border);">
                <label class="block text-xs font-bold" style="color: var(--text-secondary);">Customer Payment (₱):</label>
                <div class="flex items-center space-x-2">
                    <input
                        type="number"
                        step="any"
                        x-model.number="paymentAmount"
                        placeholder="0.00"
                        class="flex-1 px-3 py-2 rounded-xl text-base font-bold font-mono-nums transition"
                        style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                        onfocus="this.style.borderColor='var(--brand)';"
                        onblur="this.style.borderColor='var(--border)';"
                    >
                    <button @click="paymentAmount = totalAmount"
                            class="px-3 py-2 text-xs font-semibold rounded-xl transition"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);">Exact</button>
                </div>

                <!-- Quick Cash -->
                <div class="flex items-center space-x-1.5 text-xs font-mono font-semibold">
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 100"
                            class="flex-1 py-1 rounded transition"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);">+₱100</button>
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 500"
                            class="flex-1 py-1 rounded transition"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);">+₱500</button>
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 1000"
                            class="flex-1 py-1 rounded transition"
                            style="background: var(--bg-base); border: 1px solid var(--border); color: var(--text-secondary);">+₱1000</button>
                </div>

                <!-- Change -->
                <div class="flex justify-between items-center p-2.5 rounded-xl"
                     style="background: var(--bg-base); border: 1px solid var(--border);">
                    <span class="text-xs font-bold" style="color: var(--text-secondary);">Change:</span>
                    <span class="text-lg font-black font-mono-nums"
                          :class="changeAmount >= 0 ? 'text-emerald-600 dark:text-emerald-400' : 'text-red-600 dark:text-red-400'"
                          x-text="'₱' + (changeAmount >= 0 ? changeAmount.toFixed(2) : '0.00')"></span>
                </div>
            </div>

            <!-- Submit -->
            <button
                @click="submitCheckout()"
                :disabled="cart.length === 0 || paymentAmount < totalAmount || isSubmitting"
                class="w-full py-3 rounded-xl font-extrabold text-sm uppercase tracking-wider transition-all duration-150 flex items-center justify-center"
                :class="(cart.length === 0 || paymentAmount < totalAmount || isSubmitting)
                    ? 'cursor-not-allowed bg-gray-100 dark:bg-zinc-800 text-gray-400 dark:text-zinc-500'
                    : 'bg-red-600 hover:bg-red-500 text-white shadow-brand'"
            >
                <template x-if="isSubmitting"><span>Recording Transaction...</span></template>
                <template x-if="!isSubmitting">
                    <span class="flex items-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        Record Sale &amp; Print Receipt
                    </span>
                </template>
            </button>
        </div>
    </div>

    <!-- Receipt Modal -->
    <div x-show="showReceiptModal" x-cloak
         class="fixed inset-0 z-50 flex items-center justify-center p-4 backdrop-blur-sm"
         style="background: rgba(0,0,0,0.6);">
        <div class="rounded-2xl w-full shadow-2xl flex flex-col overflow-hidden"
             style="max-width: 420px; max-height: 90vh; background: var(--bg-surface); border: 1px solid var(--border);">

            <!-- Modal Header -->
            <div class="flex items-center justify-between px-5 py-4 flex-shrink-0"
                 style="border-bottom: 1px solid var(--border); background: var(--bg-elevated);">
                <div class="flex items-center gap-2.5">
                    <div class="w-8 h-8 rounded-full flex items-center justify-center"
                         style="background: rgba(16,185,129,0.15); color: #10b981;">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
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

            <!-- Receipt Body (scrollable) -->
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
                                <span x-text="item.quantity + ' x P' + parseFloat(item.price).toFixed(2)"></span>
                                <span class="font-bold" style="color: var(--text-primary);" x-text="'P' + (item.quantity * parseFloat(item.price)).toFixed(2)"></span>
                            </div>
                        </div>
                    </template>
                </div>

                <div style="border-top: 1px dashed var(--border);"></div>

                <!-- Totals -->
                <div class="space-y-1.5">
                    <div class="flex justify-between" style="color: var(--text-secondary);">
                        <span>TOTAL AMOUNT:</span>
                        <span class="font-bold" style="color: var(--text-primary);" x-text="'P' + parseFloat(completedInvoice?.total_sales || 0).toFixed(2)"></span>
                    </div>
                    <div class="flex justify-between" style="color: var(--text-secondary);">
                        <span>CASH TENDERED:</span>
                        <span style="color: var(--text-primary);" x-text="'P' + parseFloat(completedInvoice?.customer_payment || 0).toFixed(2)"></span>
                    </div>
                    <div class="flex justify-between text-sm font-extrabold pt-1.5" style="border-top: 1px solid var(--border); color: #10b981;">
                        <span>CHANGE:</span>
                        <span x-text="'P' + parseFloat(completedInvoice?.customer_change || 0).toFixed(2)"></span>
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
                        class="flex-1 py-2.5 rounded-xl text-white font-bold text-xs uppercase tracking-wider transition flex items-center justify-center gap-1.5 glowingbutton btn-brand">
                    <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a1 1 0 00-1-1H8a1 1 0 00-1 1v4a2 2 0 002 2zm1-4h.01"/></svg>
                    Print Receipt
                </button>
                <button @click="showReceiptModal = false"
                        class="flex-1 py-2.5 rounded-xl font-semibold text-xs uppercase tracking-wider transition"
                        style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);"
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

        get filteredProducts() {
            return this.products.filter(item => {
                const matchesPart = this.selectedType === 'All' || item.product_name.startsWith(this.selectedType);
                const search = this.searchTerm.toLowerCase().trim();
                const matchesSearch = !search ||
                    item.product_name.toLowerCase().includes(search) ||
                    (item.brand && item.brand.toLowerCase().includes(search)) ||
                    (item.additional_name && item.additional_name.toLowerCase().includes(search)) ||
                    (item.location && item.location.toLowerCase().includes(search));
                return matchesPart && matchesSearch;
            });
        },
        get totalAmount() { return this.cart.reduce((sum, item) => sum + (item.quantity * parseFloat(item.price)), 0); },
        get changeAmount() { return this.paymentAmount - this.totalAmount; },
        getCartQty(productId) { const item = this.cart.find(c => c.product_id === productId); return item ? item.quantity : 0; },
        addToCart(product) {
            const existing = this.cart.find(c => c.product_id === product.product_id);
            if (existing) { if (existing.quantity < product.quantity) existing.quantity++; }
            else this.cart.push({ product_id: product.product_id, product_name: product.product_name, price: parseFloat(product.price), quantity: 1, max_stock: product.quantity });
        },
        incrementItem(item) { if (item.quantity < item.max_stock) item.quantity++; },
        decrementItem(item) { if (item.quantity > 1) item.quantity--; else this.cart = this.cart.filter(c => c.product_id !== item.product_id); },
        removeItem(index) { this.cart.splice(index, 1); },
        resetCart() { this.cart = []; this.paymentAmount = 0; },

        async submitCheckout() {
            if (this.cart.length === 0 || this.paymentAmount < this.totalAmount) return;
            this.isSubmitting = true;
            // Snapshot cart before reset so modal can display line items
            const cartSnapshot = this.cart.map(i => ({ product_id: i.product_id, product_name: i.product_name, price: i.price, quantity: i.quantity }));
            const payload = { items: cartSnapshot.map(i => ({ product_id: i.product_id, quantity: i.quantity })), customer_payment: this.paymentAmount };
            try {
                const response = await fetch('{{ route('pos.checkout') }}', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json', 'Accept': 'application/json', 'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content') },
                    body: JSON.stringify(payload)
                });
                const data = await response.json();
                if (response.ok && data.success) {
                    cartSnapshot.forEach(cartItem => { const prod = this.products.find(p => p.product_id === cartItem.product_id); if (prod) prod.quantity -= cartItem.quantity; });
                    this.completedInvoice = { ...data.invoice, items: cartSnapshot };
                    this.showReceiptModal = true;
                    this.resetCart();
                } else { alert(data.message || 'Error processing transaction.'); }
            } catch (err) { console.error(err); alert('Network error while processing transaction.'); }
            finally { this.isSubmitting = false; }
        },
        printLastReceipt() { if (this.completedInvoice) window.open('/transactions/invoice/' + this.completedInvoice.invoice_id, '_blank'); }
    };
}
</script>
@endsection

