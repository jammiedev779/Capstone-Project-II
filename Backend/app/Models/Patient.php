<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Patient extends Model
{
    use HasFactory;

    protected $table = "patients";
    protected $fillable = [
        'phone_number', 'first_name', 'last_name', 'age', 'gender', 'address', 'email', 'emergency_contact', 'status'
    ];

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
