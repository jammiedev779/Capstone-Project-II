<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Hospital;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Illuminate\Database\Eloquent\Builder;
use App\Filament\Resources\HospitalResource\Pages;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\HospitalResource\RelationManagers;

class HospitalResource extends Resource
{
    protected static ?string $model = Hospital::class;

    public static function getNavigationIcon(): ?string
    {
        $panel = explode('\\', self::$model);

        return PanelService::get_panel_icon($panel[2]);
    }
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('Hospital');

        return $get['sort'];
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('kh_name')->required(),
                Forms\Components\TextInput::make('email')->email()->required(),
                Forms\Components\TextInput::make('phone_number'),
                Forms\Components\TextInput::make('description'),
                Forms\Components\TextInput::make('location'),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('user.name')->label('Hospital Provider')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('kh_name')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('email')->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('phone_number')->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('description')->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('location')->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('created_at')->sortable()->searchable()->alignment('center'),
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\ViewAction::make(),
                Tables\Actions\EditAction::make(),
                Tables\Actions\DeleteAction::make(),
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
            'index' => Pages\ListHospitals::route('/'),
            'create' => Pages\CreateHospital::route('/create'),
            'view' => Pages\ViewHospital::route('/{record}'),
            'edit' => Pages\EditHospital::route('/{record}/edit'),
        ];
    }
}
