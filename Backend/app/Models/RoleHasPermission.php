<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Spatie\Permission\Models\Permission;

class RoleHasPermission extends Model
{
    use HasFactory;
    protected $table = "role_has_permissions";
    public $timestamps = false;
    protected $fillable = [
        'permission_id', 'role_id'
    ];

    public function permission(){
        return $this->belongsTo(Permission::class, 'permission_id');
    }
}
