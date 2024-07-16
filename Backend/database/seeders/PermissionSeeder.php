<?php

namespace Database\Seeders;

use App\Services\PanelService;
use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Str;

class PermissionSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Spatie\Permission\Models\Permission::factory(10)->create();
        $panel_groups = PanelService::get_panel_group();

        $panels = [];
        foreach ($panel_groups as $panel_items) {
            $panels = array_merge($panels, $panel_items);
        }


        foreach ($panels as $panel) {
            Permission::createOrUpdate([
                'name' => 'viewAny ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
            Permission::createOrUpdate([
                'name' => 'create ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
            Permission::createOrUpdate([
                'name' => 'update ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
            Permission::createOrUpdate([
                'name' => 'view ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
            Permission::createOrUpdate([
                'name' => 'delete ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
            Permission::createOrUpdate([
                'name' => 'restore ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
            Permission::createOrUpdate([
                'name' => 'forceDelete ' . str_replace(' ', '', Str::singular($panel)),
                'guard_name' => 'web',
                'panel' => str_replace(' ', '', Str::singular($panel)),
            ]);
        }

    }
}
