<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\DoctorController;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('patients/register',[PatientController::class,'register']);
Route::post('patients/login',[PatientController::class,'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('patients/profile', [PatientController::class, 'profile']);
    Route::post('patients/logout',[PatientController::class,'logout']);
    Route::post('/patients/updateProfile', [PatientController::class, 'updateProfile']);
});




Route::get('/appointments', [AppointmentController::class, 'index']);
Route::post('/appointments/create', [AppointmentController::class, 'store']);
Route::get('/appointments/show/{id}', [AppointmentController::class, 'show']);
Route::post('/appointments/update/{id}', [AppointmentController::class, 'update']);
Route::post('/appointments/delete/{id}', [AppointmentController::class, 'destroy']);

Route::get('doctors', [DoctorController::class, 'index']);
Route::get('doctors/search', [DoctorController::class, 'search']);