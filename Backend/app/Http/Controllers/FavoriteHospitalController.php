<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\FavoriteHospital;
use App\Models\HospitalDetail;
use Illuminate\Support\Facades\Auth;

class FavoriteHospitalController extends Controller
{
    public function addFavorite(Request $request, $patient_id)
    {
        $hospitalId = $request->input('hospital_id');

        $favorite = FavoriteHospital::firstOrCreate([
            'user_id' => $patient_id,
            'hospital_id' => $hospitalId,
        ]);

        return response()->json(['message' => 'Hospital added to favorites', 'favorite' => $favorite], 201);
    }

    public function removeFavorite(Request $request, $patient_id)
    {
        $hospitalId = $request->input('hospital_id');

        $favorite = FavoriteHospital::where('user_id', $patient_id)
            ->where('hospital_id', $hospitalId)
            ->first();

        if ($favorite) {
            $favorite->delete();
            return response()->json(['message' => 'Hospital removed from favorites'], 200);
        } else {
            return response()->json(['error' => 'Favorite hospital not found'], 404);
        }
    }

    public function showFavorite($patient_id, $hospital_id)
    {
        $favorite = FavoriteHospital::with('hospitalDetail')
            ->where('user_id', $patient_id)
            ->where('hospital_id', $hospital_id)
            ->first();

        if ($favorite) {
            return response()->json(['favoriteHospital' => $favorite->hospitalDetail], 200);
        } else {
            return response()->json(['error' => 'Favorite hospital not found'], 404);
        }
    }

    public function getFavoriteHospitals($patientId)
    {
        $favoriteHospitals = FavoriteHospital::with(['hospitalDetail'])
            ->where('user_id', $patientId)
            ->get()
            ->map(function ($favorite) {
                $hospitalDetail = $favorite->hospitalDetail;
                return [
                    'id' => $hospitalDetail->id,
                    'kh_name' => $hospitalDetail->kh_name,
                    'description' => $hospitalDetail->description,
                    'location' => $hospitalDetail->location,
                    'email' => $hospitalDetail->email,
                    'phone_number' => $hospitalDetail->phone_number,
                    'url' => $hospitalDetail->url,
                    'image' => $hospitalDetail->image,
                ];
            });

        return response()->json(['favoriteHospitals' => $favoriteHospitals], 200);
    }
}