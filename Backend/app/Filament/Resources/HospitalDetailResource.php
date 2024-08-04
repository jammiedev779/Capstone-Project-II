<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\HospitalDetail;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\HospitalDetailResource\Pages;
use App\Filament\Resources\HospitalDetailResource\RelationManagers;

class HospitalDetailResource extends Resource
{
    protected static ?string $model = HospitalDetail::class;

    public static function getNavigationIcon(): ?string
    {
        $panel = explode('\\', self::$model);

        return PanelService::get_panel_icon($panel[2]);
    }
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('HospitalDetail');

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
                //
            ])
            ->filters([
                //
            ])
            ->actions([
                Tables\Actions\EditAction::make(),
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
            'index' => Pages\RedirectHospital::route('/'),
            'create' => Pages\CreateHospitalDetail::route('/create'),
            'edit' => Pages\EditHospitalDetail::route('/{record}/edit'),
        ];
    }
}
