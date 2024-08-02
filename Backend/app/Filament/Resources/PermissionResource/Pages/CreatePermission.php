<?php

namespace App\Filament\Resources\PermissionResource\Pages;

use App\Filament\Resources\PermissionResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Database\Eloquent\Model;


class CreatePermission extends CreateRecord
{
    protected static string $resource = PermissionResource::class;

    protected function getRedirectUrl(): string
    {
        return $this->getResource()::getUrl('index');
    }

    protected function handleRecordCreation(array $data): Model
    {
        if ($data['action']) {
            foreach ($data['action'] as $action) {
                $insert = [];
                $insert['name']         = $action . " " . $data['panel'];
                $insert['panel']        = $data['panel'];
                $insert['guard_name']   = $data['guard_name'];
                $record =  static::getModel()::create($insert);
            }
        }

        if ($data['extra']) {
            foreach ($data['extra'] as $action) {
                $insert = [];
                $insert['name']         = $action . " " . $data['panel'];
                $insert['panel']        = $data['panel'];
                $insert['guard_name']   = $data['guard_name'];
                $record =  static::getModel()::create($insert);
            }
        }

        return $record;
    }
}
