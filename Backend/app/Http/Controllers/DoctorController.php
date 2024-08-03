<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Doctor;
use Illuminate\Http\Response;

class DoctorController extends Controller
{
    public function index()
    {
        $doctors = Doctor::with(['hospital', 'specialist', 'department'])
            ->get(['id', 'first_name', 'last_name', 'phone_number', 'status', 'address', 'hospital_id', 'specialist_id', 'department_id']);

        $doctors = $doctors->map(function ($doctor) {
            return [
                'id' => $doctor->id,
                'first_name' => $doctor->first_name,
                'last_name' => $doctor->last_name,
                'phone_number' => $doctor->phone_number,
                'status' => $doctor->status,
                'address' => $doctor->address,
                'hospital_name' => $doctor->hospital->kh_name ?? null,
                'hospital_description' => $doctor->hospital->description ?? null,
                'specialist_title' => $doctor->specialist->title ?? null,
                'department_title' => $doctor->department->title ?? null,
            ];
        });

        return response()->json(['doctors' => $doctors], 200);
    }

    public function search(Request $request)
    {
        $query = $request->query('query');
        
        if (!$query) {
            return response()->json(['doctors' => []], 200);
        }

        // Eager load the relationships
        $doctors = Doctor::with(['hospital', 'specialist', 'department'])
            ->where(function ($queryBuilder) use ($query) {
                $queryBuilder->where('first_name', 'LIKE', "%{$query}%")
                             ->orWhere('last_name', 'LIKE', "%{$query}%")
                             ->orWhere('address', 'LIKE', "%{$query}%");
            })
            ->get(['id', 'first_name', 'last_name', 'phone_number', 'status', 'address', 'hospital_id', 'specialist_id', 'department_id',]);
    
        $doctors = $doctors->map(function ($doctor) {
            return [
                'id' => $doctor->id,
                'first_name' => $doctor->first_name,
                'last_name' => $doctor->last_name,
                'phone_number' => $doctor->phone_number,
                'status' => $doctor->status,
                'address' => $doctor->address,
                'hospital_name' => $doctor->hospital->kh_name ?? null,
                'hospital_description' => $doctor->hospital->description ?? null,
                'specialist_title' => $doctor->specialist->title ?? null,
                'department_title' => $doctor->department->title ?? null,
            ];
        });

        return response()->json(['doctors' => $doctors], 200);
    }
}