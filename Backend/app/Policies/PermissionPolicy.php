<?php

namespace App\Policies;

use App\Models\User;
use App\Services\PermissionService;
use Illuminate\Auth\Access\Response;
use Spatie\Permission\Models\Permission;

class PermissionPolicy
{
    /**
     * Determine whether the user can view any models.
     */

    public function viewAny(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[0]);
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Permission $permission): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[1]);
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[2]);
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Permission $permission): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[3]);
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Permission $permission): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[4]);
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Permission $permission): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[5]);
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Permission $permission): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Permission')[6]);
    }
}
