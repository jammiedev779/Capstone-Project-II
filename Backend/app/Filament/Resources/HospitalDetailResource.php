<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Category;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\HospitalDetail;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\FileUpload;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\HospitalDetailResource\Pages;
use App\Filament\Resources\HospitalDetailResource\RelationManagers;
use Filament\Forms\Components\Textarea;

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
                FileUpload::make('image')->label('Hospital Image')->image()->required()->columnSpanFull(),
                TextInput::make('kh_name')->label('Name KH')->required(),
                Select::make('category_id')
                    ->label('Category')
                    ->options(Category::all()->pluck('name', 'id'))
                    ->required(),
                TextInput::make('email')->email()->required(),
                TextInput::make('phone_number'),
                TextInput::make('location'),
                TextInput::make('url')->label('Link'),
                Textarea::make('description')->columnSpanFull(),
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
