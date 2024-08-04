<?php

namespace App\Policies;

use App\Models\User;
use App\Services\PermissionService;

class SpecialistPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[0]);
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[1]);
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[2]);
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[3]);
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[4]);
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[5]);
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user): bool
    {
        return $user->is_superadmin || $user->hasPermissionTo(PermissionService::returnMethod('Specialist')[6]);
    }
}
