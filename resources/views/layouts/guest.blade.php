<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}" class="dark">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Joy Jeffrey Auto Supply') }} - Login</title>
    <meta name="description" content="Login to Joy Jeffrey Auto Supply Management System">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800;900&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">

    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
        .glass-panel {
            background: rgba(18, 18, 22, 0.75);
            backdrop-filter: blur(24px);
            -webkit-backdrop-filter: blur(24px);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .light .glass-panel, html:not(.dark) .glass-panel {
            background: rgba(255, 255, 255, 0.95);
            border: 1px solid rgba(0, 0, 0, 0.12);
            color: #18181b !important;
        }
        .car-hero-overlay-dark {
            background: linear-gradient(to right, rgba(0, 0, 0, 0.2) 0%, rgba(10, 10, 12, 0.5) 60%, rgba(10, 10, 12, 0.98) 100%),
                        linear-gradient(to top, rgba(10, 10, 12, 0.95) 0%, rgba(10, 10, 12, 0.4) 40%, transparent 100%);
        }
        .car-hero-overlay-light {
            background: linear-gradient(to right, transparent 88%, rgba(228, 228, 231, 0.35) 100%);
            opacity: 0.35;
        }
        .hero-text-shadow {
            text-shadow: none;
        }
        .dark .hero-text-shadow {
            text-shadow: 0 4px 20px rgba(0, 0, 0, 0.85);
        }
        .hero-body-shadow {
            text-shadow: none;
        }
        .dark .hero-body-shadow {
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.7);
        }
    </style>
