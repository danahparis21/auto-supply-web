@extends('layouts.app')

@section('page_title', 'System Audit Trail')

@section('content')
<div class="space-y-6">

    <div class="p-4 rounded-2xl shadow-xl flex items-center justify-between"
         style="background: var(--bg-surface); border: 1px solid var(--border);">
        <div>
            <h3 class="text-base font-bold" style="color: var(--text-primary);">Database &amp; Inventory Activity Trail</h3>
            <p class="text-xs" style="color: var(--text-muted);">Automated event logging for inventory adjustments, sales, and catalog edits</p>
        </div>
        <span class="px-3 py-1 rounded-full text-xs font-mono-nums font-semibold"
              style="background: var(--bg-elevated); border: 1px solid var(--border); color: var(--text-secondary);">
            {{ $logs->total() }} Logged Events
        </span>
    </div>

    <!-- Audit Log Table -->
    <div class="rounded-2xl shadow-xl overflow-hidden"
         style="background: var(--bg-surface); border: 1px solid var(--border);">
        <div class="overflow-x-auto">
            <table class="w-full text-left text-xs font-mono-nums">
                <thead>
                    <tr class="uppercase tracking-wider font-semibold"
                        style="background: var(--bg-elevated); border-bottom: 1px solid var(--border); color: var(--text-muted);">
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
                <tbody class="divide-y" style="border-color: var(--border-subtle);">
                    @forelse($logs as $log)
                        <tr class="transition"
                            style="border-bottom: 1px solid var(--border-subtle);"
                            onmouseover="this.style.background='var(--bg-elevated)';"
                            onmouseout="this.style.background='transparent';">
                            <td class="py-3 px-4 font-bold" style="color: var(--text-muted);">#{{ $log->grade_id }}</td>
                            <td class="py-3 px-4" style="color: var(--text-secondary);">{{ $log->changed_at->format('Y-m-d H:i:s') }}</td>
                            <td class="py-3 px-4 font-sans">
                                @php
                                    $badgeClasses = match($log->action) {
                                        'CREATE'   => 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 border-emerald-500/30',
                                        'UPDATE'   => 'bg-blue-500/15 text-blue-700 dark:text-blue-400 border-blue-500/30',
                                        'DELETE'   => 'bg-red-500/15 text-red-700 dark:text-red-400 border-red-500/30',
                                        'RESTOCK'  => 'bg-emerald-500/15 text-emerald-700 dark:text-emerald-400 border-emerald-500/30',
                                        'POS_SALE' => 'bg-red-600/15 text-red-700 dark:text-red-400 border-red-500/30',
                                        default    => 'border'
                                    };
                                @endphp
                                <span class="px-2 py-0.5 rounded text-[10px] font-bold border {{ $badgeClasses }}"
                                      @if($log->action !== 'CREATE' && $log->action !== 'UPDATE' && $log->action !== 'DELETE' && $log->action !== 'RESTOCK' && $log->action !== 'POS_SALE')
                                      style="background: var(--bg-elevated); border-color: var(--border); color: var(--text-secondary);"
                                      @endif>
                                    {{ $log->action }}
                                </span>
                            </td>
                            <td class="py-3 px-4 font-bold" style="color: var(--text-secondary);">{{ $log->table_name }}</td>
                            <td class="py-3 px-4" style="color: var(--text-secondary);">{{ $log->record_id ?? 'N/A' }}</td>
                            <td class="py-3 px-4 font-semibold text-brand">{{ $log->column_name ?? 'Record' }}</td>
                            <td class="py-3 px-4 font-sans truncate max-w-xs" style="color: var(--text-muted);" title="{{ $log->old_value }}">
                                {{ $log->old_value ?? '—' }}
                            </td>
                            <td class="py-3 px-4 font-sans truncate max-w-xs font-semibold" style="color: var(--text-primary);" title="{{ $log->new_value }}">
                                {{ $log->new_value ?? '—' }}
                            </td>
                            <td class="py-3 px-4 font-sans font-bold" style="color: var(--text-primary);">{{ $log->changed_by ?? 'System' }}</td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="9" class="py-12 text-center font-sans" style="color: var(--text-muted);">No audit events recorded yet.</td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>

        <div class="p-4 font-sans" style="background: var(--bg-surface); border-top: 1px solid var(--border);">
            {{ $logs->links() }}
        </div>
    </div>
</div>
@endsection
