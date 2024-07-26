<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class Patient extends Model
{
    use HasFactory;

    protected $table = "patients";
    protected $fillable = [
        'first_name', 'last_name', 'phone_number', 'email', 'password',
    ];

    protected $hidden = [
        'password', 'remember_token',
    ];

    public function getAuthPassword()
    {
        return $this->password;
    }
    CONST ACTIVE = 1;
    const INACTIVE = 0;

    public function getStatusAttribute($value)
    {
        switch ($value) {
            case 0:
                return "Inactive";
            case 1:
                return "Active";
        }
    }

    public function access_patient_medical()
    {
        return $this->hasMany(AccessPatientMedical::class);
    }
}