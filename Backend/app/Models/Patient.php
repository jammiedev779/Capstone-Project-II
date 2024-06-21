<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Patient extends Model
{
    use HasFactory;

    protected $fillable = [
        'phone_number', 'first_name', 'last_name', 'age', 'gender', 'address', 'email', 'emergency_contact', 'status'
    ];
}
