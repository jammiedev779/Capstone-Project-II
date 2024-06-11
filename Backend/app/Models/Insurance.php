<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Insurance extends Model
{
    use HasFactory;
    protected $table = "insurances";
    protected $fillable = [
        'patient_id', 'insurance_company', 'policy_number', 'couverage_details',
        'expiry_date', 'status'
    ]; 

    public function patient()
    {
        return $this->belongsTo(Patient::class);
    }
}
