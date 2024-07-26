<?php

return [
    'defaults' => [
        'guard' => 'patient',
        'passwords' => 'patients',
    ],

    'guards' => [
        'patient' => [
            'driver' => 'patient',
            'provider' => 'patients',
        ],
    ],

    'providers' => [
        'patients' => [
            'driver' => 'eloquent',
            'model' => App\Models\Patient::class,
        ],
    ],

    'passwords' => [
        'patients' => [
            'provider' => 'patients',
            'table' => 'password_resets',
            'expire' => 60,
        ],
    ],
];