<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class MedicalHistory extends Model
{
    use HasFactory;
    protected $table = "medical_histories";
    protected $fillable = [
        'patient_id', 'doctor_id', 'diagnosis', 'treatment', 'visit_date', 'note',
        'follow_up_date'
    ];

    public function patient() 
    {
        return $this->belongsTo(Patient::class);
    }

    public function doctor()
    {
        return $this->belongsTo(Doctor::class);
    }
}


