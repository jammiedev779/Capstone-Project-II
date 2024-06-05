<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = User::create([
            'name'     => 'Super Admin',
            'email'    => 'super_admin@beone.crm.com',
            'password' => bcrypt('12345678'),
        ]);

        $user->roles()->attach(1);
    }
}
