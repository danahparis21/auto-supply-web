<x-guest-layout>
    <!-- Session Status -->
    <x-auth-session-status class="mb-4" :status="session('status')" />

    <div class="mb-6">
        <h2 class="text-lg font-bold text-white">System Sign In</h2>
        <p class="text-xs text-slate-400">Enter your shop username or email to access POS and Inventory</p>
    </div>

    <form method="POST" action="{{ route('login') }}" class="space-y-4">
        @csrf

        <!-- Username or Email -->
        <div>
            <label for="email" class="block text-xs font-bold uppercase tracking-wider text-slate-300 mb-1.5">
                Username or Email
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-500">
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
                    class="w-full pl-10 pr-4 py-2.5 bg-slate-950 border border-slate-800 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 focus:ring-1 focus:ring-amber-500 transition"
                >
            </div>
            <x-input-error :messages="$errors->get('email')" class="mt-1.5 text-xs text-red-400" />
        </div>

        <!-- Password -->
        <div>
            <label for="password" class="block text-xs font-bold uppercase tracking-wider text-slate-300 mb-1.5">
                Password
            </label>
            <div class="relative">
                <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-500">
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
                    class="w-full pl-10 pr-4 py-2.5 bg-slate-950 border border-slate-800 rounded-xl text-sm text-white placeholder-slate-500 focus:outline-none focus:border-amber-500 focus:ring-1 focus:ring-amber-500 transition"
                >
            </div>
            <x-input-error :messages="$errors->get('password')" class="mt-1.5 text-xs text-red-400" />
        </div>

        <!-- Remember & Forgot Password -->
        <div class="flex items-center justify-between pt-1">
            <label for="remember_me" class="inline-flex items-center cursor-pointer">
                <input id="remember_me" type="checkbox" class="w-4 h-4 rounded bg-slate-950 border-slate-800 text-amber-500 focus:ring-amber-500 focus:ring-offset-slate-900" name="remember">
                <span class="ms-2 text-xs text-slate-400">Remember session</span>
            </label>

            @if (Route::has('password.request'))
                <a class="text-xs text-amber-400 hover:text-amber-300 transition" href="{{ route('password.request') }}">
                    Forgot password?
                </a>
            @endif
        </div>

        <!-- Submit Button -->
        <div class="pt-2">
            <button type="submit" class="w-full py-3 rounded-xl bg-gradient-to-r from-amber-500 to-orange-500 hover:from-amber-400 hover:to-orange-400 text-slate-950 font-extrabold text-sm uppercase tracking-wider shadow-lg shadow-amber-500/25 transition-all duration-150">
                Log In to System
            </button>
        </div>

        <!-- Quick Demo Credentials Box -->
        <div class="mt-4 p-3 rounded-xl bg-slate-950/60 border border-slate-800/80 text-[11px] text-slate-400 space-y-1">
            <div class="font-bold text-slate-300">Default Demo Logins:</div>
            <div class="flex justify-between">
                <span>Admin: <code class="text-amber-400 font-bold">jared</code></span>
                <span>Password: <code class="text-amber-400 font-bold">password</code></span>
            </div>
            <div class="flex justify-between">
                <span>Cashier: <code class="text-amber-400 font-bold">joycashier</code></span>
                <span>Password: <code class="text-amber-400 font-bold">password</code></span>
            </div>
        </div>
    </form>
</x-guest-layout>
