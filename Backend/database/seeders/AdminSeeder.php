<?php

namespace Database\Seeders;

use App\Models\Admin;
use Illuminate\Database\Seeder;

class AdminSeeder extends Seeder
{
    public function run()
    {
        Admin::create([
            'name' => 'Admin User',
            'email' => 'admin@example.com',
            'location' => 'Admin Location',
            'phone_number' => '123-456-7890',
            'password' => bcrypt('password'), // Use a secure password
        ]);
    }
}

