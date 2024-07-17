<?php

namespace App\Filament\Resources;

use Str;
use Filament\Forms;
use App\Models\Role;
use Filament\Tables;
use Filament\Forms\Get;
use Filament\Forms\Set;
use Filament\Forms\Form;
use Filament\Tables\Table;
use Filament\Actions\Action;
use App\Services\PanelService;
use Filament\Resources\Resource;
use Filament\Forms\Components\Tabs;
use Filament\Forms\Components\Group;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Section;
use Filament\Forms\Components\Checkbox;
use Filament\Forms\Components\Fieldset;
use Filament\Forms\Components\Tabs\Tab;
use Filament\Tables\Columns\IconColumn;
use Filament\Tables\Columns\TextColumn;
use Filament\Forms\Components\TextInput;
use Illuminate\Database\Eloquent\Builder;
use Filament\Forms\Components\CheckboxList;
use App\Filament\Resources\RoleResource\Pages;
use Spatie\Permission\Models\Role as ModelsRole;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use App\Filament\Resources\RoleResource\RelationManagers;

class RoleResource extends Resource
{
    protected static ?string $model = ModelsRole::class;

    protected static ?string $navigationIcon = 'heroicon-o-lock-open';

    public static function getNavigationGroup(): ?string
    {
        $get = PanelService::get_panel_order('Role');
        return __($get['group_name']);
    }
    public static function getNavigationSort(): ?int
    {
        $get = PanelService::get_panel_order('Role');

        return $get['sort'];
    }


    public static function form(Form $form): Form
    {
        $panel_groups = PanelService::get_panel_group();
        $render_panel_groups = [];

        // $options = [
        //     'viewAny' => 'View List', 'create' => 'Create', 'view'    => 'View',
        //     'update'  => 'Update'   , 'delete' => 'Delete', 'restore' => 'Restore', 'forceDelete' => 'Force Delete'
        // ];
        $options = [
            'viewAny' => 'View List', 'create' => 'Create', 'view'    => 'View',
            'update'  => 'Update', 'delete' => 'Delete'
        ];

        $dashboard_permissions = [
            'goal' => 'Goal', 'editGoal' => 'Update Goal', 'netRevenue' => 'Net Revenue', 'gap' => 'Gap',
            'yearPerformance' => 'Year Performance', 'monthPerformance' => 'Monthly Performance',
            'saleStatusPerformance' => 'Sale Status Performance',
        ];

        foreach ($panel_groups as $panel_group => $panel_items) {
            $render_panel_items  = [];
            foreach ($panel_items as $panel_item) {
                //convert to "text_text" format
                $panel_item_format = Str::of($panel_item)->snake();

                $tmp_options = $options;
                if ($panel_item_format == 'sale_managements') {
                    $tmp_options['issueQuote'] = 'Issue Quote';
                } else if ($panel_item_format == 'quotations') {
                    $tmp_options['requestApproval'] = 'Request Approval';
                    $tmp_options['issueInvoice'] = 'Issue Invoice';
                    $tmp_options['print'] = 'Print';
                    $tmp_options['approve'] = 'Approve Quote';
                } else if ($panel_item_format == 'invoices') {
                    $tmp_options['requestApproval'] = 'Request Approval';
                    $tmp_options['print'] = 'Print';
                    $tmp_options['approve'] = 'Approve Invoice';
                }

                $columns = sizeof($tmp_options);
                if (sizeof($tmp_options) > 7) {
                    $columns = 5;
                }

                //render each panel accordingly to the panel group               
                $render_panel_item = Fieldset::make($panel_item . ' Panel')
                    ->schema([
                        CheckboxList::make($panel_item_format)->label('')
                            ->options(
                                $panel_item_format == "dashboards" ? $dashboard_permissions : $tmp_options
                            )
                            ->bulkToggleable()
                            ->columns($columns)
                    ])->columns(1);
                array_push($render_panel_items, $render_panel_item);
            }

            $render_panel_group = Tab::make($panel_group)
                ->badge(sizeof($render_panel_items))
                ->schema([
                    Group::make()
                        ->schema($render_panel_items)
                ]);
            array_push($render_panel_groups, $render_panel_group);
        }

        return $form
            ->schema([
                TextInput::make('name')
                    ->unique(ignoreRecord: true),
                TextInput::make('guard_name')
                    ->default('web'),
                Checkbox::make('is_admin')
                    ->label('Make this role an admin')
                    ->live(),
                Section::make('Panel Group')
                    ->hidden(fn (Get $get) => $get('is_admin') == true)
                    ->schema([
                        Tabs::make('Tabs')
                            ->tabs($render_panel_groups),
                    ]),

                Select::make('permissions')
                    ->relationship('permissions', 'name')
                    ->multiple()
                    ->preload()
                    ->hidden(),
            ]);
    }

    public static function table(Table $table): Table
    {
        return $table
            ->columns([
                TextColumn::make('name')->searchable(),
                TextColumn::make('guard_name'),
                IconColumn::make('status')
                    ->icon(function ($record) {
                        return $record['status'] == 0 ? 'heroicon-o-x-circle' : 'heroicon-o-check-circle';
                    })
                    ->color(function ($record) {
                        return $record['status'] == 0 ? 'danger' : 'success';
                    })
            ])
            ->filters([
                //
            ])
            ->actions([
                
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
            'index' => Pages\ListRoles::route('/'),
            'create' => Pages\CreateRole::route('/create'),
            'edit' => Pages\EditRole::route('/{record}/edit'),
        ];
    }
}
