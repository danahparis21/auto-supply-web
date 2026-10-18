<x-guest-layout>
    <div class="mb-6">
        <h2 class="text-lg font-bold" style="color: var(--text-primary);">Create an Account</h2>
        <p class="text-xs mt-0.5" style="color: var(--text-muted);">Register your account to access POS and Inventory</p>
    </div>

    <form method="POST" action="{{ route('register') }}" class="space-y-4">
        @csrf

        <!-- Full Name -->
        <div>
            <label for="name" class="block text-xs font-bold uppercase tracking-wider mb-1.5" style="color: var(--text-secondary);">
                Full Name
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>
                </div>
                <input
                    id="name"
                    type="text"
                    name="name"
                    value="{{ old('name') }}"
                    required
                    autofocus
                    autocomplete="name"
                    placeholder="e.g. John Doe"
                    class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='#9f1212'; this.style.boxShadow='0 0 0 2px rgba(159,18,18,0.15)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('name')" class="mt-1.5 text-xs" style="color: #9f1212;" />
        </div>

        <!-- Username -->
        <div>
            <label for="username" class="block text-xs font-bold uppercase tracking-wider mb-1.5" style="color: var(--text-secondary);">
                Username
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M15.75 6a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0zM4.501 20.118a7.5 7.5 0 0114.998 0A17.933 17.933 0 0112 21.75c-2.676 0-5.216-.584-7.499-1.632z"/></svg>
                </div>
                <input
                    id="username"
                    type="text"
                    name="username"
                    value="{{ old('username') }}"
                    required
                    autocomplete="username"
                    placeholder="e.g. jdoe"
                    class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='#9f1212'; this.style.boxShadow='0 0 0 2px rgba(159,18,18,0.15)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('username')" class="mt-1.5 text-xs" style="color: #9f1212;" />
        </div>

        <!-- Email Address -->
        <div>
            <label for="email" class="block text-xs font-bold uppercase tracking-wider mb-1.5" style="color: var(--text-secondary);">
                Email Address
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"/></svg>
                </div>
                <input
                    id="email"
                    type="email"
                    name="email"
                    value="{{ old('email') }}"
                    required
                    autocomplete="email"
                    placeholder="e.g. john@autosupply.test"
                    class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='#9f1212'; this.style.boxShadow='0 0 0 2px rgba(159,18,18,0.15)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('email')" class="mt-1.5 text-xs" style="color: #9f1212;" />
        </div>

        <!-- Password -->
        <div>
            <label for="password" class="block text-xs font-bold uppercase tracking-wider mb-1.5" style="color: var(--text-secondary);">
                Password
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/></svg>
                </div>
                <input
                    id="password"
                    type="password"
                    name="password"
                    required
                    autocomplete="new-password"
                    placeholder="••••••••"
                    class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='#9f1212'; this.style.boxShadow='0 0 0 2px rgba(159,18,18,0.15)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('password')" class="mt-1.5 text-xs" style="color: #9f1212;" />
        </div>

        <!-- Confirm Password -->
        <div>
            <label for="password_confirmation" class="block text-xs font-bold uppercase tracking-wider mb-1.5" style="color: var(--text-secondary);">
                Confirm Password
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/></svg>
                </div>
                <input
                    id="password_confirmation"
                    type="password"
                    name="password_confirmation"
                    required
                    autocomplete="new-password"
                    placeholder="••••••••"
                    class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='#9f1212'; this.style.boxShadow='0 0 0 2px rgba(159,18,18,0.15)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('password_confirmation')" class="mt-1.5 text-xs" style="color: #9f1212;" />
        </div>

        <!-- Submit Button -->
        <div class="pt-2">
            <button id="register-submit-btn"
                    type="submit"
                    class="w-full py-3 rounded-xl font-extrabold text-sm uppercase tracking-wider text-white transition-all duration-150"
                    style="background: linear-gradient(135deg, #9f1212 0%, #7f0c0c 100%); box-shadow: 0 4px 20px rgba(159,18,18,0.35);"
                    onmouseover="this.style.boxShadow='0 6px 24px rgba(159,18,18,0.5)';"
                    onmouseout="this.style.boxShadow='0 4px 20px rgba(159,18,18,0.35)';">
                Register Account
            </button>
        </div>

        <div class="text-center pt-2">
            <span class="text-xs" style="color: var(--text-muted);">Already registered?</span>
            <a href="{{ route('login') }}" class="text-xs font-bold ml-1 transition" style="color: #9f1212;" onmouseover="this.style.color='#7f0c0c';" onmouseout="this.style.color='#9f1212';">
                Sign in here
            </a>
        </div>
    </form>
</x-guest-layout>
