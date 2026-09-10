<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('username')->nullable()->unique()->after('id');
            $table->string('fname')->nullable()->after('name');
            $table->string('mname')->nullable()->after('fname');
            $table->string('surname')->nullable()->after('mname');
            $table->string('contact_num')->nullable()->after('surname');
            $table->string('role')->default('admin')->after('contact_num');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn(['username', 'fname', 'mname', 'surname', 'contact_num', 'role']);
        });
    }
};
