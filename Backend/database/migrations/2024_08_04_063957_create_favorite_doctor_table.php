<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateFavoriteDoctorTable extends Migration
{
    public function up()
    {
        Schema::create('favorite_doctor', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('patient_id');
            $table->unsignedBigInteger('doctor_id');
            $table->timestamps();

            // a patient can favorite a doctor only once
            $table->unique(['patient_id', 'doctor_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('favorite_doctor');
    }
}