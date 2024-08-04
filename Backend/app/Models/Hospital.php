<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Hospital extends Model
{
    use HasFactory;
    protected $table = "hospital_details";
    protected $fillable = [
        'admin_id', 'category_id', 'phone_number', 'kh_name', 'email',
        'description', 'location', 'contact_person_phone', 'url'
    ];


    public function user()
    {
        return $this->belongsTo(User::class, 'admin_id');
    }

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
}
