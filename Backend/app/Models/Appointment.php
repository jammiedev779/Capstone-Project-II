<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Appointment extends Model
{
    use HasFactory;
    protected $table = "appointments";
    protected $fillable = [
        'patient_id', 'doctor_id', 'location', 'appointment_date',
        'reason', 'status', 'user_status', 'doctor_status', 'note',
        'hospital_id'
    ];

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }
    public function doctor()
    {
        return $this->belongsTo(Doctor::class);
    }
    public function hospital()
    {
        return $this->belongsTo(HospitalDetail::class, 'hospital_id');
    }

    public function getUserStatusAttribute($value)
    {
        switch ($value) {
            case 0:
                return "Pending";
            case 1:
                return "Cancelled";
        }
    }
    public function getDoctorStatusAttribute($value)
    {
        switch ($value) {
            case 0:
                return "Pending";
            case 1:
                return "Accepted";
            case 2:
                return "Rejected";
        }
    }
    public function getStatusAttribute($value)
    {
        switch ($value) {
            case 0:
                return "Pending";
            case 1:
                return "Ongoing";
            case 2:
                return "Completed";
        }
    }
}
