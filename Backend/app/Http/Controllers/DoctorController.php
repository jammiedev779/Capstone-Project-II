<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use Illuminate\Http\Response;

class DoctorController extends Controller
{
    public function index(Request $request)
    {
        $query = $request->query('query');
        
        if (!$query) {
            return response()->json(['doctors' => []], 200);
        }

        $doctors = Doctor::where('first_name', 'LIKE', "%{$query}%")
            ->orWhere('last_name', 'LIKE', "%{$query}%")
            ->orWhere('address', 'LIKE', "%{$query}%")
            ->get(['first_name', 'last_name', 'phone_number', 'status', 'address']);

        return response()->json(['doctors' => $doctors], 200);
    }
}