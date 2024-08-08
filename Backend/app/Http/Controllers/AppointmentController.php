<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Appointment;
use App\Models\Doctor;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\DB; // Add this line

class AppointmentController extends Controller
{
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'doctor_id' => 'required|integer|exists:doctors,id',
            'patient_id' => 'required|integer|exists:patients,id',
            'appointment_date' => 'required|date|after:today',
            'location' => 'nullable|string|max:255',
            'status' => 'nullable|integer|in:0,1,2,3',
            'user_status' => 'nullable|integer|in:0,1', 
            'doctor_status' => 'nullable|integer|in:0,1,2',
            'reason' => 'required|string|max:255',
            'note' => 'nullable|string|max:500'
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }
    
        DB::beginTransaction();
        try {
            $doctor = Doctor::select('hospital_id')->whereId($request->doctor_id)->first();
            $appointment = new Appointment([
                'hospital_id'       => $doctor ? $doctor->hospital_id : null,
                'doctor_id'         => $request->doctor_id,
                'patient_id'        => $request->patient_id,
                'appointment_date'  => Carbon::parse($request->appointment_date),
                'location'          => $request->location,
                'status'            => $request->status ?? 0,
                'user_status'       => $request->user_status ?? 0, 
                'doctor_status'     => $request->doctor_status ?? 0, 
                'reason'            => $request->reason,
                'note'              => $request->note,
            ]);

            $appointment->save();
    
            DB::table('access_patient_medicals')->insert([
                'patient_id'        => $request->patient_id,
                'admin_id'          => $doctor->hospital->user->id ?? '1',
                'status'            => 1,
            ]);
    
            DB::commit();
    
            return response()->json([
                'status' => Response::HTTP_CREATED,
                'message' => 'Appointment created successfully',
                'appointment' => $appointment 
            ], Response::HTTP_CREATED);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to create appointment. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    

    public function appointmentHistory($patient_id)
    {
        $validator = Validator::make(['patient_id' => $patient_id], [
            'patient_id' => 'required|integer|exists:patients,id',
        ]);
    
        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }
    
        try {
            $appointments = Appointment::where('patient_id', $patient_id)
                ->with(['doctor.specialist']) // Ensure nested loading of the specialist relation
                ->get(['id','doctor_id', 'appointment_date', 'location', 'status', 'user_status', 'doctor_status', 'reason', 'note']);
    
    
            $appointmentData = $appointments->map(function ($appointment) {
    
                return [
                    'id' => $appointment->id,
                    'doctor_id' => $appointment->doctor_id,
                    'doctor_name' => $appointment->doctor->first_name . ' ' . $appointment->doctor->last_name,
                    'specialist_title' => $appointment->doctor->specialist->title ?? 'N/A',
                    'appointment_date' => $appointment->appointment_date->format('Y-m-d H:i:s'),
                    'location' => $appointment->location,
                    'status' => $appointment->status,
                    'user_status' => $appointment->user_status,
                    'doctor_status' => $appointment->doctor_status,
                    'reason' => $appointment->reason,
                    'note' => $appointment->note,
                ];
            });
    
            return response()->json([
                'status' => Response::HTTP_OK,
                'appointments' => $appointmentData,
            ], Response::HTTP_OK);
    
        } catch (\Exception $e) {
    
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to fetch appointments. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
    

    public function cancelAppointment(Request $request, $appointment_id)
    {
        $validator = Validator::make($request->all(), [
            'user_status' => 'required|integer|in:1', // 1 for "Canceled"
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        try {
            $appointment = Appointment::findOrFail($appointment_id);
            $appointment->user_status = $request->user_status; 
            $appointment->status = 3;
            $appointment->save();

            return response()->json([
                'status' => Response::HTTP_OK,
                'message' => 'Appointment canceled successfully',
                'appointment' => $appointment,
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            Log::error('Failed to cancel appointment: ' . $e->getMessage());

            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to cancel appointment. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}