<?php

namespace App\Console\Commands;

use Common\Database\Seeders\UploadBackendsSeeder;
use Common\Settings\Models\Setting;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class FixUploadBackends extends Command
{
    protected $signature = 'app:fix-upload-backends';

    protected $description = 'Repair upload backend settings after APP_KEY or database import changes';

    public function handle(): int
    {
        $uploading = settings('uploading');
        $backendIds = collect($uploading['backends'] ?? [])->pluck('id')->all();
        $localBackend = collect($uploading['backends'] ?? [])->firstWhere(
            'type',
            'local',
        );

        if (!$localBackend) {
            Setting::where('name', 'uploading')->delete();
            (new UploadBackendsSeeder())->run();

            $uploading = settings('uploading');
            $backendIds = collect($uploading['backends'] ?? [])->pluck('id')->all();
            $localBackend = collect($uploading['backends'] ?? [])->firstWhere(
                'type',
                'local',
            );
        }

        if (!$localBackend) {
            $this->error('Could not create a local upload backend.');
            return self::FAILURE;
        }

        DB::table('file_entries')
            ->whereNotNull('upload_type')
            ->where(function ($query) use ($backendIds) {
                $query
                    ->whereNull('backend_id')
                    ->orWhereNotIn('backend_id', $backendIds ?: ['']);
            })
            ->update(['backend_id' => $localBackend['id']]);

        $admin = DB::table('users')->where('email', 'admin@admin.com')->first();
        if (
            $admin &&
            !DB::table('user_role')->where('user_id', $admin->id)->exists()
        ) {
            DB::table('user_role')->insert([
                'user_id' => $admin->id,
                'role_id' => 1,
                'created_at' => now(),
            ]);
        }

        $this->info(
            "Upload backend fixed. Local backend id: {$localBackend['id']}",
        );

        return self::SUCCESS;
    }
}
