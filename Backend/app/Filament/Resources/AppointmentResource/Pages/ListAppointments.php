<?php

namespace App\Filament\Resources\AppointmentResource\Pages;

use Filament\Actions;
use Filament\Resources\Pages\ListRecords;
use Filament\Resources\Pages\ListRecords\Tab;
use App\Filament\Resources\AppointmentResource;

class ListAppointments extends ListRecords
{
    protected static string $resource = AppointmentResource::class;

    protected function getHeaderActions(): array
    {
        return [

        ];
    }

    public function getTabs(): array
    {
        return [
            'All' => Tab::make(),
            'Pending' => Tab::make()->modifyQueryUsing(function ($query) {
                $query->where('status', 0);
            }),
            'Ongoing' => Tab::make()->modifyQueryUsing(function ($query) {
                $query->where('status', 1);
            }),
            'Completed' => Tab::make()->modifyQueryUsing(function ($query) {
                $query->where('status', 2);
            }),
        ];
    }
}
