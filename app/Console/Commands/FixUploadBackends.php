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

        $needsReset =
            !$localBackend ||
            DB::table('file_entries')
                ->whereNotNull('upload_type')
                ->whereNotIn('backend_id', $backendIds ?: [''])
                ->exists();

        if ($needsReset) {
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

        app(\Common\Settings\Settings::class)->loadSettings();

        $this->info(
            "Upload backend fixed. Local backend id: {$localBackend['id']}",
        );

        return self::SUCCESS;
    }
}
