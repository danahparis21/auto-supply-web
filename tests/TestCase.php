<?php

namespace Tests;

use Illuminate\Foundation\Testing\TestCase as BaseTestCase;
use Illuminate\Support\Facades\DB;
use RuntimeException;

abstract class TestCase extends BaseTestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        $databaseName = DB::connection()->getDatabaseName();
        if ($databaseName === 'laravel') {
            throw new RuntimeException(
                "CRITICAL SAFETY ABORT: Tests are attempting to run against the development database '{$databaseName}'! ".
                "Tests must only run against 'testing' to prevent wiping out data."
            );
        }
    }
}
