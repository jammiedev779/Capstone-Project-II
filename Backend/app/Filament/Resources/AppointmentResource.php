<?php

namespace App\Filament\Resources;

use App\Filament\Resources\AppointmentResource\Pages;
use App\Filament\Resources\AppointmentResource\RelationManagers;
use App\Models\Appointment;
use Filament\Forms;
use Filament\Forms\Form;
use Filament\Infolists\Components\TextEntry;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Table;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;

class AppointmentResource extends Resource
{
    protected static ?string $model = Appointment::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

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
                    ->default(fn ($record) => $record->patient->first_name . ' ' . $record->patient->last_name)
                    ->searchable(),
                TextColumn::make('doctor_name')
                    ->label('Doctor')
                    ->default(fn ($record) => $record->doctor->first_name . ' ' . $record->doctor->last_name)
                    ->searchable(),
                TextColumn::make('appointment_date')
                    ->date(),
                TextColumn::make('location'),
                TextColumn::make('user_status'),
                TextColumn::make('doctor_status'),
                TextColumn::make('status'),


            ])
            ->filters([
                //
            ])
            ->actions([
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
                    ->default(fn ($record) => $record->patient->first_name . ' ' . $record->patient->last_name),
                TextEntry::make('doctor_name')
                    ->label('Doctor')
                    ->default(fn ($record) => $record->doctor->first_name . ' ' . $record->doctor->last_name),
                TextEntry::make('appointment_date')->date(),
                TextEntry::make('reason'),
                TextEntry::make('location'),
                TextEntry::make('note'),
                TextEntry::make('status'),

            ]);
    }
}
