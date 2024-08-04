<?php

namespace App\Filament\Resources\HospitalDetailResource\Pages;

use App\Filament\Resources\HospitalDetailResource;
use Filament\Actions;
use Filament\Resources\Pages\EditRecord;

class EditHospitalDetail extends EditRecord
{
    protected static string $resource = HospitalDetailResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\DeleteAction::make(),
        ];
    }
}
