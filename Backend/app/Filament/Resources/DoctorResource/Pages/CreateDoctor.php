<?php

namespace App\Filament\Resources\DoctorResource\Pages;

use App\Filament\Resources\DoctorResource;
use Filament\Actions;
use Filament\Resources\Pages\CreateRecord;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use DB;

class CreateDoctor extends CreateRecord
{
    protected static string $resource = DoctorResource::class;

    protected function handleRecordCreation(array $data): Model
    {
        $user = Auth::user();
        $hospital = DB::table('hospital_details')->where('admin_id', $user->id)->first();
        $data['hospital_id'] = $hospital->id ?? null;
        $record =  static::getModel()::create($data);
        return $record;
    }
}
