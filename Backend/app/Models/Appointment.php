<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    use HasFactory;
    protected $table = "appointments";
    protected $fillable = [
        'patient_id', 'doctor_id', 'location','appointment_date', 'reason', 'status','user_status', 'doctor_status','note',
    ];

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }
    public function doctor()
    {
        return $this->belongsTo(Doctor::class);
    }

    public function getStatusAttribute($value) {
        switch($value){
            case 0: return "Pending";
            case 1: return "Accepted";
            case 2: return "Rejected";
            case 3: return "Completed";
            case 4: return "Cancelled";
        }
    }
}
