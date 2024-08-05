<?php

namespace App\Filament\Resources;

use Filament\Forms;
use Filament\Tables;
use App\Models\Category;
use App\Models\Hospital;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Textarea;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\FileUpload;
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
                FileUpload::make('image')
                    ->label('Hospital Image')
                    ->image()
                    ->preserveFilenames()
                    ->directory('hospital_images/')
                    ->columnSpanFull(),
                TextInput::make('kh_name')->required(),
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
                Tables\Columns\TextColumn::make('No.')->state(
                    static function (Tables\Contracts\HasTable $livewire, \stdClass $rowLoop): string {
                        return (string) (
                            $rowLoop->iteration +
                            ($livewire->getTableRecordsPerPage() * (
                                $livewire->getTablePage() - 1
                            ))
                        );
                    }
                ),
                TextColumn::make('user.name')->label('Hospital Provider')->sortable()->searchable(),
                TextColumn::make('kh_name')->sortable()->searchable(),
                TextColumn::make('email')->searchable(),
                TextColumn::make('phone_number')->searchable(),
                TextColumn::make('created_at')->sortable()->searchable(),
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
