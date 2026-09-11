<x-guest-layout>
    <!-- Session Status -->
    <x-auth-session-status class="mb-4" :status="session('status')" />

    <div class="mb-6">
        <h2 class="text-lg font-bold" style="color: var(--text-primary);">System Sign In</h2>
        <p class="text-xs mt-0.5" style="color: var(--text-muted);">Enter your shop username or email to access POS and Inventory</p>
    </div>

    <form method="POST" action="{{ route('login') }}" class="space-y-4">
        @csrf

        <!-- Username or Email -->
        <div>
            <label for="email" class="block text-xs font-bold uppercase tracking-wider mb-1.5" style="color: var(--text-secondary);">
                Username or Email
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none" style="color: var(--text-muted);">
                    <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/></svg>
                </div>
                <input
                    id="email"
                    type="text"
                    name="email"
                    value="{{ old('email', 'jared') }}"
                    required
                    autofocus
                    autocomplete="username"
                    placeholder="e.g. jared"
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
                    value="password"
                    required
                    autocomplete="current-password"
                    placeholder="••••••••"
                    class="w-full pl-10 pr-4 py-2.5 rounded-xl text-sm transition"
                    style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-primary); outline: none;"
                    onfocus="this.style.borderColor='#9f1212'; this.style.boxShadow='0 0 0 2px rgba(159,18,18,0.15)';"
                    onblur="this.style.borderColor='var(--border)'; this.style.boxShadow='none';"
                >
            </div>
            <x-input-error :messages="$errors->get('password')" class="mt-1.5 text-xs" style="color: #9f1212;" />
        </div>

        <!-- Remember & Forgot Password -->
        <div class="flex items-center justify-between pt-1">
            <label for="remember_me" class="inline-flex items-center cursor-pointer">
                <input id="remember_me" type="checkbox"
                       class="w-4 h-4 rounded"
                       style="accent-color: #9f1212;"
                       name="remember">
                <span class="ms-2 text-xs" style="color: var(--text-muted);">Remember session</span>
            </label>

            @if (Route::has('password.request'))
                <a class="text-xs font-semibold transition"
                   style="color: #9f1212;"
                   onmouseover="this.style.color='#7f0c0c';"
                   onmouseout="this.style.color='#9f1212';"
                   href="{{ route('password.request') }}">
                    Forgot password?
                </a>
            @endif
        </div>

        <!-- Submit Button -->
        <div class="pt-2">
            <button id="login-submit-btn"
                    type="submit"
                    class="w-full py-3 rounded-xl font-extrabold text-sm uppercase tracking-wider text-white transition-all duration-150"
                    style="background: linear-gradient(135deg, #9f1212 0%, #7f0c0c 100%); box-shadow: 0 4px 20px rgba(159,18,18,0.35);"
                    onmouseover="this.style.boxShadow='0 6px 24px rgba(159,18,18,0.5)';"
                    onmouseout="this.style.boxShadow='0 4px 20px rgba(159,18,18,0.35)';">
                Log In to System
            </button>
        </div>

        <!-- Demo Credentials Box -->
        <div class="mt-4 p-3 rounded-xl text-[11px] space-y-1"
             style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-muted);">
            <div class="font-bold" style="color: var(--text-secondary);">Default Demo Logins:</div>
            <div class="flex justify-between">
                <span>Admin: <code style="color: #9f1212; font-weight: 700;">jared</code></span>
                <span>Password: <code style="color: #9f1212; font-weight: 700;">password</code></span>
            </div>
            <div class="flex justify-between">
                <span>Cashier: <code style="color: #9f1212; font-weight: 700;">joycashier</code></span>
                <span>Password: <code style="color: #9f1212; font-weight: 700;">password</code></span>
            </div>
        </div>
    </form>
</x-guest-layout>
