@extends('layouts.app')

@section('page_title', 'Point of Sale (POS) Terminal')

@section('content')
<div x-data="posSystem()" class="grid grid-cols-1 lg:grid-cols-12 gap-6 h-[calc(100vh-7.5rem)]">

    <!-- Left Column: Product Catalog & Search (7 Cols) -->
    <div class="lg:col-span-7 flex flex-col h-full bg-slate-900 border border-slate-800 rounded-2xl overflow-hidden shadow-xl">
        
        <!-- Search & Category Header -->
        <div class="p-4 border-b border-slate-800/80 space-y-3 bg-slate-900/60">
            <div class="flex items-center space-x-3">
                <div class="relative flex-1">
                    <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-500">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                        </svg>
                    </div>
                    <input 
                        type="text" 
                        x-model="searchTerm" 
                        placeholder="Search auto parts by name, brand, location..." 
                        class="w-full pl-10 pr-4 py-2 bg-slate-950 border border-slate-800 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 focus:ring-1 focus:ring-amber-500 transition"
                    >
                </div>

                <button @click="searchTerm = ''; selectedType = 'All'" class="px-3 py-2 text-xs font-semibold text-slate-400 hover:text-white bg-slate-800 rounded-xl transition">
                    Clear
                </button>
            </div>

            <!-- Categories Chips -->
            <div class="flex items-center space-x-1.5 overflow-x-auto pb-1 text-xs font-medium">
                <button 
                    @click="selectedType = 'All'" 
                    :class="selectedType === 'All' ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' : 'bg-slate-800 text-slate-300 hover:bg-slate-700'"
                    class="px-3 py-1.5 rounded-lg whitespace-nowrap transition"
                >
                    All Parts
                </button>
                @foreach($categories as $cat)
                    <button 
                        @click="selectedType = '{{ $cat }}'" 
                        :class="selectedType === '{{ $cat }}' ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' : 'bg-slate-800 text-slate-300 hover:bg-slate-700'"
                        class="px-3 py-1.5 rounded-lg whitespace-nowrap transition"
                    >
                        {{ $cat }}
                    </button>
                @endforeach
            </div>
        </div>

        <!-- Product Cards Grid -->
        <div class="flex-1 overflow-y-auto p-4">
            <div class="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 gap-3">
                <template x-for="product in filteredProducts" :key="product.product_id">
                    <div 
                        class="p-3.5 rounded-xl border transition-all duration-150 flex flex-col justify-between"
                        :class="product.quantity <= 0 ? 'bg-slate-950/50 border-slate-800 opacity-60' : 'bg-slate-950 border-slate-800/80 hover:border-amber-500/40 hover:shadow-lg'"
                    >
                        <div>
                            <div class="flex items-start justify-between gap-1">
                                <span class="text-[10px] uppercase font-bold tracking-wider px-2 py-0.5 rounded bg-slate-800 text-slate-400" x-text="product.type"></span>
                                <span 
                                    class="text-[11px] font-mono font-bold px-2 py-0.5 rounded-full"
                                    :class="product.quantity <= 0 ? 'bg-red-500/20 text-red-400' : (product.quantity <= 5 ? 'bg-amber-500/20 text-amber-400' : 'bg-emerald-500/20 text-emerald-400')"
                                    x-text="product.quantity <= 0 ? 'Out of stock' : product.quantity + ' in stock'"
                                ></span>
                            </div>

                            <h5 class="text-sm font-bold text-white mt-2 leading-snug" x-text="product.product_name"></h5>
                            <p class="text-xs text-slate-400 truncate" x-text="product.additional_name || product.brand"></p>
                            <p class="text-[10px] text-slate-500 mt-1" x-text="'Loc: ' + (product.location || 'General')"></p>
                        </div>

                        <div class="mt-4 pt-3 border-t border-slate-800 flex items-center justify-between">
                            <span class="text-sm font-extrabold text-amber-400 font-mono-nums" x-text="'₱' + parseFloat(product.price).toFixed(2)"></span>
                            <button 
                                @click="addToCart(product)"
                                :disabled="product.quantity <= 0 || getCartQty(product.product_id) >= product.quantity"
                                class="px-3 py-1.5 rounded-lg text-xs font-bold transition flex items-center"
                                :class="(product.quantity <= 0 || getCartQty(product.product_id) >= product.quantity) ? 'bg-slate-800 text-slate-500 cursor-not-allowed' : 'bg-amber-500 hover:bg-amber-400 text-slate-950 shadow-md shadow-amber-500/20'"
                            >
                                <svg class="w-3.5 h-3.5 mr-1" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
                                Add
                            </button>
                        </div>
                    </div>
                </template>
            </div>

            <!-- Empty State -->
            <div x-show="filteredProducts.length === 0" class="py-12 text-center text-slate-500">
                <svg class="w-12 h-12 mx-auto mb-2 opacity-50" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M20 12H4M12 4v16"/></svg>
                <p class="text-sm">No products found matching your search.</p>
            </div>
        </div>
    </div>

    <!-- Right Column: Current Order & Payment Terminal (5 Cols) -->
    <div class="lg:col-span-5 flex flex-col h-full bg-slate-900 border border-slate-800 rounded-2xl overflow-hidden shadow-xl">
        
        <!-- Order Header -->
        <div class="p-4 border-b border-slate-800/80 flex items-center justify-between bg-slate-900/60">
            <div>
                <h4 class="text-base font-bold text-white">Active Ticket</h4>
                <p class="text-xs text-slate-400 font-mono-nums" x-text="cart.length + ' item(s) selected'"></p>
            </div>
            <button 
                @click="resetCart()" 
                x-show="cart.length > 0"
                class="px-2.5 py-1 text-xs font-semibold text-red-400 hover:text-red-300 hover:bg-red-500/10 rounded-lg transition"
            >
                Reset Order
            </button>
        </div>

        <!-- Order Items List -->
        <div class="flex-1 overflow-y-auto p-4 divide-y divide-slate-800/60">
            <template x-for="(item, index) in cart" :key="item.product_id">
                <div class="py-3 flex items-center justify-between group">
                    <div class="flex-1 pr-3">
                        <h6 class="text-xs font-bold text-white leading-tight" x-text="item.product_name"></h6>
                        <span class="text-[11px] text-slate-400 font-mono-nums" x-text="'₱' + parseFloat(item.price).toFixed(2) + ' each'"></span>
                    </div>

                    <!-- Quantity Stepper -->
                    <div class="flex items-center space-x-1.5">
                        <button 
                            @click="decrementItem(item)" 
                            class="w-6 h-6 rounded bg-slate-800 hover:bg-slate-700 text-white flex items-center justify-center text-xs font-bold transition"
                        >
                            -
                        </button>
                        <span class="w-8 text-center text-xs font-bold text-white font-mono-nums" x-text="item.quantity"></span>
                        <button 
                            @click="incrementItem(item)" 
                            :disabled="item.quantity >= item.max_stock"
                            class="w-6 h-6 rounded bg-slate-800 hover:bg-slate-700 text-white flex items-center justify-center text-xs font-bold transition disabled:opacity-40 disabled:cursor-not-allowed"
                        >
                            +
                        </button>
                    </div>

                    <!-- Subtotal & Remove -->
                    <div class="w-24 text-right flex items-center justify-end space-x-2">
                        <span class="text-xs font-extrabold text-white font-mono-nums" x-text="'₱' + (item.quantity * item.price).toFixed(2)"></span>
                        <button @click="removeItem(index)" class="text-slate-500 hover:text-red-400 transition">
                            <svg class="w-3.5 h-3.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                        </button>
                    </div>
                </div>
            </template>

            <div x-show="cart.length === 0" class="h-full flex flex-col items-center justify-center text-slate-500 text-center py-16">
                <svg class="w-12 h-12 text-slate-700 mb-3" fill="none" stroke="currentColor" stroke-width="1.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z" />
                </svg>
                <p class="text-sm font-medium">Cart is empty</p>
                <p class="text-xs text-slate-500 mt-1">Select products from the catalog to add to order</p>
            </div>
        </div>

        <!-- Payment & Checkout Summary Section -->
        <div class="p-4 bg-slate-950 border-t border-slate-800/80 space-y-3">
            <!-- Totals -->
            <div class="space-y-1 text-xs">
                <div class="flex justify-between text-slate-400">
                    <span>Subtotal:</span>
                    <span class="font-mono-nums text-slate-300" x-text="'₱' + totalAmount.toFixed(2)"></span>
                </div>
                <div class="flex justify-between items-baseline pt-1 border-t border-slate-800">
                    <span class="text-sm font-bold text-white">TOTAL DUE:</span>
                    <span class="text-2xl font-black text-amber-400 font-mono-nums" x-text="'₱' + totalAmount.toFixed(2)"></span>
                </div>
            </div>

            <!-- Customer Payment & Change -->
            <div class="space-y-2 pt-2 border-t border-slate-800">
                <label class="block text-xs font-bold text-slate-300">Customer Payment (₱):</label>
                <div class="flex items-center space-x-2">
                    <input 
                        type="number" 
                        step="any"
                        x-model.number="paymentAmount" 
                        placeholder="0.00"
                        class="flex-1 px-3 py-2 bg-slate-900 border border-slate-700 rounded-xl text-base font-bold text-white font-mono-nums focus:outline-none focus:border-amber-500"
                    >
                    <button 
                        @click="paymentAmount = totalAmount"
                        class="px-3 py-2 bg-slate-800 hover:bg-slate-700 text-xs font-semibold text-slate-300 rounded-xl transition"
                    >
                        Exact
                    </button>
                </div>

                <!-- Quick Cash Presets -->
                <div class="flex items-center space-x-1.5 text-xs font-mono font-semibold">
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 100" class="flex-1 py-1 rounded bg-slate-900 border border-slate-800 hover:bg-slate-800 text-slate-300 transition">+₱100</button>
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 500" class="flex-1 py-1 rounded bg-slate-900 border border-slate-800 hover:bg-slate-800 text-slate-300 transition">+₱500</button>
                    <button @click="paymentAmount = Math.max(paymentAmount, 0) + 1000" class="flex-1 py-1 rounded bg-slate-900 border border-slate-800 hover:bg-slate-800 text-slate-300 transition">+₱1000</button>
                </div>

                <!-- Change Calculation -->
                <div class="flex justify-between items-center p-2.5 rounded-xl bg-slate-900 border border-slate-800">
                    <span class="text-xs font-bold text-slate-300">Change:</span>
                    <span 
                        class="text-lg font-black font-mono-nums"
                        :class="changeAmount >= 0 ? 'text-emerald-400' : 'text-red-400'"
                        x-text="'₱' + (changeAmount >= 0 ? changeAmount.toFixed(2) : '0.00')"
                    ></span>
                </div>
            </div>

            <!-- Submit Button -->
            <button 
                @click="submitCheckout()" 
                :disabled="cart.length === 0 || paymentAmount < totalAmount || isSubmitting"
                class="w-full py-3 rounded-xl font-extrabold text-sm uppercase tracking-wider transition-all duration-150 flex items-center justify-center shadow-lg"
                :class="(cart.length === 0 || paymentAmount < totalAmount || isSubmitting) ? 'bg-slate-800 text-slate-500 cursor-not-allowed shadow-none' : 'bg-amber-500 hover:bg-amber-400 text-slate-950 shadow-amber-500/25 cursor-pointer'"
            >
                <template x-if="isSubmitting">
                    <span>Recording Transaction...</span>
                </template>
                <template x-if="!isSubmitting">
                    <span class="flex items-center">
                        <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                        Record Sale & Print Receipt
                    </span>
                </template>
            </button>
        </div>
    </div>

    <!-- Success Receipt Modal -->
    <div 
        x-show="showReceiptModal" 
        x-cloak
        class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-sm"
    >
        <div class="bg-slate-900 border border-slate-700 rounded-2xl max-w-md w-full p-6 shadow-2xl space-y-4">
            <div class="text-center">
                <div class="w-12 h-12 rounded-full bg-emerald-500/20 text-emerald-400 flex items-center justify-center mx-auto mb-2">
                    <svg class="w-6 h-6" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"/></svg>
                </div>
                <h3 class="text-lg font-bold text-white">Sale Recorded Successfully!</h3>
                <p class="text-xs text-slate-400 font-mono-nums" x-text="'Invoice #' + (completedInvoice?.invoice_number || '')"></p>
            </div>

            <!-- Receipt Summary Box -->
            <div class="p-4 rounded-xl bg-slate-950 border border-slate-800 font-mono-nums text-xs space-y-2">
                <div class="flex justify-between text-slate-400">
                    <span>Date / Time:</span>
                    <span class="text-white" x-text="(completedInvoice?.date || '') + ' ' + (completedInvoice?.time || '')"></span>
                </div>
                <div class="flex justify-between text-slate-400">
                    <span>Total Amount:</span>
                    <span class="text-white font-bold" x-text="'₱' + parseFloat(completedInvoice?.total_sales || 0).toFixed(2)"></span>
                </div>
                <div class="flex justify-between text-slate-400">
                    <span>Payment:</span>
                    <span class="text-white" x-text="'₱' + parseFloat(completedInvoice?.customer_payment || 0).toFixed(2)"></span>
                </div>
                <div class="flex justify-between text-slate-400 pt-1 border-t border-slate-800">
                    <span class="text-emerald-400 font-bold">Change:</span>
                    <span class="text-emerald-400 font-bold" x-text="'₱' + parseFloat(completedInvoice?.customer_change || 0).toFixed(2)"></span>
                </div>
            </div>

            <!-- Buttons -->
            <div class="flex items-center space-x-3">
                <button 
                    @click="printLastReceipt()" 
                    class="flex-1 py-2.5 rounded-xl bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold text-xs uppercase tracking-wider transition"
                >
                    Print Receipt
                </button>
                <button 
                    @click="showReceiptModal = false" 
                    class="flex-1 py-2.5 rounded-xl bg-slate-800 hover:bg-slate-700 text-slate-300 font-semibold text-xs uppercase tracking-wider transition"
                >
                    New Transaction
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
                const matchesType = this.selectedType === 'All' || item.type === this.selectedType;
                const search = this.searchTerm.toLowerCase().trim();
                const matchesSearch = !search || 
                    item.product_name.toLowerCase().includes(search) || 
                    (item.brand && item.brand.toLowerCase().includes(search)) ||
                    (item.additional_name && item.additional_name.toLowerCase().includes(search)) ||
                    (item.location && item.location.toLowerCase().includes(search));
                return matchesType && matchesSearch;
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
                if (existing.quantity < product.quantity) {
                    existing.quantity++;
                }
            } else {
                this.cart.push({
                    product_id: product.product_id,
                    product_name: product.product_name,
                    price: parseFloat(product.price),
                    quantity: 1,
                    max_stock: product.quantity
                });
            }
        },

        incrementItem(item) {
            if (item.quantity < item.max_stock) {
                item.quantity++;
            }
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

            const payload = {
                items: this.cart.map(i => ({ product_id: i.product_id, quantity: i.quantity })),
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
                    // Update local stock counts
                    this.cart.forEach(cartItem => {
                        const prod = this.products.find(p => p.product_id === cartItem.product_id);
                        if (prod) prod.quantity -= cartItem.quantity;
                    });

                    this.completedInvoice = data.invoice;
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
                window.open('/transactions/invoice/' + this.completedInvoice.invoice_id, '_blank');
            }
        }
    };
}
</script>
@endsection
