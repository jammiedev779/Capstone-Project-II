<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHospitalsTable extends Migration
{
    public function up()
    {
        Schema::create('hospitals', function (Blueprint $table) {
            $table->id();
            $table->foreignId('admin_id')->nullable()->constrained('user_admins'); // Replace 'user_admins' with your actual admins table name
            $table->foreignId('category_id')->nullable()->constrained('categories'); // Replace 'categories' with your actual categories table name
            $table->string('phone_number')->nullable();
            $table->string('kh_name')->nullable();
            $table->string('email')->nullable();
            $table->string('description')->nullable();
            $table->string('location')->nullable();
            $table->string('contact_person_phone')->nullable();
            $table->string('url')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('hospitals');
    }
}
