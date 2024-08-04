<?php

namespace App\Policies;

use App\Models\User;
use Spatie\Permission\Models\Role;
use App\Services\PermissionService;
use Illuminate\Auth\Access\Response;

class RolePolicy
{
    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[0]) || $user->hasRole('super_admin');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[1]) || $user->hasRole('super_admin');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[2]) || $user->hasRole('super_admin');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[3]) || $user->hasRole('super_admin');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[4]) || $user->hasRole('super_admin');
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[5]) || $user->hasRole('super_admin');
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Role')[6]) || $user->hasRole('super_admin');
    }
}
