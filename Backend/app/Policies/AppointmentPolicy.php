<?php

namespace App\Policies;

use App\Models\Appointment;
use App\Models\User;
use App\Services\PermissionService;

class AppointmentPolicy
{
    public function viewAny(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[0]);
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[1]);
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[2]);
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[3]);
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[4]);
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[5]);
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user): bool
    {
        return $user->hasPermissionTo(PermissionService::returnMethod('Appointment')[6]);
    }
}