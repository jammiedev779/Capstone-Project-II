<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Patient;
use Illuminate\Support\Facades\Hash;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $request->validate([
            'phone_number' => 'required',
            'password' => 'required',
        ]);

        $credentials = [
            'phone_number' => $request->input('phone_number'),
            'password' => $request->input('password'),
        ];

        if (Auth::attempt($credentials)) {
            return response()->json([
                'status' => 200,
                'message' => 'Login successful',
                'patient' => Auth::Patient(),
            ]);
        }

        return response()->json([
            'status' => 401,
            'message' => 'Invalid credentials',
        ], 401);
    }
}