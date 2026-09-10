<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ $title ?? 'Joy Jeffrey Auto Supply' }} - AutoSupply POS & Inventory</title>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Vite Scripts & Styles -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <style>
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
        }
        .font-mono-nums {
            font-family: 'JetBrains Mono', monospace;
            font-variant-numeric: tabular-nums;
        }
        /* Custom scrollbars */
        ::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }
        ::-webkit-scrollbar-track {
            background: #0f172a;
        }
        ::-webkit-scrollbar-thumb {
            background: #334155;
            border-radius: 9999px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #475569;
        }
    </style>
</head>
<body class="bg-slate-950 text-slate-100 min-h-screen antialiased flex selection:bg-amber-500 selection:text-slate-950">

    <!-- Sidebar Navigation -->
    <aside class="w-64 bg-slate-900 border-r border-slate-800/80 flex-shrink-0 flex flex-col min-h-screen sticky top-0 z-40">
        <!-- Brand Header -->
        <div class="p-5 border-b border-slate-800/80">
            <a href="{{ route('dashboard') }}" class="flex items-center space-x-3 group">
                <div class="w-10 h-10 rounded-xl bg-gradient-to-tr from-amber-500 to-orange-600 flex items-center justify-center shadow-lg shadow-amber-500/20 group-hover:scale-105 transition-transform duration-200">
                    <svg class="w-6 h-6 text-slate-950" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                        <path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
                    </svg>
                </div>
                <div>
                    <h1 class="text-base font-bold text-white tracking-tight leading-none group-hover:text-amber-400 transition-colors">JOY JEFFREY</h1>
                    <span class="text-xs font-semibold text-amber-500 uppercase tracking-widest leading-tight block mt-0.5">AUTO SUPPLY</span>
                </div>
            </a>
        </div>

        <!-- Navigation Links -->
        <nav class="p-3 space-y-1.5 flex-1">
            <div class="px-3 py-2 text-[11px] font-bold uppercase tracking-wider text-slate-500">Main Menu</div>

            <!-- Dashboard -->
            <a href="{{ route('dashboard') }}" class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-150 {{ request()->routeIs('dashboard') ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/25 font-bold' : 'text-slate-300 hover:bg-slate-800/80 hover:text-white' }}">
                <svg class="w-5 h-5 mr-3 {{ request()->routeIs('dashboard') ? 'text-slate-950' : 'text-slate-400' }}" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                </svg>
                Dashboard
            </a>

            <!-- POS Transactions -->
            <a href="{{ route('pos.index') }}" class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-150 {{ request()->routeIs('pos.*') ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/25 font-bold' : 'text-slate-300 hover:bg-slate-800/80 hover:text-white' }}">
                <svg class="w-5 h-5 mr-3 {{ request()->routeIs('pos.*') ? 'text-slate-950' : 'text-slate-400' }}" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
                POS Terminal
            </a>

            <!-- Inventory -->
            <a href="{{ route('inventory.index') }}" class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-150 {{ request()->routeIs('inventory.*') ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/25 font-bold' : 'text-slate-300 hover:bg-slate-800/80 hover:text-white' }}">
                <svg class="w-5 h-5 mr-3 {{ request()->routeIs('inventory.*') ? 'text-slate-950' : 'text-slate-400' }}" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
                Inventory Catalog
            </a>

            <!-- Sales Records -->
            <a href="{{ route('reports.index') }}" class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-150 {{ request()->routeIs('reports.index') ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/25 font-bold' : 'text-slate-300 hover:bg-slate-800/80 hover:text-white' }}">
                <svg class="w-5 h-5 mr-3 {{ request()->routeIs('reports.index') ? 'text-slate-950' : 'text-slate-400' }}" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                Sales Records
            </a>

            <!-- Audit Trail -->
            <a href="{{ route('reports.audit') }}" class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold transition-all duration-150 {{ request()->routeIs('reports.audit') ? 'bg-amber-500 text-slate-950 shadow-md shadow-amber-500/25 font-bold' : 'text-slate-300 hover:bg-slate-800/80 hover:text-white' }}">
                <svg class="w-5 h-5 mr-3 {{ request()->routeIs('reports.audit') ? 'text-slate-950' : 'text-slate-400' }}" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                </svg>
                Audit Trail
            </a>
        </nav>

        <!-- Current User Profile & Logout -->
        <div class="p-3 border-t border-slate-800/80 bg-slate-900/50">
            <div class="flex items-center justify-between p-2.5 rounded-xl bg-slate-800/50 border border-slate-700/50">
                <div class="flex items-center space-x-3 overflow-hidden">
                    <div class="w-8 h-8 rounded-lg bg-amber-500/20 border border-amber-500/30 flex items-center justify-center text-amber-400 font-bold text-xs uppercase">
                        {{ substr(auth()->user()->name ?? 'U', 0, 2) }}
                    </div>
                    <div class="overflow-hidden">
                        <p class="text-xs font-bold text-white truncate">{{ auth()->user()->name ?? 'Cashier' }}</p>
                        <p class="text-[10px] text-slate-400 truncate">@<span>{{ auth()->user()->username ?? 'user' }}</span></p>
                    </div>
                </div>

                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit" title="Log Out" class="p-1.5 text-slate-400 hover:text-red-400 hover:bg-slate-700/50 rounded-lg transition-colors">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                    </button>
                </form>
            </div>
        </div>
    </aside>

    <!-- Main Content Area -->
    <div class="flex-1 flex flex-col min-w-0">
        <!-- Top Navbar -->
        <header class="h-16 bg-slate-900/70 backdrop-blur-md border-b border-slate-800/80 px-6 flex items-center justify-between sticky top-0 z-30">
            <div class="flex items-center space-x-4">
                <h2 class="text-lg font-bold text-white tracking-tight">
                    @yield('page_title', 'Joy Jeffrey Auto Supply')
                </h2>
                <div class="hidden sm:flex items-center px-2.5 py-1 rounded-md bg-slate-800 border border-slate-700/60 text-xs text-slate-300 font-mono-nums">
                    <span class="w-2 h-2 rounded-full bg-emerald-500 mr-2 animate-pulse"></span>
                    <span>System Online</span>
                </div>
            </div>

            <div class="flex items-center space-x-3">
                <div class="text-right hidden sm:block">
                    <div class="text-xs font-semibold text-slate-300" id="live-time">{{ now()->format('l, F j, Y') }}</div>
                    <div class="text-[11px] text-amber-500 font-mono-nums font-bold" id="live-clock">{{ now()->format('h:i:s A') }}</div>
                </div>

                <a href="{{ route('pos.index') }}" class="inline-flex items-center px-3 py-1.5 rounded-lg bg-amber-500 hover:bg-amber-400 text-slate-950 font-bold text-xs shadow-md shadow-amber-500/20 transition-all duration-150">
                    <svg class="w-3.5 h-3.5 mr-1.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                    </svg>
                    New Sale
                </a>
            </div>
        </header>

        <!-- Flash Messages -->
        @if (session('success'))
            <div class="mx-6 mt-4 p-4 rounded-xl bg-emerald-950/60 border border-emerald-500/40 text-emerald-300 text-sm flex items-center justify-between shadow-lg shadow-emerald-950/50" x-data="{ show: true }" x-show="show">
                <div class="flex items-center space-x-3">
                    <svg class="w-5 h-5 text-emerald-400 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span class="font-medium">{{ session('success') }}</span>
                </div>
                <button @click="show = false" class="text-emerald-400 hover:text-emerald-200">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>
        @endif

        @if ($errors->any())
            <div class="mx-6 mt-4 p-4 rounded-xl bg-red-950/60 border border-red-500/40 text-red-300 text-sm shadow-lg shadow-red-950/50" x-data="{ show: true }" x-show="show">
                <div class="flex items-start justify-between">
                    <div class="flex items-start space-x-3">
                        <svg class="w-5 h-5 text-red-400 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <div>
                            <p class="font-bold">Please check the following errors:</p>
                            <ul class="mt-1 list-disc list-inside space-y-0.5 text-xs text-red-200">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    </div>
                    <button @click="show = false" class="text-red-400 hover:text-red-200">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                    </button>
                </div>
            </div>
        @endif

        <!-- Page Main Content Slot -->
        <main class="flex-1 p-6">
            {{ $slot ?? '' }}
            @yield('content')
        </main>
    </div>

    <!-- Live Clock Script -->
    <script>
        function updateClock() {
            const now = new Date();
            const clockEl = document.getElementById('live-clock');
            if (clockEl) {
                clockEl.textContent = now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true });
            }
        }
        setInterval(updateClock, 1000);
    </script>
</body>
</html>
