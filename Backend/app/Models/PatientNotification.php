<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PatientNotification extends Model
{
    use HasFactory;
    protected $table = "patient_notifications";
    protected $fillable = [
        'patient_id', 'title', 'message', 'date', 'status'
    ];

    public function patient() 
    {
        return $this->belongsTo(Patient::class);
    }
}
