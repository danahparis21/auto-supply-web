@extends('layouts.app')

@section('page_title', 'Inventory & Product Catalog')

@section('content')
<div x-data="inventoryManager()" class="space-y-6">

    <!-- KPI Summary Cards -->
    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
        <div class="p-4 rounded-xl bg-slate-900 border border-slate-800 shadow-md">
            <span class="text-xs font-semibold text-slate-400 uppercase tracking-wider">Total Catalog SKUs</span>
            <div class="mt-2 flex items-baseline justify-between">
                <span class="text-2xl font-extrabold text-white font-mono-nums">{{ $totalInventoryCount }}</span>
                <span class="text-xs text-slate-500">Active products</span>
            </div>
        </div>

        <div class="p-4 rounded-xl bg-slate-900 border border-slate-800 shadow-md">
            <span class="text-xs font-semibold text-amber-400 uppercase tracking-wider">Low Stock (≤ 5 Units)</span>
            <div class="mt-2 flex items-baseline justify-between">
                <span class="text-2xl font-extrabold text-amber-400 font-mono-nums">{{ $lowStockCount }}</span>
                <a href="{{ route('inventory.index', ['low_stock' => 1]) }}" class="text-xs text-amber-400 hover:underline">Filter items →</a>
            </div>
        </div>

        <div class="p-4 rounded-xl bg-slate-900 border border-slate-800 shadow-md">
            <span class="text-xs font-semibold text-red-400 uppercase tracking-wider">Out of Stock</span>
            <div class="mt-2 flex items-baseline justify-between">
                <span class="text-2xl font-extrabold text-red-400 font-mono-nums">{{ $outOfStockCount }}</span>
                <span class="text-xs text-slate-500">Requires restocking</span>
            </div>
        </div>
    </div>

    <!-- Controls Bar -->
    <div class="p-4 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl flex flex-col md:flex-row items-center justify-between gap-4">
        
        <!-- Search & Filter Form -->
        <form method="GET" action="{{ route('inventory.index') }}" class="flex-1 w-full flex flex-wrap items-center gap-3">
            <!-- Search -->
            <div class="relative flex-1 min-w-[200px]">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-500">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"/></svg>
                </div>
                <input 
                    type="text" 
                    name="search" 
                    value="{{ $search }}" 
                    placeholder="Search by name, brand, location..." 
                    class="w-full pl-10 pr-4 py-2 bg-slate-950 border border-slate-800 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 transition"
                >
            </div>

            <!-- Category Filter -->
            <select 
                name="type" 
                onchange="this.form.submit()" 
                class="px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-xs font-semibold text-white focus:outline-none focus:border-amber-500 transition"
            >
                <option value="All" {{ $selectedCategory === 'All' ? 'selected' : '' }}>All Categories</option>
                @foreach($categories as $cat)
                    <option value="{{ $cat }}" {{ $selectedCategory === $cat ? 'selected' : '' }}>{{ $cat }}</option>
                @endforeach
            </select>

            <!-- Low Stock Toggle -->
            <a 
                href="{{ $isLowStockFilter ? route('inventory.index') : route('inventory.index', ['low_stock' => 1]) }}"
                class="px-3 py-2 rounded-xl text-xs font-semibold border transition flex items-center {{ $isLowStockFilter ? 'bg-amber-500 text-slate-950 border-amber-500 font-bold' : 'bg-slate-950 text-slate-300 border-slate-800 hover:border-slate-700' }}"
            >
                <span class="w-2 h-2 rounded-full mr-1.5 {{ $isLowStockFilter ? 'bg-slate-950' : 'bg-amber-400' }}"></span>
                Low Stock Only
            </a>

            @if($search || $selectedCategory !== 'All' || $isLowStockFilter)
                <a href="{{ route('inventory.index') }}" class="px-2.5 py-2 text-xs font-semibold text-slate-400 hover:text-white transition">
                    Reset
                </a>
            @endif
        </form>

        <!-- Add Product Button -->
        <button 
            @click="openAddModal()" 
            class="w-full md:w-auto px-4 py-2.5 rounded-xl bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold text-xs uppercase tracking-wider shadow-md shadow-amber-500/20 transition flex items-center justify-center whitespace-nowrap"
        >
            <svg class="w-4 h-4 mr-1.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4"/></svg>
            Add New Part
        </button>
    </div>

    <!-- Inventory Data Table -->
    <div class="rounded-2xl bg-slate-900 border border-slate-800 shadow-xl overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-sm">
                <thead>
                    <tr class="text-xs uppercase tracking-wider text-slate-400 border-b border-slate-800 bg-slate-900/80">
                        <th class="py-3.5 px-4">Part Details</th>
                        <th class="py-3.5 px-4">Category</th>
                        <th class="py-3.5 px-4">Brand</th>
                        <th class="py-3.5 px-4">Location</th>
                        <th class="py-3.5 px-4 text-right">Price</th>
                        <th class="py-3.5 px-4 text-center">Stock Status</th>
                        <th class="py-3.5 px-4 text-right">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800/60 font-sans">
                    @forelse($products as $product)
                        <tr class="hover:bg-slate-800/40 transition">
                            <!-- Part Details -->
                            <td class="py-3.5 px-4">
                                <div class="font-bold text-white leading-snug">{{ $product->product_name }}</div>
                                @if($product->additional_name)
                                    <div class="text-xs text-slate-400 truncate max-w-xs">{{ $product->additional_name }}</div>
                                @endif
                            </td>

                            <!-- Category -->
                            <td class="py-3.5 px-4">
                                <span class="px-2.5 py-1 rounded-md text-[11px] font-semibold bg-slate-800 text-slate-300 border border-slate-700/60">
                                    {{ $product->type }}
                                </span>
                            </td>

                            <!-- Brand -->
                            <td class="py-3.5 px-4 text-slate-300 text-xs font-medium">
                                {{ $product->brand ?? 'OEM' }}
                            </td>

                            <!-- Location -->
                            <td class="py-3.5 px-4 font-mono-nums text-xs text-slate-400">
                                {{ $product->location ?? 'General' }}
                            </td>

                            <!-- Price -->
                            <td class="py-3.5 px-4 text-right font-mono-nums font-bold text-amber-400 text-sm">
                                ₱{{ number_format($product->price, 2) }}
                            </td>

                            <!-- Stock Status -->
                            <td class="py-3.5 px-4 text-center font-mono-nums">
                                @if($product->quantity <= 0)
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-red-500/15 text-red-400 border border-red-500/30">
                                        0 (Out of stock)
                                    </span>
                                @elseif($product->quantity <= 5)
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-amber-500/15 text-amber-400 border border-amber-500/30">
                                        {{ $product->quantity }} (Low stock)
                                    </span>
                                @else
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-[11px] font-bold bg-emerald-500/15 text-emerald-400 border border-emerald-500/30">
                                        {{ $product->quantity }} in stock
                                    </span>
                                @endif
                            </td>

                            <!-- Actions -->
                            <td class="py-3.5 px-4 text-right">
                                <div class="flex items-center justify-end space-x-1.5">
                                    <!-- Restock Button -->
                                    <button 
                                        @click="openRestockModal({{ json_encode($product) }})" 
                                        title="Quick Restock"
                                        class="p-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-emerald-400 transition"
                                    >
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/></svg>
                                    </button>

                                    <!-- Edit Button -->
                                    <button 
                                        @click="openEditModal({{ json_encode($product) }})" 
                                        title="Edit Product"
                                        class="p-1.5 rounded-lg bg-slate-800 hover:bg-slate-700 text-amber-400 transition"
                                    >
                                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"/></svg>
                                    </button>

                                    <!-- Delete Form -->
                                    <form method="POST" action="{{ route('inventory.destroy', $product->product_id) }}" onsubmit="return confirm('Are you sure you want to delete {{ addslashes($product->product_name) }}?');" class="inline">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" title="Delete Product" class="p-1.5 rounded-lg bg-slate-800 hover:bg-red-900/40 text-slate-400 hover:text-red-400 transition">
                                            <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/></svg>
                                        </button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="py-12 text-center text-slate-500">
                                No products found matching your filter criteria.
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="p-4 border-t border-slate-800 bg-slate-900/80">
            {{ $products->links() }}
        </div>
    </div>

    <!-- Modal: Add New Product -->
    <div x-show="showAddModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-sm">
        <div class="bg-slate-900 border border-slate-700 rounded-2xl max-w-lg w-full p-6 shadow-2xl space-y-4">
            <div class="flex items-center justify-between border-b border-slate-800 pb-3">
                <h3 class="text-base font-bold text-white">Add New Auto Part</h3>
                <button @click="showAddModal = false" class="text-slate-400 hover:text-white">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>

            <form method="POST" action="{{ route('inventory.store') }}" class="space-y-3 text-xs">
                @csrf
                <div class="grid grid-cols-2 gap-3">
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Product Name *</label>
                        <input type="text" name="product_name" required placeholder="e.g. Wheel Bearing 6204" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Additional Name / Specs</label>
                        <input type="text" name="additional_name" placeholder="e.g. 5W-30 Full Synthetic 4L" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Category / Type *</label>
                        <input type="text" name="type" required placeholder="Fluids, Mechanical..." class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Brand</label>
                        <input type="text" name="brand" placeholder="e.g. Castrol, Bosch, Brembo" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Selling Price (₱) *</label>
                        <input type="number" step="any" name="price" required placeholder="0.00" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white font-mono text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Initial Quantity *</label>
                        <input type="number" name="quantity" required value="10" min="0" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white font-mono text-xs focus:border-amber-500">
                    </div>
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Store / Shelf Location</label>
                        <input type="text" name="location" placeholder="e.g. Shelf B-2 or Rack A-1" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Description / Notes</label>
                        <textarea name="description" rows="2" placeholder="Part specifications..." class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500"></textarea>
                    </div>
                </div>

                <div class="pt-3 border-t border-slate-800 flex items-center justify-end space-x-2">
                    <button type="button" @click="showAddModal = false" class="px-3 py-2 rounded-xl bg-slate-800 text-slate-300 hover:bg-slate-700 transition">Cancel</button>
                    <button type="submit" class="px-4 py-2 rounded-xl bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold transition">Add to Catalog</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal: Edit Product -->
    <div x-show="showEditModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-sm">
        <div class="bg-slate-900 border border-slate-700 rounded-2xl max-w-lg w-full p-6 shadow-2xl space-y-4">
            <div class="flex items-center justify-between border-b border-slate-800 pb-3">
                <h3 class="text-base font-bold text-white">Edit Product</h3>
                <button @click="showEditModal = false" class="text-slate-400 hover:text-white">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>

            <form :action="'/inventory/' + editItem.product_id" method="POST" class="space-y-3 text-xs">
                @csrf
                @method('PUT')
                <div class="grid grid-cols-2 gap-3">
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Product Name *</label>
                        <input type="text" name="product_name" x-model="editItem.product_name" required class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Additional Name / Specs</label>
                        <input type="text" name="additional_name" x-model="editItem.additional_name" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Category / Type *</label>
                        <input type="text" name="type" x-model="editItem.type" required class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Brand</label>
                        <input type="text" name="brand" x-model="editItem.brand" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Price (₱) *</label>
                        <input type="number" step="any" name="price" x-model="editItem.price" required class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white font-mono text-xs focus:border-amber-500">
                    </div>
                    <div>
                        <label class="block font-bold text-slate-300 mb-1">Current Quantity *</label>
                        <input type="number" name="quantity" x-model="editItem.quantity" required min="0" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white font-mono text-xs focus:border-amber-500">
                    </div>
                    <div class="col-span-2">
                        <label class="block font-bold text-slate-300 mb-1">Shelf Location</label>
                        <input type="text" name="location" x-model="editItem.location" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white text-xs focus:border-amber-500">
                    </div>
                </div>

                <div class="pt-3 border-t border-slate-800 flex items-center justify-end space-x-2">
                    <button type="button" @click="showEditModal = false" class="px-3 py-2 rounded-xl bg-slate-800 text-slate-300 hover:bg-slate-700 transition">Cancel</button>
                    <button type="submit" class="px-4 py-2 rounded-xl bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold transition">Save Changes</button>
                </div>
            </form>
        </div>
    </div>

    <!-- Modal: Quick Restock -->
    <div x-show="showRestockModal" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-950/80 backdrop-blur-sm">
        <div class="bg-slate-900 border border-slate-700 rounded-2xl max-w-sm w-full p-6 shadow-2xl space-y-4">
            <div class="flex items-center justify-between border-b border-slate-800 pb-3">
                <h3 class="text-base font-bold text-white">Quick Restock</h3>
                <button @click="showRestockModal = false" class="text-slate-400 hover:text-white">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>

            <form :action="'/inventory/' + restockItem.product_id + '/restock'" method="POST" class="space-y-4 text-xs">
                @csrf
                <div>
                    <h5 class="font-bold text-white text-sm" x-text="restockItem.product_name"></h5>
                    <p class="text-slate-400 font-mono-nums" x-text="'Current Stock: ' + restockItem.quantity + ' units'"></p>
                </div>

                <div>
                    <label class="block font-bold text-slate-300 mb-1">Additional Quantity to Add *</label>
                    <input type="number" name="additional_quantity" required min="1" value="10" class="w-full px-3 py-2 bg-slate-950 border border-slate-800 rounded-xl text-white font-mono text-sm focus:border-amber-500">
                </div>

                <div class="pt-2 border-t border-slate-800 flex items-center justify-end space-x-2">
                    <button type="button" @click="showRestockModal = false" class="px-3 py-2 rounded-xl bg-slate-800 text-slate-300 hover:bg-slate-700 transition">Cancel</button>
                    <button type="submit" class="px-4 py-2 rounded-xl bg-emerald-500 hover:bg-emerald-400 text-slate-950 font-bold transition">Confirm Restock</button>
                </div>
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
        editItem: {},
        restockItem: {},

        openAddModal() {
            this.showAddModal = true;
        },

        openEditModal(product) {
            this.editItem = Object.assign({}, product);
            this.showEditModal = true;
        },

        openRestockModal(product) {
            this.restockItem = Object.assign({}, product);
            this.showRestockModal = true;
        }
    };
}
</script>
@endsection
