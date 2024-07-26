<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use App\Models\Specialist;
use Filament\Tables\Table;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\SpecialistResource\Pages;
use App\Filament\Resources\SpecialistResource\RelationManagers;

class SpecialistResource extends Resource
{
    protected static ?string $model = Specialist::class;

    protected static ?string $navigationIcon = 'heroicon-o-rectangle-stack';

    public static function getNavigationGroup(): ?string
    {
        $get = PanelService::get_panel_order('Specialist');

        return __($get['group_name']);
    }
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('Specialist');

        return $get['sort'];
    }
    
    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                Forms\Components\TextInput::make('title')
                ->required()
                ->maxLength(255),
                Forms\Components\Toggle::make('status')->label('Active')->default(1),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                Tables\Columns\TextColumn::make('id')->sortable()->searchable()->alignment('center'),
                Tables\Columns\TextColumn::make('title')->sortable()->searchable()->alignment('center'),
                Tables\Columns\BooleanColumn::make('status')->sortable()->searchable()->alignment('center'),
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
            'index' => Pages\ListSpecialists::route('/'),
            'create' => Pages\CreateSpecialist::route('/create'),
            'view' => Pages\ViewSpecialist::route('/{record}'),
            'edit' => Pages\EditSpecialist::route('/{record}/edit'),
        ];
    }
}
