<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class AppointmentHistory extends Model
{
    use HasFactory;
    protected $table = "appointment_histories";
    protected $fillable = [
        
        'appointment_id', 'appointment_date', 'note'
    ];

    public function appointment()
    {
        return $this->belongsTo(Appointment::class);
    }
}
