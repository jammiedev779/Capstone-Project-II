<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Prescription extends Model
{
    use HasFactory;
    protected $table = "prescriptions";
    protected $fillable = [
        'medical_history_id', 'medicine_name', 'description', 'duration'
    ];

    public function medical_history()
    {
        return $this->belongsTo(MedicalHistory::class);
    }
}
