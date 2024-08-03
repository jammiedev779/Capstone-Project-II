<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Doctor extends Model
{
    use HasFactory;
    protected $table = "doctors";
    protected $fillable = [
        'hospital_id', 'specialist_id', 'department_id',
        'first_name', 'last_name', 'gender', 'address', 'phone_number', 'status'
    ];

    public function hospital()
    {
        return $this->belongsTo(HospitalDetail::class, 'hospital_id');
    }
    public function specialist()
    {
        return $this->belongsTo(Specialist::class, 'specialist_id');
    }

    public function department()
    {
        return $this->belongsTo(Department::class, 'department_id');
    }

    public function getGenderAttribute($value){
        switch($value){
            case 0: return "Male";
            case 1: return "Female";
        }
    }
}