<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Appointment;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;

class AppointmentController extends Controller
{
    public function store(Request $request)
    {
      
        $validator = Validator::make($request->all(), [
            'doctor_id' => 'required|integer|exists:doctors,id',
            'patient_id' => 'required|integer|exists:patients,id',
            'appointment_date' => 'required|date|after:today',
            'location' => 'nullable|string|max:255',
            'status' => 'nullable|integer|in:0,1,2',
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

        try {
            $appointment = new Appointment([
                'doctor_id' => $request->doctor_id,
                'patient_id' => $request->patient_id,
                'appointment_date' => Carbon::parse($request->appointment_date),
                'location' => $request->location,
                'status' => $request->status ?? 0,
                'user_status' => $request->user_status ?? 0, 
                'doctor_status' => $request->doctor_status ?? 0, 
                'reason' => $request->reason,
                'note' => $request->note,
            ]);

            $appointment->save();

            return response()->json([
                'status' => Response::HTTP_CREATED,
                'message' => 'Appointment created successfully',
                'appointment' => $appointment 
            ], Response::HTTP_CREATED);
        } catch (\Exception $e) {

            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to create appointment. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}