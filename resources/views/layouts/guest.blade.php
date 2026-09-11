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
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@500;700&display=swap" rel="stylesheet">

    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <style>
        body { font-family: 'Plus Jakarta Sans', sans-serif; }
    </style>
</head>
<body class="min-h-screen antialiased flex flex-col justify-center items-center p-4 relative overflow-hidden"
      style="background: var(--bg-base); color: var(--text-primary);">

    <!-- Ambient red glows -->
    <div class="absolute -top-40 -left-40 w-96 h-96 rounded-full blur-3xl pointer-events-none opacity-30"
         style="background: radial-gradient(circle, #9f1212 0%, transparent 70%);"></div>
    <div class="absolute -bottom-40 -right-40 w-96 h-96 rounded-full blur-3xl pointer-events-none opacity-20"
         style="background: radial-gradient(circle, #7f0c0c 0%, transparent 70%);"></div>
    <!-- Subtle grid overlay -->
    <div class="absolute inset-0 pointer-events-none opacity-[0.03]"
         style="background-image: linear-gradient(var(--border) 1px, transparent 1px), linear-gradient(90deg, var(--border) 1px, transparent 1px); background-size: 40px 40px;"></div>

    <!-- Dark/Light toggle (top-right) -->
    <button id="guest-theme-toggle"
            title="Toggle dark/light mode"
            class="absolute top-5 right-5 p-2 rounded-lg transition-colors z-10"
            style="background: var(--bg-surface); border: 1px solid var(--border); color: var(--text-secondary);">
        <svg id="g-icon-dark" class="w-4 h-4 hidden" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M20.354 15.354A9 9 0 018.646 3.646 9.003 9.003 0 0012 21a9.003 9.003 0 008.354-5.646z"/>
        </svg>
        <svg id="g-icon-light" class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M12 3v1m0 16v1m9-9h-1M4 12H3m15.364-6.364l-.707.707M6.343 17.657l-.707.707M17.657 17.657l-.707-.707M6.343 6.343l-.707-.707M12 8a4 4 0 100 8 4 4 0 000-8z"/>
        </svg>
    </button>

    <div class="w-full max-w-md relative z-10">
        <!-- Logo & Branding -->
        <div class="text-center mb-8">
            <!-- AMS Logo -->
            <div class="flex justify-center mb-4">
                <div class="w-20 h-20 rounded-2xl flex items-center justify-center shadow-2xl border"
                     style="background: var(--bg-surface); border-color: var(--border); box-shadow: 0 0 40px rgba(159,18,18,0.2);">
                    <img src="{{ asset('images/AMS_Logo.png') }}"
                         alt="AMS Logo"
                         class="w-12 h-12 object-contain">
                </div>
            </div>
            <h1 class="text-2xl font-extrabold tracking-tight" style="color: var(--text-primary);">JOY JEFFREY</h1>
            <p class="text-xs font-bold tracking-widest uppercase mt-0.5" style="color: #9f1212;">AUTO SUPPLY MANAGEMENT SYSTEM</p>
            <p class="text-xs mt-1" style="color: var(--text-muted);">Batangas State University ARASOF-Nasugbu</p>
        </div>

        <!-- Auth Card -->
        <div class="p-8 rounded-3xl shadow-2xl backdrop-blur-xl"
             style="background: var(--bg-surface); border: 1px solid var(--border);">
            {{ $slot }}
        </div>
    </div>

    <script>
        /* ── Dark / Light mode toggle (guest) ────────────── */
        const gHtml     = document.documentElement;
        const gBtn      = document.getElementById('guest-theme-toggle');
        const gIconDark = document.getElementById('g-icon-dark');
        const gIconLight= document.getElementById('g-icon-light');

        function gApplyTheme(mode) {
            if (mode === 'dark') {
                gHtml.classList.add('dark');
                gIconLight.classList.remove('hidden');
                gIconDark.classList.add('hidden');
            } else {
                gHtml.classList.remove('dark');
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
