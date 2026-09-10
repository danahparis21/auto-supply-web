<?php

namespace App\Models;

use Database\Factories\ProductFactory;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class Product extends Model
{
    /** @use HasFactory<ProductFactory> */
    use HasFactory;

    protected $primaryKey = 'product_id';

    protected $fillable = [
        'product_name',
        'additional_name',
        'type',
        'brand',
        'price',
        'quantity',
        'location',
        'image',
        'description',
    ];

    /**
     * @return array<string, string>
     */
    protected function casts(): array
    {
        return [
            'price' => 'decimal:2',
            'quantity' => 'integer',
        ];
    }

    /**
     * @return HasMany<Sale, $this>
     */
    public function sales(): HasMany
    {
        return $this->hasMany(Sale::class, 'product_id', 'product_id');
    }

    /**
     * Scope for low stock products.
     *
     * @param  Builder<Product>  $query
     */
    public function scopeLowStock(Builder $query, int $threshold = 5): Builder
    {
        return $query->where('quantity', '<=', $threshold);
    }
}
