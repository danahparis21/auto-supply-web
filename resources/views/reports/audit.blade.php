@extends('layouts.app')

@section('page_title', 'System Audit Trail')

@section('content')
<div class="space-y-6">

    <div class="p-4 rounded-2xl bg-slate-900 border border-slate-800 shadow-xl flex items-center justify-between">
        <div>
            <h3 class="text-base font-bold text-white">Database & Inventory Activity Trail</h3>
            <p class="text-xs text-slate-400">Automated event logging for inventory adjustments, sales, and catalog edits</p>
        </div>
        <span class="px-3 py-1 rounded-full bg-slate-800 border border-slate-700 text-xs font-mono-nums text-slate-300">
            {{ $logs->total() }} Logged Events
        </span>
    </div>

    <!-- Audit Log Table -->
    <div class="rounded-2xl bg-slate-900 border border-slate-800 shadow-xl overflow-hidden">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-xs font-mono-nums">
                <thead>
                    <tr class="uppercase tracking-wider text-slate-400 border-b border-slate-800 bg-slate-950/40">
                        <th class="py-3 px-4">Log #</th>
                        <th class="py-3 px-4">Timestamp</th>
                        <th class="py-3 px-4">Action</th>
                        <th class="py-3 px-4">Target Table</th>
                        <th class="py-3 px-4">Record ID</th>
                        <th class="py-3 px-4">Modified Attribute</th>
                        <th class="py-3 px-4 font-sans">Old Value</th>
                        <th class="py-3 px-4 font-sans">New Value</th>
                        <th class="py-3 px-4 font-sans">Changed By</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-800/60">
                    @forelse($logs as $log)
                        <tr class="hover:bg-slate-800/40 transition">
                            <td class="py-3 px-4 text-slate-500 font-bold">#{{ $log->grade_id }}</td>
                            <td class="py-3 px-4 text-slate-300">{{ $log->changed_at->format('Y-m-d H:i:s') }}</td>
                            <td class="py-3 px-4 font-sans">
                                @php
                                    $badgeClasses = match($log->action) {
                                        'CREATE' => 'bg-emerald-500/20 text-emerald-400 border-emerald-500/30',
                                        'UPDATE' => 'bg-blue-500/20 text-blue-400 border-blue-500/30',
                                        'DELETE' => 'bg-red-500/20 text-red-400 border-red-500/30',
                                        'RESTOCK' => 'bg-emerald-500/20 text-emerald-400 border-emerald-500/30',
                                        'POS_SALE' => 'bg-amber-500/20 text-amber-400 border-amber-500/30',
                                        default => 'bg-slate-800 text-slate-300 border-slate-700'
                                    };
                                @endphp
                                <span class="px-2 py-0.5 rounded text-[10px] font-bold border {{ $badgeClasses }}">
                                    {{ $log->action }}
                                </span>
                            </td>
                            <td class="py-3 px-4 text-slate-400 font-bold">{{ $log->table_name }}</td>
                            <td class="py-3 px-4 text-slate-300">{{ $log->record_id ?? 'N/A' }}</td>
                            <td class="py-3 px-4 text-amber-400">{{ $log->column_name ?? 'Record' }}</td>
                            <td class="py-3 px-4 font-sans text-slate-400 truncate max-w-xs" title="{{ $log->old_value }}">
                                {{ $log->old_value ?? '—' }}
                            </td>
                            <td class="py-3 px-4 font-sans text-slate-200 truncate max-w-xs font-semibold" title="{{ $log->new_value }}">
                                {{ $log->new_value ?? '—' }}
                            </td>
                            <td class="py-3 px-4 font-sans font-bold text-white">{{ $log->changed_by ?? 'System' }}</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="9" class="py-12 text-center text-slate-500 font-sans">No audit events recorded yet.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <div class="p-4 border-t border-slate-800 bg-slate-900/80 font-sans">
            {{ $logs->links() }}
        </div>
    </div>
</div>
@endsection
