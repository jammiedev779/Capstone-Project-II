<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Patient;
use Illuminate\Support\Facades\Validator;
use Illuminate\Http\Response;

class PatientController extends Controller
{
    /**
     * Display a listing of patients.
     */
    public function index()
    {
        $patients = Patient::all();

        return response()->json([
            'status' => Response::HTTP_OK,
            'patients' => $patients,
        ], Response::HTTP_OK);
    }

    /**
     * Store a newly created patient.
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required',
            'last_name' => 'required',
            'age' => 'required|integer',
            'gender' => 'required',
            'address' => 'required',
            'emergency_contact' => 'required|nullbale',
            'phone_number' => 'required',
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $patient = new Patient($request->only([
            'first_name', 'last_name', 'age', 'gender', 'address',
            'emergency_contact', 'phone_number', 'email'
        ]));
        
        $patient->save();

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => "Created successfully",
        ], Response::HTTP_OK);
    }

    
    public function show($id)
    {
        $patient = Patient::find($id);

        if (!$patient) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => 'Patient not found',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json([
            'status' => Response::HTTP_OK,
            'patient' => $patient,
        ], Response::HTTP_OK);
    }

 

    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required',
            'last_name' => 'required',
            'age' => 'required|integer',
            'gender' => 'required',
            'address' => 'required',
            'emergency_contact' => 'required',
            'phone_number' => 'required',
            'email' => 'required|email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $patient = Patient::find($id);

        if (!$patient) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => 'Patient not found',
            ], Response::HTTP_NOT_FOUND);
        }

        $patient->update($request->only([
            'first_name', 'last_name', 'age', 'gender', 'address',
            'emergency_contact', 'phone_number', 'email'
        ]));

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => "Updated successfully",
        ], Response::HTTP_OK);
    }

    public function delete($id)
    {
        $patient = Patient::find($id);

        if (!$patient) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => 'Patient not found',
            ], Response::HTTP_NOT_FOUND);
        }

        $patient->delete();

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => "Deleted successfully",
        ], Response::HTTP_OK);
    }
}
