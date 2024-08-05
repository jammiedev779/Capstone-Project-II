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
    public function register(Request $request)
    {
        $validatePatient = Validator::make($request->all(), [
            'name' => 'nullable',   
            'phone_number' => 'nullable',   
            'address' => 'nullable',
            'gender' => 'nullable',
            'age' => 'nullable',         
            'email' => 'required',
            'password' => 'required',
        ]);

        if ($validatePatient->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'validation error',
                'errors' => $validatePatient->errors()
            ]);
        }

        $patient = Patient::create([
            'name' => $request->name,
            'email' => $request->email,
            'phone_number' => $request->phone_number,
            'gender' => $request->gender,
            'address' => $request->address,
            'age' => $request->age,
            'password' => Hash::make($request->password),
        ]);

        $token = $patient->createToken('authToken')->plainTextToken;

        return response()->json([
            'status' => true,
            'message' => 'Patient registered successfully',
            'patient_id' => $patient->id,
            'token' => $token,
            'data' => $patient
        ]);
    }

    public function login(Request $request)
    {
        $validateLogin = Validator::make($request->all(), [
            'phone_number' => 'required',
            'password' => 'required',
        ]);

        if ($validateLogin->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validation error',
                'errors' => $validateLogin->errors()
            ]);
        }

        $patient = Patient::where('phone_number', $request->phone_number)->first();

        if (!$patient || !Hash::check($request->password, $patient->password)) {
            return response()->json([
                'status' => false,
                'message' => 'Invalid credentials',
            ], 401);
        }

        $token = $patient->createToken('authToken')->plainTextToken;

        return response()->json([
            'status' => true,
            'message' => 'Patient logged in successfully',
            'patient_id' => $patient->id,
            'token' => $token,
            'data' => $patient
        ]);
    }

    public function profile()
    {
        $patient = auth()->user();
        return response()->json([
            'status' => true,
            'message' => 'Profile Information',
            'data' => $patient,
            'id' => $patient->id
        ], 200);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();

        return response()->json([
            'status' => true,
            'message' => 'Patient logged out successfully'
        ]);
    }

    public function updateProfile(Request $request)
    {
        $patient = auth()->user();

        $validatePatient = Validator::make($request->all(), [
            'name' => 'nullable',   
            'phone_number' => 'nullable',   
            'address' => 'nullable',
            'gender' => 'nullable',
            'age' => 'nullable',
            'email' => 'nullable|email',
            'password' => 'nullable',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

     
        if ($validatePatient->fails()) {
            return response()->json([
                'status' => false,
                'message' => 'Validation error',
                'errors' => $validatePatient->errors()
            ]);
        }

        if ($request->hasFile('image')) {
        
            if ($patient->image) {
                Storage::delete($patient->image);
            }

            $imagePath = $request->file('image')->store('images');

            $patient->image = $imagePath;
        }

        $patient->update([
            'name' => $request->name ?? $patient->name,
            'email' => $request->email ?? $patient->email,
            'phone_number' => $request->phone_number ?? $patient->phone_number,
            'gender' => $request->gender ?? $patient->gender,
            'address' => $request->address ?? $patient->address,
            'age' => $request->age ?? $patient->age,
            'password' => $request->password ? Hash::make($request->password) : $patient->password,
        ]);

        return response()->json([
            'status' => true,
            'message' => 'Profile updated successfully',
            'data' => $patient
        ]);
    }
}