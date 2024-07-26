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
use Filament\Resources\Pages\EditRecord;
use Spatie\Permission\Models\Permission;

class EditRole extends EditRecord
{
    protected static string $resource = RoleResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    public function getMaxContentWidth(): MaxWidth
    {
        return MaxWidth::Full;
    }

    protected function handleRecordUpdate(Model $record, array $data): Model
    {
        DB::table("role_has_permissions")->where('role_id', $record['id'])->delete();

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
                    //convert to "text_text" format
                    $panel_format = Str::of($panel)->snake();

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
        $record->update();
        return $record;
    }

    protected function mutateFormDataBeforeFill(array $data): array
    {
        $role_has_permissions = RoleHasPermission::where('role_id', $data['id'])->with(['permission' => function ($query) {
            $query->select('name', 'id');
        }])->get();
        if (Permission::count() == sizeof($role_has_permissions)) {
            $data['is_admin'] = true;
        }

        $panels = PanelService::get_panel_group();
        foreach ($panels as $panel_group => $panels_item) {
            foreach ($panels_item as $panel) {
                //initialize empty array to the form e.g $data['sale_managemens'] = []
                $data[(string) Str::of($panel)->snake()] = [];
            }
        }

        foreach ($role_has_permissions as $role_has_permission) {
            $splited = explode(' ', $role_has_permission->permission['name']);
            //$splited[0] is the method e.g 'view', 'create' etc...
            //$splited[1] is the model e.g 'SaleManagement' etc...

            //convert the model e.g 'SaleManagment' => 'sale_managements' 
            array_push($data[(string) Str::of(Str::plural($splited[1]))->snake()], $splited[0]);
        }
        return $data;
    }
}
