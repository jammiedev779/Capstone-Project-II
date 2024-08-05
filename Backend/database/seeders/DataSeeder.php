<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Faker\Factory as Faker;
use Illuminate\Support\Facades\Hash;
use Str;

class DataSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $faker = Faker::create();
        $patients = [];
        $doctors = [];
        $appointments = [];
        $categories = [];
        $specialists  = [];
        $departments  = [];
        $hospitals  = [];

        $hospital_names = [
            'Royal Phnom Penh Hospital',
            'Angkor International Hospital',
            'Calmette Hospital',
            'Khmer-Soviet Friendship Hospital',
            'Sen Sok International University Hospital',
            'Preah Kossamak Hospital',
            'Sihanouk Hospital Center of HOPE',
            'Naga Clinic Hospital',
            'Sunrise Japan Hospital',
            'Angkor Children\'s Hospital'
        ];

        $hospital_names_kh = [
            'មន្ទីរពេទ្យរាជធានីភ្នំពេញ',
            'មន្ទីរពេទ្យអន្តរជាតិអង្គរ',
            'មន្ទីរពេទ្យកាល់ម៉ែត',
            'មន្ទីរពេទ្យមិត្តភាពខ្មែរសូវៀត',
            'មន្ទីរពេទ្យសកលវិទ្យាល័យអន្តរជាតិសែនសុខ',
            'មន្ទីរពេទ្យព្រះកុសមៈ',
            'មណ្ឌលសុខាភិបាលសីហនុមន្ទីរពេទ្យ HOPE',
            'មន្ទីរពេទ្យគ្លីនិកណាគា',
            'មន្ទីរពេទ្យសាន់រ៉ាយស ជប៉ុន',
            'មន្ទីរពេទ្យកុមារអង្គរ'
        ];

        $categories_list = [
            'Emergency Medicine',
            'Internal Medicine',
            'Surgery',
            'Pediatrics',
            'Obstetrics and Gynecology',
            'Cardiology',
            'Neurology',
            'Oncology',
            'Radiology',
            'Anesthesiology'
        ];

        $departments_list = [
            'Emergency Room (ER)',
            'Internal Medicine',
            'Surgery',
            'Pediatrics',
            'Obstetrics and Gynecology',
            'Cardiology',
            'Neurology',
            'Oncology',
            'Radiology',
            'Anesthesiology'
        ];

        $specialists_list = [
            'Emergency Room Physician',
            'Trauma Surgeon',
            'General Internist',
            'Endocrinologist',
            'General Surgeon',
            'Orthopedic Surgeon',
            'Pediatrician',
            'Pediatric Cardiologist',
            'Obstetrician',
            'Gynecologic Oncologist',
            'Cardiologist',
            'Interventional Cardiologist',
            'Neurologist',
            'Neurosurgeon',
            'Medical Oncologist',
            'Radiation Oncologist',
            'Diagnostic Radiologist',
            'Interventional Radiologist',
            'Anesthesiologist',
            'Pain Management Specialist'
        ];

        for ($i = 0; $i < 11; $i++) {
            $patients[] = [
                'first_name' => $faker->firstName,
                'last_name' => $faker->lastName,
                'gender' => $faker->randomElement(['M', 'F']),
                'address' => $faker->address,
                'phone_number' => $faker->phoneNumber,
                'dob' => $faker->date($format = 'Y-m-d', $max = 'now'),
                'emergency_contact' => $faker->phoneNumber,
                'status'    => 1,
                'image' => $faker->imageUrl(640, 480, 'hospital', true, 'Faker'),
            ];
        }

        for ($i = 0; $i < 11; $i++) {
            $doctors[] = [
                'hospital_id' => 1,
                'first_name' => $faker->firstName,
                'last_name' => $faker->lastName,
                'gender' => $faker->randomElement([0, 1]),
                'address' => $faker->address,
                'phone_number' => $faker->phoneNumber,
                'specialist_id' => $faker->numberBetween(1, 5),
                'department_id' => $faker->numberBetween(1, 5),
                'status'        => 1,
                'image' => $faker->imageUrl(640, 480, 'hospital', true, 'Faker'),
            ];
        }

        for ($i = 0; $i < 11; $i++) {
            $appointments[] = [
                'patient_id' => $faker->numberBetween(1, 10),
                'doctor_id' => $faker->numberBetween(1, 10),
                'location' => $faker->address,
                'user_status' => 0,
                'doctor_status' => 0,
                'status' => 0,
                'hospital_id'   => 1
            ];
        }

        foreach ($categories_list as $title) {
            $categories[] = [
                'name' => $title,
                'status' => 1,
            ];
        }

        foreach ($specialists_list as $title) {
            $specialists[] = [
                'title' => $title,
                'status' => 1,
            ];
        }

        foreach ($departments_list as $title) {
            $departments[] = [
                'title' => $title,
                'status' => 1,
            ];
        }

        for ($i = 0; $i < 10; $i++) {
            $hospitals[] = [
                'admin_id' => $i + 2,
                'kh_name' => $hospital_names_kh[$i],
                'category_id' => $faker->numberBetween(1, 10),
                'email' => Str::slug($hospital_names[$i], '.') . '@gamil.com',
                'phone_number' => $faker->phoneNumber,
                'location' => $faker->address,
                'url' => $faker->url,
                'image' => $faker->imageUrl(640, 480, 'hospital', true, 'Faker'),
            ];
        }


        if (DB::table('categories')->count() == 0) {
            DB::table('categories')->insert($categories);
        }
        if (DB::table('departments')->count() == 0) {
            DB::table('departments')->insert($specialists);
        }
        if (DB::table('specialists')->count() == 0) {
            DB::table('specialists')->insert($departments);
        }
        if (DB::table('patients')->count() == 0) {
            DB::table('patients')->insert($patients);
        }
        if (DB::table('hospital_details')->count() == 0) {
            DB::table('hospital_details')->insert($hospitals);
        }
        if (DB::table('doctors')->count() == 0) {
            DB::table('doctors')->insert($doctors);
        }
        if (DB::table('appointments')->count() == 0) {
            DB::table('appointments')->insert($appointments);
        }
        foreach ($hospital_names as $index => $user) {
            User::updateOrCreate(
                [
                    'email' => Str::slug($user, '.') . '@doccare.com',
                ],
                [
                    'id'    => $index + 2,
                    'name' => $user,
                    'hospital_id' => $index + 1,
                    'password' => Hash::make('12345678'),
                    'created_at' => now(),
                    'updated_at' => now(),
                ]
            );
        }
    }
}
