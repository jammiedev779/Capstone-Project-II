<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Patient;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Services\PanelService;
use Filament\Infolists\Infolist;
use Filament\Resources\Resource;
use Filament\Tables\Columns\TextColumn;
use Filament\Tables\Filters\SelectFilter;
use Illuminate\Database\Eloquent\Builder;
use Filament\Infolists\Components\TextEntry;
use App\Filament\Resources\PatientResource\Pages;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\PatientResource\RelationManagers;

class PatientResource extends Resource
{
    protected static ?string $model = Patient::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('Patient');

        return $get['sort'];
    }
    
    public static function form(Form $form): Form
    {
        return $form
            ->schema([]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->modifyQueryUsing(fn (Builder $query) => $query->whereHas('access_patient_medical', function (Builder $query) {
                $query->where('admin_id', auth()->user()->id);
            }))
            ->columns([
                TextColumn::make('first_name')->searchable(),
                TextColumn::make('last_name')->searchable(),
                TextColumn::make('phone_number')->searchable(),
                TextColumn::make('address')->searchable(),
                TextColumn::make('emergency_contact')->searchable(),
                TextColumn::make('status')
                    ->badge()
                    ->color(function ($record) {
                        switch ($record['status']) {
                            case "Active":
                                return "success";
                            case "Inactive":
                                return "gray";
                        }
                    }),
            ])
            ->filters([
            SelectFilter::make('status')
                ->options([
                    0 => 'Inactive',
                    1 => 'Active',
                ]),
            ])
            ->actions([
                // Tables\Actions\EditAction::make(),
                Tables\Actions\Action::make('activate')
                    ->visible(fn ($record) => $record['status'] == "Inactive")
                    ->action(function ($record) {
                        $record['status'] = 1;
                        $record->save();
                    })
                    ->button()
                    ->color('success'),
                Tables\Actions\Action::make('deactivate')
                    ->visible(fn ($record) => $record['status'] == "Active")
                    ->action(function ($record) {
                        $record['status'] = 0;
                        $record->save();
                    })
                    ->button()
                    ->color('Pending'),
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
            'index' => Pages\ListPatients::route('/'),
            // 'create' => Pages\CreatePatient::route('/create'),
            // 'edit' => Pages\EditPatient::route('/{record}/edit'),
            'view'  => Pages\ViewPatient::route('{record}/view'),
        ];
    }


    public static function infolist(Infolist $infolist): Infolist
    {
        return $infolist
            ->schema([
                TextEntry::make('first_name')->label('First Name'),
                TextEntry::make('last_name')->label('Last Name'),
                TextEntry::make('phone_number')->label('Phone Number'),
                TextEntry::make('age'),
                TextEntry::make('gender'),
                TextEntry::make('address'),
                TextEntry::make('emergency_contact')->label('Emergency Contact'),
                TextEntry::make('status'),
            ]);
    }
}
