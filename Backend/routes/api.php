<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\DoctorController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('patients',[PatientController::class,'index']);
Route::post('patients/login',[PatientController::class,'login']);
Route::post('patients/register',[PatientController::class,'register']);
Route::get('/patients/show/{id}', [PatientController::class, 'show']);
Route::post('patients/update/{id}',[PatientController::class,'update']);
Route::post('patients/delete/{id}',[PatientController::class,'delete']);


Route::get('/appointments', [AppointmentController::class, 'index']);
Route::post('/appointments/create', [AppointmentController::class, 'store']);
Route::get('/appointments/show/{id}', [AppointmentController::class, 'show']);
Route::post('/appointments/update/{id}', [AppointmentController::class, 'update']);
Route::post('/appointments/delete/{id}', [AppointmentController::class, 'destroy']);

Route::get('/doctors', [DoctorController::class, 'index']);
Route::post('/doctors/create', [DoctorController::class, 'store']);
Route::get('/doctors/show/{id}', [DoctorController::class, 'show']);
Route::post('/doctors/update/{id}', [DoctorController::class, 'update']);
Route::post('/doctors/delete/{id}', [DoctorController::class, 'destroy']);