<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\Appointment;
use App\Services\PanelService;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;
use Filament\Infolists\Components\TextEntry;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\AppointmentResource\Pages;
use App\Filament\Resources\AppointmentResource\RelationManagers;

class AppointmentResource extends Resource
{
    protected static ?string $model = Appointment::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('Appointment');

        return $get['sort'];
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                //
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(fn (Builder $query) => $query->where('hospital_id', 1))
            ->columns([
                TextColumn::make('patient_name')
                    ->label('Patient')
                    ->default(fn ($record) => ($record->patient->first_name ?? "") . ' ' . ($record->patient->last_name ?? ""))
                    ->searchable(),
                TextColumn::make('doctor_name')
                    ->label('Doctor')
                    ->default(fn ($record) => ($record->doctor->first_name ?? "") . ' ' . ($record->doctor->last_name ?? ""))
                    ->searchable(),
                TextColumn::make('appointment_date')
                    ->date(),
                TextColumn::make('location'),
                TextColumn::make('user_status')
                    ->badge()
                    ->color(function ($record) {
                        switch ($record['user_status']) {
                            case "Pending":
                                return "Pending";
                            case "Cancelled":
                                return "Cancelled";
                        }
                    }),
                TextColumn::make('doctor_status')
                    ->badge()
                    ->color(function ($record) {
                        switch ($record['doctor_status']) {
                            case "Pending":
                                return "Pending";
                            case "Accepted":
                                return "Accepted";
                            case "Rejected":
                                return "Rejected";
                        }
                    }),
                TextColumn::make('status')
                    ->badge()
                    ->color(function ($record) {
                        switch ($record['status']) {
                            case "Pending":
                                return "Pending";
                            case "Ongoing":
                                return "Ongoing";
                            case "Completed":
                                return "success";
                        }
                    }),


            ])
            ->filters([
                SelectFilter::make('status')
                    ->options([
                        0 => 'Pending',
                        1 => 'Ongoing',
                        2 => 'Completed',
                    ]),
                SelectFilter::make('user_status')
                    ->options([
                        0 => 'Pending',
                        1 => 'Cancelled',
                    ]),
                SelectFilter::make('doctor_status')
                    ->options([
                        0 => 'Pending',
                        1 => 'Accepted',
                        2 => 'Rejected',
                    ]),

            ])
            ->actions([
                Tables\Actions\Action::make('Accept')
                    ->color('success')
                    ->button()
                    ->visible(function ($record, Tables\Contracts\HasTable $livewire) {
                        return $livewire->activeTab == 'Pending';
                    })
                    ->action(function ($record) {
                        $record['doctor_status'] = 1;
                        $record['status'] = 1;
                        $record->save();
                    }),
                Tables\Actions\Action::make('Reject')
                    ->color('danger')
                    ->button()
                    ->visible(function ($record, Tables\Contracts\HasTable $livewire) {
                        return $livewire->activeTab == 'Pending';
                    })
                    ->action(function ($record) {
                        $record['doctor_status'] = 2;
                        $record->save();
                    }),
                Tables\Actions\ViewAction::make(),
            ])
            ->bulkActions([
                Tables\Actions\BulkActionGroup::make([
                    Tables\Actions\DeleteBulkAction::make(),
                ]),
            ]);
    }

    public static function getRelations(): array
    {
        return [
            //
        ];
    }

    public static function getPages(): array
    {
        return [
            'index' => Pages\ListAppointments::route('/'),
            'create' => Pages\CreateAppointment::route('/create'),
            'view' => Pages\ViewAppointment::route('/{record}/view'),
        ];
    }

    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                TextEntry::make('patient_name')
                    ->label('Patient')
                    ->default(fn ($record) => ($record->patient->first_name ?? "") . ' ' . ($record->patient->last_name ?? "")),
                TextEntry::make('doctor_name')
                    ->label('Doctor')
                    ->default(fn ($record) => ($record->doctor->first_name ?? "") . ' ' . ($record->doctor->last_name ?? "")),
                TextEntry::make('appointment_date')->date(),
                TextEntry::make('reason'),
                TextEntry::make('location'),
                TextEntry::make('note'),
                TextEntry::make('status'),

            ]);
    }
}
