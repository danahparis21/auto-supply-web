<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AuditLog extends Model
{
    use HasFactory;

    protected $primaryKey = 'grade_id';

    protected $fillable = [
        'table_name',
        'action',
        'record_id',
        'column_name',
        'old_value',
        'new_value',
        'changed_by',
        'changed_at',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'changed_at' => 'datetime',
        ];
    }

    /**
     * Helper to log audit changes.
     */
    public static function record(
        string $tableName,
        string $action,
        ?int $recordId = null,
        ?string $columnName = null,
        ?string $oldValue = null,
        ?string $newValue = null,
        ?string $changedBy = null
    ): self {
        return self::create([
            'table_name' => $tableName,
            'action' => $action,
            'record_id' => $recordId,
            'column_name' => $columnName,
            'old_value' => $oldValue,
            'new_value' => $newValue,
            'changed_by' => $changedBy ?? auth()->user()?->username ?? auth()->user()?->name ?? 'System',
            'changed_at' => now(),
        ]);
    }
}
