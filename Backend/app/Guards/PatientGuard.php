<?php
namespace App\Guards;

use Illuminate\Contracts\Auth\UserProvider;
use Illuminate\Session\SessionManager;
use Illuminate\Auth\TokenGuard;

class PatientGuard extends TokenGuard
{
    public function __construct(UserProvider $provider, SessionManager $session)
    {
        parent::__construct($provider, $session);
    }
}