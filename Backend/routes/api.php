<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\MedicalHistoryController;
use App\Http\Controllers\HospitalDetailController;
use App\Http\Controllers\FavoriteDoctorController;



Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

//register and login for patient
Route::post('patients/register',[PatientController::class,'register']);
Route::post('patients/login',[PatientController::class,'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('patients/profile', [PatientController::class, 'profile']);
    Route::post('patients/logout',[PatientController::class,'logout']);
    Route::post('/patients/updateProfile', [PatientController::class, 'updateProfile']);
});


//appointmennt
Route::post('/appointments/booking', [AppointmentController::class, 'store']);
Route::get('/appointments/{patient_id}', [AppointmentController::class, 'appointmentHistory']);
Route::post('/appointments/cancel/{appointment_id}', [AppointmentController::class, 'cancelAppointment']);


//feature doctor    
Route::get('doctors', [DoctorController::class, 'index']);
Route::get('doctors/search', [DoctorController::class, 'search']);


Route::get('hospital_details/all', [HospitalDetailController::class, 'index']);
Route::get('hospital_details/search', [HospitalDetailController::class, 'search']);

//Medical history
Route::get('/medical_history/{patientId}', [MedicalHistoryController::class, 'getMedical']);

Route::post('/favorites/add/{patient_id}', [FavoriteDoctorController::class, 'addFavorite']);
Route::post('/favorites/remove/{patient_id}', [FavoriteDoctorController::class, 'removeFavorite']);
Route::get('/favorites/check/{patient_id}', [FavoriteDoctorController::class, 'isFavorite']);