<?php
namespace App\Providers;

use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Auth;
use App\Models\Patient;
use App\Guards\PatientGuard;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();

        Auth::extend('patient', function ($app, $name, array $config) {
            return new PatientGuard(
                $app['auth']->createUserProvider($config['provider']),
                $app['session.store']
            );
        });
    }
}