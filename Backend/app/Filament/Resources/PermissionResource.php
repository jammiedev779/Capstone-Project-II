<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Filament\Forms\Components\Fieldset;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TagsInput;
use Filament\Forms\Components\TextInput;
use Illuminate\Database\Eloquent\Builder;
use Filament\Forms\Components\CheckboxList;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\PermissionResource\Pages;
use Spatie\Permission\Models\Permission as ModelsPermission;
use App\Filament\Resources\PermissionResource\RelationManagers;

class PermissionResource extends Resource
{
    protected static ?string $model = ModelsPermission::class;

    protected static ?string $navigationIcon = 'heroicon-o-lock-closed';

    public static function getNavigationGroup(): ?string
    {
        $get = PanelService::get_panel_order('Permission');

        return __($get['group_name']);
    }
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('Permission');

        return $get['sort'];
    }

    public static function form(Form $form): Form
    {
        $col = 2;
        if ($form->getOperation() == "edit") {
            $col = 3;
        };
        return $form
            ->schema([
                TextInput::make('name')
                    ->label('Action')
                    ->visible(fn ($operation) => $operation == "edit"),
                TextInput::make('panel'),
                TextInput::make('guard_name')->default('web'),
                Fieldset::make('Actions')
                    ->visible(fn ($operation) => $operation == "create")
                    ->schema([
                        CheckboxList::make('action')
                            ->label('')
                            ->options([
                                'viewAny' => 'View List',
                                'create' => 'Create',
                                'view'    => 'View',
                                'update'  => 'Update',
                                'delete' => 'Delete',
                                'restore' => 'Restore',
                                'forceDelete' => 'Force Delete'
                            ])
                            ->columns(7)
                            ->columnSpanFull()
                            ->bulkToggleable(),
                        TagsInput::make('extra')
                            ->label('Additional Action')
                            ->placeholder('New action')
                    ])
            ])->columns($col);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('name')->searchable(),
                TextColumn::make('guard_name'),
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
            'index' => Pages\ListPermissions::route('/'),
            'create' => Pages\CreatePermission::route('/create'),
            'edit' => Pages\EditPermission::route('/{record}/edit'),
        ];
    }
}
