<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AccessPatientMedical extends Model
{
    use HasFactory;
    protected $table = "access_patient_medicals";
    protected $fillable = [
        'admin_id', 'patient_id', 'status'
    ];

    public function user()
    {
        return $this->belongsTo(User::class, 'admin_id');
    }
    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }
}
