<?php

namespace App\Filament\Resources\HospitalDetailResource\Pages;

use App\Filament\Resources\HospitalDetailResource;
use Filament\Resources\Pages\Page;
use Illuminate\Support\Facades\Redirect;
use Illuminate\Support\Facades\Auth;
use DB;

class RedirectHospital extends Page
{
    protected static string $resource = HospitalDetailResource::class;

    protected static string $view = 'filament.resources.hospital_detail-resource.pages.redirect-hospital';

    public function mount()
    {
        $user = Auth::user();
        $hospital = DB::table('hospital_details')->where('admin_id', $user->id)->first();
        if ($hospital) {
            return redirect()->to(static::getResource()::getUrl('edit', ['record' => $hospital->id]));
        } else {
            return redirect()->back();
        }
    }
}
