<?php

namespace Tests\Unit;

use App\Models\AuditLog;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Carbon;
use Tests\TestCase;

class AuditLogUnitTest extends TestCase
{
    use RefreshDatabase;

    public function test_audit_log_record_helper_creates_entry_with_explicit_actor(): void
    {
        $log = AuditLog::record(
            tableName: 'products',
            action: 'UPDATE',
            recordId: 42,
            columnName: 'quantity',
            oldValue: '10',
            newValue: '5',
            changedBy: 'Admin Supervisor'
        );

        $this->assertDatabaseHas('audit_logs', [
            'grade_id' => $log->grade_id,
            'table_name' => 'products',
            'action' => 'UPDATE',
            'record_id' => 42,
            'column_name' => 'quantity',
            'old_value' => '10',
            'new_value' => '5',
            'changed_by' => 'Admin Supervisor',
        ]);

        $this->assertInstanceOf(Carbon::class, $log->changed_at);
    }

    public function test_audit_log_uses_authenticated_user_name_by_default(): void
    {
        $user = User::factory()->create(['username' => 'cashier_maria']);
        $this->actingAs($user);

        $log = AuditLog::record(
            tableName: 'products',
            action: 'POS_SALE',
            recordId: 10,
            columnName: 'quantity',
            oldValue: '20',
            newValue: '18'
        );

        $this->assertEquals('cashier_maria', $log->changed_by);
    }

    public function test_audit_log_falls_back_to_system_when_unauthenticated(): void
    {
        $log = AuditLog::record(
            tableName: 'products',
            action: 'SYSTEM_SYNC',
            recordId: 1
        );

        $this->assertEquals('System', $log->changed_by);
    }
}
