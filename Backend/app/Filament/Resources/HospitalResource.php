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

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';
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
                Tables\Columns\TextColumn::make('id')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('kh_name')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('email')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('phone_number')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('description')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('location')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('created_at')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('updated_at')->sortable()->searchable()->alignment('center'),
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
