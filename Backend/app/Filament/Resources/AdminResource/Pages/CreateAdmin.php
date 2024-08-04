<?php

namespace App\Filament\Resources\AdminResource\Pages;

use App\Filament\Resources\AdminResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Database\Eloquent\Model;
use DB;

class CreateAdmin extends CreateRecord
{
    protected static string $resource = AdminResource::class;

    protected function afterCreate() {
        $id = $this->record->id;
        DB::table('hospital_details')->insert([
            'admin_id'      => $id,
        ]);
    }

    protected function beforeDelete() {
        $id = $this->record->id;
        DB::table('hospital_details')->where('admin_id', $id)->first()->delete();
    }
}