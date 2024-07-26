<?php

namespace App\Filament\Resources\RoleResource\Pages;

use DB;
use Str;
use Filament\Actions;
use App\Services\PanelService;
use App\Models\RoleHasPermission;
use Filament\Support\Enums\MaxWidth;
use Illuminate\Database\Eloquent\Model;
use App\Filament\Resources\RoleResource;
use Spatie\Permission\Models\Permission;
use Filament\Resources\Pages\CreateRecord;

class CreateRole extends CreateRecord
{
    protected static string $resource = RoleResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    public function getMaxContentWidth(): MaxWidth
    {
        return MaxWidth::Full;
    }

    protected function handleRecordCreation(array $data): Model
    {
        $record =  static::getModel()::create($data);

        if ($data['is_admin']) {
            $permissions = Permission::select('id')->get();
            foreach ($permissions as $permission) {
                RoleHasPermission::create(
                    [
                        'permission_id' => $permission['id'],
                        'role_id'       => $record['id'],
                    ]
                );
            }
        } else {
            $panel_groups = PanelService::get_panel_group();

            foreach ($panel_groups as $panels) {
                foreach ($panels as $panel) {
                    $panel_format = Str::of($panel)->snake();                 //convert to "text_text" format
                    if ($data[(string) $panel_format]) {
                        $permissions = Permission::select('id', 'name')->where('name', 'LIKE', '%' . Str::singular(Str::remove(' ', $panel)))->get();
                        foreach ($permissions as $permission) {
                            $permission_format = Str::remove(' ' . Str::singular(Str::remove(' ', $panel)), $permission['name']);
                            if (in_array($permission_format, $data[(string) $panel_format])) {
                                RoleHasPermission::create(
                                    [
                                        'permission_id' => $permission['id'],
                                        'role_id'       => $record['id'],
                                    ]
                                );
                            }
                        }
                    }
                }
            }
        }

        return $record;
    }
}
