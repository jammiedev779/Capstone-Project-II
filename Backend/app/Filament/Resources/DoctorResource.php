<?php

namespace App\Filament\Resources;

use DB;
use Filament\Forms;
use Filament\Tables;
use App\Models\Doctor;
use Filament\Forms\Form;
use App\Models\Department;
use App\Models\Specialist;
use Filament\Tables\Table;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Filament\Forms\Components\Select;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Filament\Tables\Columns\ImageColumn;
use Filament\Forms\Components\FileUpload;
use Illuminate\Database\Eloquent\Builder;
use Filament\Tables\Columns\BooleanColumn;
use App\Filament\Resources\DoctorResource\Pages;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\DoctorResource\RelationManagers;

class DoctorResource extends Resource
{
    protected static ?string $model = Doctor::class;

    public static function getNavigationIcon(): ?string
    {
        $panel = explode('\\', self::$model);

        return PanelService::get_panel_icon($panel[2]);
    }

    public static function getNavigationSort(): ?int
    {
        $panel = explode('\\', self::$model);
        $get = PanelService::get_panel_order($panel[2]);

        return $get['sort'];
    }

    public static function form(Form $form): Form
    {
        return $form
            ->schema([
                FileUpload::make('image')->label('Profile Image')->columnSpanFull(),
                TextInput::make('first_name'),
                TextInput::make('last_name'),
                Select::make('gender')
                    ->options([
                        '0'  => 'Male',
                        '1' => 'Female'
                    ]),
                TextInput::make('phone_number')->tel()
                    ->telRegex('/^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\.\/0-9]*$/'),
                TextInput::make('address')->columnSpanFull(),
                Select::make('specialist_id')
                    ->label('Specialist')
                    ->options(fn () => Specialist::all()->pluck('title', 'id')),
                Select::make('department_id')
                    ->label('Department')
                    ->options(fn () => Department::all()->pluck('title', 'id')),

            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            // ->modifyQueryUsing(fn (Builder $query) => $query->where('hospital_id', DB::table('hospital_details')->where('admin_id', auth()->user()->id)->first()->id ?? null))
            ->columns([
                ImageColumn::make('image')
                    ->label('Profile')
                    ->circular(),
                TextColumn::make('first_name')->searchable(),
                TextColumn::make('last_name')->searchable(),
                TextColumn::make('gender')->searchable(),
                TextColumn::make('address')->searchable(),
                TextColumn::make('phone_number')->searchable(),
                TextColumn::make('specialist.title')->searchable(),
                TextColumn::make('department.title')->searchable(),
                BooleanColumn::make('status')->sortable(),

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
            'index' => Pages\ListDoctors::route('/'),
            'create' => Pages\CreateDoctor::route('/create'),
            'edit' => Pages\EditDoctor::route('/{record}/edit'),
        ];
    }
}
