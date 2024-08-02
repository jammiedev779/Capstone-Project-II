<?php

namespace App\Filament\Pages;

use Filament\Pages\Page;
use Illuminate\Support\Facades\Auth;
use Illuminate\Database\Eloquent\Builder;
use DB;

class Dashboard extends \Filament\Pages\Dashboard
{
    protected static ?string $navigationIcon = 'heroicon-o-home';

    protected static string $view = 'filament.pages.dashboard';

    public function mount()
    {

        $this->user = Auth::user();

        $this->admin_data = [
            'hospitals'         => DB::table('hospital_details')->get(),
            'patients'          => DB::table('patients')->get(),
            'active_patients'   => DB::table('patients')->where('status',1)->get(),
            'inactive_patients' => DB::table('patients')->where('status', 0)->get(),
            'appointments'      => DB::table('appointments')->get(),
        ];

        if (!$this->user->is_superadmin) {
            $hospital_id = DB::table('hospital_details')->where('admin_id', $this->user->id)->first()->id;

            $this->hospital_data = [
                'upcomming_appointments'        => DB::table('appointments')->where('status', 0)->where('hospital_id', $hospital_id)->get(),
                'ongoing_appointments'          => DB::table('appointments')->where('status', 1)->where('hospital_id', $hospital_id)->get(),
                'completed_appointments'        => DB::table('appointments')->where('status', 2)->where('hospital_id', $hospital_id)->get(),
                // 'canceled_appointments'         => DB::table('appointments')->where('status')->where('hospital_id', $hospital_id)->get(),
                'patients'                      => DB::table('patients')
                                                    ->join('access_patient_medicals', 'patients.id', '=', 'access_patient_medicals.patient_id')
                                                    ->where('patients.status', 1)
                                                    ->where('access_patient_medicals.admin_id', $this->user->id)
                                                    ->select('patients.*')
                                                    ->get(),
            ];
        }
    }
}
