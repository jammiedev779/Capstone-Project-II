<?php

namespace App\Filament\Resources\HospitalDetailResource\Pages;

use App\Filament\Resources\HospitalDetailResource;
use Filament\Actions;
use Filament\Resources\Pages\ListRecords;

class ListHospitalDetails extends ListRecords
{
    protected static string $resource = HospitalDetailResource::class;

    protected function getHeaderActions(): array
    {
        return [
            Actions\CreateAction::make(),
        ];
    }
}
