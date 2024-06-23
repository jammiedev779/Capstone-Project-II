<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Appointment;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class AppointmentController extends Controller
{
    public function index(Request $request)
    {
        $query = Appointment::query();

        if ($request->has('doctor_id')) {
            $query->where('doctor_id', $request->doctor_id);
        }

        if ($request->has('patient_id')) {
            $query->where('patient_id', $request->patient_id);
        }

        if ($request->has('date')) {
            $query->where('appointment_date', $request->date);
        }

        if ($request->has('user_status')) {
            $query->where('user_status', $request->user_status);
        }

        if ($request->has('doctor_status')) {
            $query->where('doctor_status', $request->doctor_status);
        }

        $appointments = $query->with(['patient', 'doctor'])->get();

        return response()->json([
            'status' => Response::HTTP_OK,
            'appointments' => $appointments,
        ], Response::HTTP_OK);
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'doctor_id' => 'required|integer|exists:doctors,id',
            'patient_id' => 'required|integer|exists:patients,id',
            'appointment_date' => 'required|date',
            'location' => 'required|string',
            'status' => 'nullable',
            'user_status' => 'required|string',
            'doctor_status' => 'required|string',
            'reason' => 'required|string',
            'note' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $appointment = new Appointment($request->all());
        $appointment->save();

        return response()->json([
            'status' => Response::HTTP_CREATED,
            'message' => 'Appointment created successfully',
            'appointment' => $appointment,
        ], Response::HTTP_CREATED);
    }

    public function show($id)
    {
        $appointment = Appointment::with(['patient', 'doctor'])->find($id);

        if (!$appointment) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => 'Appointment not found',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json([
            'status' => Response::HTTP_OK,
            'appointment' => $appointment,
        ], Response::HTTP_OK);
    }

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'doctor_id' => 'required|integer|exists:doctors,id',
            'patient_id' => 'required|integer|exists:patients,id',
            'appointment_date' => 'required|date',
            'location' => 'required|string',
            'status' => 'nullable',
            'user_status' => 'required|string',
            'doctor_status' => 'required|string',
            'reason' => 'required|string',
            'note' => 'nullable|string'
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $appointment = Appointment::find($id);

        if (!$appointment) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => 'Appointment not found',
            ], Response::HTTP_NOT_FOUND);
        }

        $appointment->update($request->all());

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => 'Appointment updated successfully',
            'appointment' => $appointment,
        ], Response::HTTP_OK);
    }

    public function destroy($id)
    {
        $appointment = Appointment::find($id);

        if (!$appointment) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => 'Appointment not found',
            ], Response::HTTP_NOT_FOUND);
        }

        $appointment->delete();

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => 'Appointment deleted successfully',
        ], Response::HTTP_OK);
    }
}

