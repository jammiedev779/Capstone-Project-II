<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('departments', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('admin_notifications', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('specialists', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('patients', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('doctors', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('patient_notifications', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('insurances', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
        Schema::table('access_patient_medicals', function (Blueprint $table) {
            $table->string('status')->default('null')->change();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
   
    }
};
