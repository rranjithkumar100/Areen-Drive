<?php

namespace App\Console\Commands;

use Common\Settings\Models\Setting;
use Illuminate\Console\Command;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class FixStorageQuotas extends Command
{
    protected $signature = 'app:fix-storage-quotas {--bytes=10737418240 : Default available space in bytes}';

    protected $description = 'Repair accidentally tiny drive storage quota settings and permission restrictions';

    public function handle(): int
    {
        $targetBytes = (int) $this->option('bytes');

        if ($targetBytes <= 0) {
            $this->error('The --bytes option must be greater than zero.');
            return self::FAILURE;
        }

        Setting::updateOrCreate(
            ['name' => 'drive.default_available_space'],
            ['value' => (string) $targetBytes],
        );

        $updatedRestrictions = 0;

        DB::table('permissionables')
            ->join(
                'permissions',
                'permissions.id',
                '=',
                'permissionables.permission_id',
            )
            ->where('permissions.name', 'files.create')
            ->whereNotNull('permissionables.restrictions')
            ->select('permissionables.id', 'permissionables.restrictions')
            ->orderBy('permissionables.id')
            ->get()
            ->each(function ($row) use ($targetBytes, &$updatedRestrictions) {
                $restrictions = json_decode($row->restrictions, true);

                if (!is_array($restrictions)) {
                    return;
                }

                $changed = false;
                $restrictions = collect($restrictions)
                    ->map(function ($restriction) use ($targetBytes, &$changed) {
                        if (
                            Arr::get($restriction, 'name') ===
                                'max_space_usage' &&
                            is_numeric(Arr::get($restriction, 'value')) &&
                            (int) $restriction['value'] > 0 &&
                            (int) $restriction['value'] < $targetBytes
                        ) {
                            $restriction['value'] = $targetBytes;
                            $changed = true;
                        }

                        return $restriction;
                    })
                    ->values()
                    ->all();

                if ($changed) {
                    DB::table('permissionables')
                        ->where('id', $row->id)
                        ->update([
                            'restrictions' => json_encode($restrictions),
                        ]);
                    $updatedRestrictions++;
                }
            });

        Cache::forget('settings.public');
        app(\Common\Settings\Settings::class)->loadSettings();

        $this->info(
            sprintf(
                'Storage quota fixed. Default available space: %s bytes. Updated %s permission restriction row(s).',
                number_format($targetBytes),
                $updatedRestrictions,
            ),
        );

        return self::SUCCESS;
    }
}
