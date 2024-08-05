<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FavoriteHospital extends Model
{

    use HasFactory;

    protected $table = 'favorite_hospitals';

    protected $fillable = [
        'patient_id',
        'hospital_id',
        'status'
    ];
    
    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }

    public function hospital()
    {
        return $this->belongsTo(HospitalDetail::class);
    }
}