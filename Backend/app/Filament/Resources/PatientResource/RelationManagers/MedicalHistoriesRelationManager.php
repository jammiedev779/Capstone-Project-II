<?php

namespace App\Filament\Resources\PatientResource\RelationManagers;

use DB;
use Filament\Forms;
use Filament\Tables;
use App\Models\Doctor;
use Filament\Forms\Form;
use Filament\Tables\Table;
use App\Models\HospitalDetail;
use App\Models\MedicalHistory;
use App\Models\Prescription;
use Filament\Forms\Components\Group;
use Illuminate\Support\Facades\Auth;
use Filament\Forms\Components\Select;
use Filament\Forms\Components\Repeater;
use Filament\Forms\Components\Textarea;
use Filament\Forms\Components\TextInput;
use Filament\Forms\Components\DatePicker;
use Filament\Forms\Components\Section;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Database\Eloquent\SoftDeletingScope;
use Filament\Resources\RelationManagers\RelationManager;
use Filament\Tables\Columns\TextColumn;

class MedicalHistoriesRelationManager extends RelationManager
{
    protected static string $relationship = 'medical_histories';

    public function form(Form $form): Form
    {
        $prescriptions = [];
        if ($form->getOperation() != "create") {
            foreach ($form->getRecord()->prescription as $item) {
                array_push($prescriptions, [
                    'medicine_name' => $item['medicine_name'],
                    'duration'      => $item['duration'],
                    'description'   => $item['description']
                ]);
            }
        }


        return $form
            ->schema([
                Group::make()
                    ->schema([
                        Group::make()
                            ->schema([
                                Select::make('doctor_id')
                                    ->options(function () {
                                        $user = Auth::user();
                                        if (!$user->is_superadmin) {
                                            $hospital_id = HospitalDetail::select('id')->where('admin_id', $user->id)->first()->id;
                                            return Doctor::where('hospital_id', $hospital_id)
                                                ->select(DB::raw("CONCAT(first_name, ' ', last_name) AS full_name"), 'id')
                                                ->pluck('full_name', 'id');
                                        } else {
                                            return Doctor::select(DB::raw("CONCAT(first_name, ' ', last_name) AS full_name"), 'id')
                                                ->pluck('full_name', 'id');
                                        }
                                    }),
                            ])->columns(2)->columnSpanFull(),
                        Textarea::make('diagnosis')->required(),
                        Textarea::make('treatment')->required(),
                        DatePicker::make('visit_date')->required(),
                        DatePicker::make('follow_up_date')->required(),
                        Textarea::make('note')->columnSpanFull(),
                        Section::make("")
                            ->schema([
                                Repeater::make('prescriptions')
                                    ->default($prescriptions)
                                    ->schema([
                                        TextInput::make('medicine_name')
                                            ->required()
                                            ->label('Medicine Name'),
                                        TextInput::make('duration')
                                            ->required()
                                            ->label('Duration'),
                                        Textarea::make('description')
                                            ->label('Description')
                                            ->columnSpanFull(),
                                    ])->columnSpanFull()->columns(2),
                            ])
                    ])->columns(2)->columnSpanFull()
            ]);
    }

    public function table(Table $table): Table
    {
        return $table
            ->recordTitleAttribute('patient_id')
            ->columns([
                TextColumn::make('patient_name')
                    ->label('Patient')
                    ->default(fn ($record) => ($record->patient->first_name ?? "") . ' ' . ($record->patient->last_name ?? ""))
                    ->searchable(),
                TextColumn::make('doctor_name')
                    ->label('Doctor')
                    ->default(fn ($record) => ($record->doctor->first_name ?? "") . ' ' . ($record->doctor->last_name ?? ""))
                    ->searchable(),
                TextColumn::make('visit_date')->date(),
                TextColumn::make('follow_up_date')->date(),
            ])
            ->filters([
                //
            ])
            ->headerActions([
                Tables\Actions\CreateAction::make()->label('Add New Medical Record'),
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
}
