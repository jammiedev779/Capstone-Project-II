<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FavoriteDoctor extends Model
{
    use HasFactory;

    protected $table = 'favorite_doctor';

    protected $fillable = [
        'patient_id',
        'doctor_id',
        'status'
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