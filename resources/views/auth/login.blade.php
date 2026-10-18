<x-guest-layout>
    <!-- Session Status -->
    <x-auth-session-status class="mb-4" :status="session('status')" />

    <!-- Sleek Ferrari-Inspired Heading -->
    <div class="mb-8">
        <h2 class="text-3xl sm:text-4xl font-black uppercase tracking-tight"
            style="color: var(--text-primary); letter-spacing: -0.02em;">
            PLEASE LOG IN
        </h2>
        <p class="text-xs sm:text-sm mt-1.5 font-medium" style="color: var(--text-secondary);">
            Enter your username or email to access POS & Inventory
        </p>
    </div>

    <form method="POST" action="{{ route('login') }}" class="space-y-5">
        @csrf

        <!-- Username or Email Field -->
        <div>
            <label for="email"
                   class="block text-[11px] font-extrabold uppercase tracking-widest mb-2"
                   style="color: var(--text-secondary);">
                Username or Email
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                    </svg>
                </div>
                <input
                    id="email"
                    type="text"
                    name="email"
                    value="{{ old('email') }}"
                    required
                    autofocus
                    autocomplete="username"
                    placeholder="e.g. jared or admin@autosupply.ph"
                    class="w-full pl-11 pr-4 py-3 rounded-xl text-sm font-medium transition-all"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='var(--brand)'; this.style.boxShadow='0 0 0 3px var(--brand-glow)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('email')" class="mt-1.5 text-xs font-semibold" style="color: #ef4444;" />
        </div>

        <!-- Password Field -->
        <div>
            <div class="flex items-center justify-between mb-2">
                <label for="password"
                       class="block text-[11px] font-extrabold uppercase tracking-widest"
                       style="color: var(--text-secondary);">
                    Password
                </label>
                @if (Route::has('password.request'))
                    <a class="text-xs font-bold transition hover:underline"
                       style="color: var(--brand);"
                       href="{{ route('password.request') }}">
                        Forgot password?
                    </a>
                @endif
            </div>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                </div>
                <input
                    id="password"
                    type="password"
                    name="password"
                    required
                    autocomplete="current-password"
                    placeholder="••••••••••••"
                    class="w-full pl-11 pr-4 py-3 rounded-xl text-sm font-medium transition-all"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='var(--brand)'; this.style.boxShadow='0 0 0 3px var(--brand-glow)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('password')" class="mt-1.5 text-xs font-semibold" style="color: #ef4444;" />
        </div>

        <!-- Remember Session Checkbox -->
        <div class="flex items-center pt-1">
            <label for="remember_me" class="inline-flex items-center cursor-pointer select-none">
                <input id="remember_me" type="checkbox"
                       class="w-4 h-4 rounded transition cursor-pointer"
                       style="accent-color: var(--brand);"
                       name="remember">
                <span class="ms-2 text-xs font-semibold" style="color: var(--text-secondary);">Remember this device</span>
            </label>
        </div>

        <!-- Ferrari Crimson CTA Button -->
        <div class="pt-2">
            <button id="login-submit-btn"
                    type="submit"
                    class="w-full py-3.5 px-6 rounded-xl font-black text-sm uppercase tracking-widest text-white transition-all duration-200 cursor-pointer flex items-center justify-center space-x-2 shadow-lg"
                    style="background: linear-gradient(135deg, #dc2626 0%, #b91c1c 100%); box-shadow: 0 4px 25px rgba(220, 38, 38, 0.45);"
                    onmouseover="this.style.boxShadow='0 6px 30px rgba(220, 38, 38, 0.65)'; this.style.transform='translateY(-1px)';"
                    onmouseout="this.style.boxShadow='0 4px 25px rgba(220, 38, 38, 0.45)'; this.style.transform='translateY(0)';"
            >
                <span>LOG IN</span>
                <svg class="w-4 h-4 ml-1" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M14 5l7 7m0 0l-7 7m7-7H3"/>
                </svg>
            </button>
        </div>

        <!-- Register Link -->
        @if (Route::has('register'))
            <div class="text-center pt-4 border-t" style="border-color: var(--border);">
                <span class="text-xs" style="color: var(--text-muted);">Need an account?</span>
                <a class="text-xs font-extrabold ml-1 uppercase tracking-wider transition hover:underline"
                   style="color: var(--brand);"
                   href="{{ route('register') }}">
                    Register here
                </a>
            </div>
        @endif
    </form>
</x-guest-layout>
