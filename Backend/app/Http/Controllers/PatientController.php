<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Patient;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
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
    public function register(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'nullable',
            'last_name' => 'nullable',
            'age' => 'nullable|integer',
            'gender' => 'nullable',
            'address' => 'nullable',
            'emergency_contact' => 'nullable',
            'phone_number' => 'required|unique:patients,phone_number',
            'password' => 'required|min:6',
            'email' => 'nullable|email|unique:patients,email',
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
        $patient->password = Hash::make($request->password);
        
        $patient->save();

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => "Created successfully",
        ], Response::HTTP_OK);
    }

    /**
     * Display the specified patient.
     */
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

    /**
     * Update the specified patient.
     */
    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(), [
            'first_name' => 'required',
            'last_name' => 'required',
            'age' => 'required|integer',
            'gender' => 'required',
            'address' => 'required',
            'emergency_contact' => 'required',
            'phone_number' => 'required|unique:patients,phone_number,' . $id,
            'email' => 'required|email|unique:patients,email,' . $id,
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

    /**
     * Remove the specified patient.
     */
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

    /**
     * Login a patient.
     */
    public function login(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'phone_number' => 'required',
            'password' => 'required|min:6',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        $patient = Patient::where('phone_number', $request->phone_number)->first();

        if (!$patient || !Hash::check($request->password, $patient->password)) {
            return response()->json([
                'status' => Response::HTTP_UNAUTHORIZED,
                'message' => 'Invalid credentials',
            ], Response::HTTP_UNAUTHORIZED);
        }

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => 'Login successful',
            'patient' => $patient,
        ], Response::HTTP_OK);
    }

    
}