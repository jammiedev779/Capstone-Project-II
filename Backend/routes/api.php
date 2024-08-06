<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PatientController;
use App\Http\Controllers\AppointmentController;
use App\Http\Controllers\DoctorController;
use App\Http\Controllers\MedicalHistoryController;
use App\Http\Controllers\HospitalDetailController;
use App\Http\Controllers\FavoriteDoctorController;
use App\Http\Controllers\FavoriteHospitalController;



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
Route::get('/hospital_details/{id}', [HospitalDetailController::class, 'show']);

//Medical history
Route::get('/medical_history/{patientId}', [MedicalHistoryController::class, 'getMedical']);

Route::post('/favorites/add/{patient_id}', [FavoriteDoctorController::class, 'addFavorite']);
Route::post('/favorites/remove/{patient_id}', [FavoriteDoctorController::class, 'removeFavorite']);
Route::get('/favorites/show/{patient_id}/{doctor_id}', [FavoriteDoctorController::class, 'showFavorite']);
Route::get('/favorites/{patientId}', [FavoriteDoctorController::class, 'getFavoriteDoctors']);

Route::post('/favorite_hospital/add/{patient_id}', [FavoriteHospitalController::class, 'addFavorite']);
Route::post('/favorite_hospital/remove/{patient_id}', [FavoriteHospitalController::class, 'removeFavorite']);
Route::get('/favorite_hospital/show/{patient_id}/{hospital_id}', [FavoriteHospitalController::class, 'showFavorite']);
Route::get('/favorite_hospital/{patientId}', [FavoriteHospitalController::class, 'getFavoriteHospitals']);