</head>
<body class="min-h-screen antialiased flex relative overflow-x-hidden"
      style="background: var(--bg-base); color: var(--text-primary);">

    <!-- Dark/Light Theme Toggle (Floating Top-Right) -->
    <button id="guest-theme-toggle"
            title="Toggle dark/light mode"
            class="fixed top-5 right-5 p-2.5 rounded-xl transition-all z-50 glass-panel shadow-lg hover:scale-105 cursor-pointer"
            style="color: var(--text-secondary);">
        <svg id="g-icon-dark" class="w-4 h-4 hidden" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
        </svg>
        <svg id="g-icon-light" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707M17.657 17.657l-.707-.707M6.343 6.343l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"/>
        </svg>
    </button>

    <!-- Split Screen Layout -->
    <div class="w-full min-h-screen grid grid-cols-1 lg:grid-cols-12 relative">

        <!-- Left Supercar Hero Section (Desktop) -->
        <div class="hidden lg:flex lg:col-span-7 relative flex-col justify-end p-12 overflow-hidden select-none bg-neutral-100 dark:bg-[#09090b]">

            <!-- Background Supercar Images (Adaptive to Theme) -->
            <!-- Dark Mode Hero: Ford GT Moody Crimson Studio -->
            <img src="{{ asset('images/products/car-blackbg.jpg') }}"
                 alt="High Performance Auto"
                 class="hidden dark:block absolute inset-0 w-full h-full object-cover object-center transform scale-100 hover:scale-105 transition-transform duration-1000 ease-out">

            <!-- Light Mode Hero: Studio Red Ferrari -->
            <img src="{{ asset('images/products/car-whitebg.jpg') }}"
                 alt="High Performance Auto"
                 class="block dark:hidden absolute inset-0 w-full h-full object-cover object-center transform scale-100 hover:scale-105 transition-transform duration-1000 ease-out">

            <!-- Gradients / Vignette Overlay -->
            <div class="hidden dark:block absolute inset-0 car-hero-overlay-dark pointer-events-none"></div>
            <div class="block dark:hidden absolute inset-0 car-hero-overlay-light pointer-events-none"></div>

            <!-- Bottom Supercar Showcase Content -->
            <div class="relative z-10 max-w-xl space-y-4 pt-16">
                <div>
                    <p class="text-xs font-black tracking-widest uppercase text-red-600 dark:text-red-500 mb-1">
                        JOY JEFFREY AUTO SUPPLY
                    </p>
                    <h1 class="text-4xl xl:text-5xl font-black tracking-tight text-neutral-900 dark:text-white uppercase leading-tight hero-text-shadow">
                        Journey Beyond.
                    </h1>
                </div>

                <p class="text-sm font-bold text-neutral-800 dark:text-neutral-300 leading-relaxed max-w-lg hero-body-shadow">
                    Precision inventory control, high-speed POS ticketing, and certified automotive replacement parts for Toyota, Mitsubishi, Isuzu, and Honda.
                </p>
            </div>
        </div>

        <!-- Right Login Panel (Desktop & Mobile) -->
        <div class="col-span-1 lg:col-span-5 flex flex-col justify-between p-6 sm:p-10 lg:p-14 relative z-10 min-h-screen"
             style="background: var(--bg-surface); border-left: 1px solid var(--border);">

            <!-- Mobile Supercar Blurred Background (hidden on lg) -->
            <div class="lg:hidden absolute inset-0 z-0 overflow-hidden pointer-events-none opacity-20">
                <img src="{{ asset('images/products/car-blackbg.jpg') }}" alt="Auto Background" class="w-full h-full object-cover">
                <div class="absolute inset-0 bg-black/70 backdrop-blur-sm"></div>
            </div>

            <!-- Top Header & AMS Logo -->
            <div class="relative z-10 pt-2">
                <div class="flex items-center space-x-3 mb-8">
                    <!-- AMS Logo Badge with Crimson Glow -->
                    <div class="w-12 h-12 rounded-2xl flex items-center justify-center p-2 transition-transform hover:scale-105"
                         style="background: var(--bg-elevated); border: 1px solid var(--border); box-shadow: 0 4px 20px rgba(220, 38, 38, 0.25);">
                        <img src="{{ asset('images/AMS_Logo.png') }}"
                             alt="AMS Logo"
                             class="w-full h-full object-contain">
                    </div>
                    <div>
                        <h2 class="text-base font-black tracking-tight uppercase" style="color: var(--text-primary);">
                            JOY JEFFREY
                        </h2>
                        <p class="text-[10px] font-extrabold uppercase tracking-widest" style="color: var(--brand);">
                            AUTO SUPPLY & POS
                        </p>
                    </div>
                </div>
            </div>

            <!-- Main Auth Content ($slot) -->
            <div class="relative z-10 my-auto py-6 max-w-md w-full mx-auto">
                {{ $slot }}
            </div>

            <!-- Bottom System Info Footer -->
            <div class="relative z-10 pt-6 mt-4 border-t flex flex-col sm:flex-row items-center justify-between text-[11px] gap-2"
                 style="border-color: var(--border); color: var(--text-muted);">
                <span>Joy Jeffrey Auto Supply</span>
                <span>Team HotwWheels</span>
            </div>
        </div>
    </div>

    <!-- Theme Switcher Script -->
    <script>
        const gHtml      = document.documentElement;
        const gBtn       = document.getElementById('guest-theme-toggle');
        const gIconDark  = document.getElementById('g-icon-dark');
        const gIconLight = document.getElementById('g-icon-light');

        function gApplyTheme(mode) {
            if (mode === 'dark') {
                gHtml.classList.add('dark');
                gHtml.classList.remove('light');
                gIconLight.classList.remove('hidden');
                gIconDark.classList.add('hidden');
            } else {
                gHtml.classList.remove('dark');
                gHtml.classList.add('light');
                gIconLight.classList.add('hidden');
                gIconDark.classList.remove('hidden');
            }
            localStorage.setItem('ams-theme', mode);
        }

        gApplyTheme(localStorage.getItem('ams-theme') || 'dark');

        gBtn.addEventListener('click', function () {
            gApplyTheme(gHtml.classList.contains('dark') ? 'light' : 'dark');
        });
    </script>
</body>
</html>
