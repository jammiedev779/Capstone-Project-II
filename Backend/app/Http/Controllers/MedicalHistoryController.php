<?php

namespace App\Http\Controllers;

use App\Models\MedicalHistory;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Illuminate\Support\Facades\Log;

class MedicalHistoryController extends Controller
{
    public function getMedical($patientId)
    {
        $validator = Validator::make(['patient_id' => $patientId], [
            'patient_id' => 'required|integer|exists:patients,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        try {
            $medicalHistories = MedicalHistory::where('patient_id', $patientId)
                ->with(['doctor:id,first_name,last_name', 'patient:id,name', 'prescription'])
                ->get(['patient_id', 'doctor_id', 'diagnosis', 'treatment', 'visit_date', 'note', 'follow_up_date']);

            $medicalHistories = $medicalHistories->map(function ($history) {
                return [
                    'patient_id' => $history->patient_id,
                    'patient_name' => $history->patient->name,
                    'doctor_id' => $history->doctor_id,
                    'doctor_firstName' => $history->doctor->first_name,
                    'doctor_lastName' => $history->doctor->last_name,
                    'diagnosis' => $history->diagnosis,
                    'treatment' => $history->treatment,
                    'visit_date' => $history->visit_date,
                    'note' => $history->note,
                    'follow_up_date' => $history->follow_up_date,
                    'prescriptions' => $history->prescription,
                ];
            });

            return response()->json([
                'status' => Response::HTTP_OK,
                'medical' => $medicalHistories,
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to fetch medical. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}