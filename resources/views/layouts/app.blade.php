<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ $title ?? 'Joy Jeffrey Auto Supply' }} - AutoSupply POS &amp; Inventory</title>
    <meta name="description" content="Joy Jeffrey Auto Supply — Point-of-Sale &amp; Inventory Management System">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600&display=swap" rel="stylesheet">

    <!-- Vite Scripts & Styles -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <style>
        /* Base font */
        body { font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif; }

        /* ── Sidebar: fixed, full height, never scrolls ───── */
        #app-sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 16rem; /* w-64 */
            display: flex;
            flex-direction: column;
            overflow: hidden;
            z-index: 40;
            background: var(--sidebar-bg);
            border-right: 1px solid var(--sidebar-border);
            transition: background 0.2s, border-color 0.2s;
        }

        /* ── Sidebar inner scroll (nav links only) ────────── */
        #sidebar-nav {
            flex: 1;
            overflow-y: auto;
            padding: 0.75rem;
        }

        /* ── Main content: offset by sidebar width ─────────── */
        #app-main {
            margin-left: 16rem;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* ── Top header: fixed inside main column ───────────── */
        #app-header {
            position: sticky;
            top: 0;
            z-index: 30;
            height: 4rem;
            padding: 0 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: var(--header-bg);
            border-bottom: 1px solid var(--border);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            transition: background 0.2s, border-color 0.2s;
        }

        /* ── Page background ─────────────────────────────────── */
        body {
            background: var(--bg-base);
            color: var(--text-primary);
            transition: background 0.2s, color 0.2s;
        }

        /* ── Active nav item ─────────────────────────────────── */
        .nav-active {
            background: var(--brand);
            color: #ffffff !important;
            box-shadow: 0 4px 14px var(--brand-glow);
        }
        .nav-active svg { color: #ffffff !important; }

        .nav-idle {
            color: var(--text-secondary);
            transition: background 0.15s, color 0.15s;
        }
        .nav-idle:hover {
            background: var(--bg-elevated);
            color: var(--text-primary);
        }

        /* ── Selection ───────────────────────────────────────── */
        ::selection { background: var(--brand); color: #ffffff; }

        /* ── Sidebar logo image size ─────────────────────────── */
        .sidebar-logo { width: 2.25rem; height: 2.25rem; object-fit: contain; }

        /* ── Dark/light toggle ───────────────────────────────── */
        #theme-toggle { cursor: pointer; }

        /* ── Surface cards ───────────────────────────────────── */
        .surface {
            background: var(--bg-surface);
            border: 1px solid var(--border);
        }
        .surface-elevated {
            background: var(--bg-elevated);
            border: 1px solid var(--border-subtle);
        }

        /* ── Glowing Brand Button (Adaptive & Vivid) ────────── */
        .btn-brand, .glowingbutton {
            display: inline-flex;
            align-items: center;
            padding: 0.45rem 1rem;
            border-radius: 0.625rem;
            background: #9f1212 !important;
            color: #ffffff !important;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.025em;
            box-shadow: 0 4px 14px rgba(159, 18, 18, 0.45), 0 0 12px rgba(159, 18, 18, 0.25);
            transition: all 0.2s ease-in-out;
            border: 1px solid rgba(255, 255, 255, 0.15);
            text-decoration: none;
            cursor: pointer;
        }
        .dark .btn-brand, .dark .glowingbutton {
            background: #dc2626 !important;
            box-shadow: 0 4px 18px rgba(220, 38, 38, 0.55), 0 0 25px rgba(220, 38, 38, 0.35);
            border-color: rgba(255, 255, 255, 0.2);
        }
        .btn-brand:hover, .glowingbutton:hover {
            transform: translateY(-1px);
            box-shadow: 0 6px 22px rgba(220, 38, 38, 0.65), 0 0 30px rgba(220, 38, 38, 0.45);
            filter: brightness(1.1);
            color: #ffffff !important;
        }
        .btn-brand:active, .glowingbutton:active {
            transform: translateY(0);
            box-shadow: 0 2px 8px rgba(220, 38, 38, 0.4);
        }
    </style>
</head>
<body>

    <!-- ════════════════════════════════════════════════════
         SIDEBAR — Fixed, never scrolls with page content
    ═════════════════════════════════════════════════════ -->
    <aside id="app-sidebar">

        <!-- Brand Header -->
        <div class="p-5 flex-shrink-0" style="border-bottom: 1px solid var(--sidebar-border);">
            <a href="{{ route('dashboard') }}" class="flex items-center space-x-3 group">
                <!-- AMS Logo -->
                <img src="{{ asset('images/AMS_Logo.png') }}"
                     alt="AMS Logo"
                     class="sidebar-logo group-hover:scale-105 transition-transform duration-200">
                <div>
                    <h1 class="text-sm font-extrabold tracking-tight leading-none transition-colors"
                        style="color: var(--text-primary);">
                        JOY JEFFREY
                    </h1>
                    <span class="text-[10px] font-bold uppercase tracking-widest leading-tight block mt-0.5"
                          style="color: #9f1212;">
                        AUTO SUPPLY
                    </span>
                </div>
            </a>
        </div>

        <!-- Navigation Links (scrollable area) -->
        <nav id="sidebar-nav">
            <div class="px-3 py-2 text-[10px] font-bold uppercase tracking-wider mb-1"
                 style="color: var(--text-muted);">Main Menu</div>

            <!-- Dashboard -->
            <a href="{{ route('dashboard') }}"
               id="nav-dashboard"
               class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold mb-1 {{ request()->routeIs('dashboard') ? 'nav-active' : 'nav-idle' }}">
                <svg class="w-5 h-5 mr-3 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                </svg>
                Dashboard
            </a>

            <!-- POS Terminal -->
            <a href="{{ route('pos.index') }}"
               id="nav-pos"
               class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold mb-1 {{ request()->routeIs('pos.*') ? 'nav-active' : 'nav-idle' }}">
                <svg class="w-5 h-5 mr-3 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                </svg>
                POS Terminal
            </a>

            <!-- Inventory -->
            <a href="{{ route('inventory.index') }}"
               id="nav-inventory"
               class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold mb-1 {{ request()->routeIs('inventory.*') ? 'nav-active' : 'nav-idle' }}">
                <svg class="w-5 h-5 mr-3 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
                </svg>
                Inventory Catalog
            </a>

            <!-- Sales Records -->
            <a href="{{ route('reports.index') }}"
               id="nav-reports"
               class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold mb-1 {{ request()->routeIs('reports.index') ? 'nav-active' : 'nav-idle' }}">
                <svg class="w-5 h-5 mr-3 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 17v-2m3 2v-4m3 4v-6m2 10H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                </svg>
                Sales Records
            </a>

            <!-- Audit Trail -->
            <a href="{{ route('reports.audit') }}"
               id="nav-audit"
               class="flex items-center px-3.5 py-2.5 rounded-xl text-sm font-semibold mb-1 {{ request()->routeIs('reports.audit') ? 'nav-active' : 'nav-idle' }}">
                <svg class="w-5 h-5 mr-3 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z" />
                </svg>
                Audit Trail
            </a>
        </nav>

        <!-- User Profile & Logout — ALWAYS VISIBLE at bottom -->
        <div class="p-3 flex-shrink-0" style="border-top: 1px solid var(--sidebar-border); background: var(--sidebar-bg);">
            <div class="flex items-center justify-between p-2.5 rounded-xl"
                 style="background: var(--bg-elevated); border: 1px solid var(--border);">
                <div class="flex items-center space-x-3 overflow-hidden">
                    <!-- Avatar initials -->
                    <div class="w-8 h-8 rounded-lg flex items-center justify-center text-xs font-bold uppercase flex-shrink-0"
                         style="background: rgba(159,18,18,0.15); border: 1px solid rgba(159,18,18,0.3); color: #9f1212;">
                        {{ substr(auth()->user()->name ?? 'U', 0, 2) }}
                    </div>
                    <div class="overflow-hidden">
                        <p class="text-xs font-bold truncate" style="color: var(--text-primary);">
                            {{ auth()->user()->name ?? 'Cashier' }}
                        </p>
                        <p class="text-[10px] truncate" style="color: var(--text-muted);">
                            @<span>{{ auth()->user()->username ?? 'user' }}</span>
                        </p>
                    </div>
                </div>

                <!-- Logout button -->
                <form method="POST" action="{{ route('logout') }}">
                    @csrf
                    <button type="submit"
                            id="logout-btn"
                            title="Log Out"
                            class="p-1.5 rounded-lg transition-colors"
                            style="color: var(--text-muted);"
                            onmouseover="this.style.color='#9f1212';this.style.background='rgba(159,18,18,0.1)';"
                            onmouseout="this.style.color='var(--text-muted)';this.style.background='transparent';">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
                        </svg>
                    </button>
                </form>
            </div>
        </div>
    </aside>

    <!-- ════════════════════════════════════════════════════
         MAIN CONTENT AREA — offset by sidebar width
    ═════════════════════════════════════════════════════ -->
    <div id="app-main">

        <!-- Top Header Bar -->
        <header id="app-header">
            <div class="flex items-center space-x-4">
                <h2 class="text-base font-bold tracking-tight" style="color: var(--text-primary);">
                    @yield('page_title', 'Joy Jeffrey Auto Supply')
                </h2>
                <!-- System status pill -->
                <div class="hidden sm:flex items-center px-2.5 py-1 rounded-md text-xs font-mono-nums"
                     style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">
                    <span class="w-2 h-2 rounded-full bg-emerald-500 mr-2 animate-pulse"></span>
                    <span>System Online</span>
                </div>
            </div>

            <div class="flex items-center space-x-3">
                <!-- Live date/time -->
                <div class="text-right hidden sm:block">
                    <div class="text-xs font-semibold font-mono-nums" style="color: var(--text-secondary);" id="live-time">{{ now()->format('l, F j, Y') }}</div>
                    <div class="text-[11px] font-bold font-mono-nums" style="color: #9f1212;" id="live-clock">{{ now()->format('h:i:s A') }}</div>
                </div>

                <!-- Dark/Light mode toggle -->
                <button id="theme-toggle"
                        title="Toggle dark/light mode"
                        class="p-2 rounded-lg transition-colors"
                        style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">
                    <!-- Moon icon (shown in light mode → click to go dark) -->
                    <svg id="icon-dark" class="w-4 h-4 hidden" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
                    </svg>
                    <!-- Sun icon (shown in dark mode → click to go light) -->
                    <svg id="icon-light" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707M17.657 17.657l-.707-.707M6.343 6.343l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"/>
                    </svg>
                </button>

                <!-- New Sale shortcut -->
                <a href="{{ route('pos.index') }}" class="btn-brand glowingbutton" id="new-sale-btn">
                    <svg class="w-3.5 h-3.5 mr-1.5" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 4v16m8-8H4" />
                    </svg>
                    New Sale
                </a>
            </div>
        </header>

        <!-- Flash Messages -->
        @if (session('success'))
            <div class="mx-6 mt-4 p-4 rounded-xl text-sm flex items-center justify-between shadow-lg"
                 style="background: rgba(16,185,129,0.08); border: 1px solid rgba(16,185,129,0.3); color: #10b981;"
                 x-data="{ show: true }" x-show="show">
                <div class="flex items-center space-x-3">
                    <svg class="w-5 h-5 flex-shrink-0" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                    </svg>
                    <span class="font-medium">{{ session('success') }}</span>
                </div>
                <button @click="show = false">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                </button>
            </div>
        @endif

        @if ($errors->any())
            <div class="mx-6 mt-4 p-4 rounded-xl text-sm shadow-lg"
                 style="background: rgba(229,19,19,0.08); border: 1px solid rgba(229,19,19,0.3); color: #e51313;"
                 x-data="{ show: true }" x-show="show">
                <div class="flex items-start justify-between">
                    <div class="flex items-start space-x-3">
                        <svg class="w-5 h-5 flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <div>
                            <p class="font-bold">Please check the following errors:</p>
                            <ul class="mt-1 list-disc list-inside space-y-0.5 text-xs" style="color: #f83535;">
                                @foreach ($errors->all() as $error)
                                    <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    </div>
                    <button @click="show = false">
                        <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12"/></svg>
                    </button>
                </div>
            </div>
        @endif

        <!-- Page Content (this scrolls) -->
        <main class="flex-1 p-6">
            {{ $slot ?? '' }}
            @yield('content')
        </main>
    </div>

    <!-- ════ Scripts ════════════════════════════════════════ -->
    <script>
        /* ── Live clock ──────────────────────────── */
        function updateClock() {
            const el = document.getElementById('live-clock');
            if (el) {
                el.textContent = new Date().toLocaleTimeString('en-US', {
                    hour: '2-digit', minute: '2-digit', second: '2-digit', hour12: true
                });
            }
        }
        setInterval(updateClock, 1000);

        /* ── Dark / Light mode toggle ────────────── */
        const html        = document.documentElement;
        const toggleBtn   = document.getElementById('theme-toggle');
        const iconDark    = document.getElementById('icon-dark');
        const iconLight   = document.getElementById('icon-light');

        function applyTheme(mode) {
            if (mode === 'dark') {
                html.classList.add('dark');
                iconLight.classList.remove('hidden');
                iconDark.classList.add('hidden');
            } else {
                html.classList.remove('dark');
                iconLight.classList.add('hidden');
                iconDark.classList.remove('hidden');
            }
            localStorage.setItem('ams-theme', mode);
        }

        // Init from localStorage or default dark
        applyTheme(localStorage.getItem('ams-theme') || 'dark');

        toggleBtn.addEventListener('click', function () {
            const isDark = html.classList.contains('dark');
            applyTheme(isDark ? 'light' : 'dark');
        });
    </script>
</body>
</html>
