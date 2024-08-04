<?php
namespace App\Http\Controllers;

use App\Models\FavoriteDoctor;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class FavoriteDoctorController extends Controller
{
    public function addFavorite(Request $request, $patientId)
{
    $validator = Validator::make($request->all(), [
        'doctor_id' => 'required|integer|exists:doctors,id',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
            'message' => $validator->messages(),
        ], Response::HTTP_UNPROCESSABLE_ENTITY);
    }

    try {
        $favorite = FavoriteDoctor::updateOrCreate(
            [
                'patient_id' => $patientId,
                'doctor_id' => $request->input('doctor_id'),
            ],
            [
                'status' => true,
            ]
        );

        return response()->json([
            'status' => Response::HTTP_OK,
            'message' => 'Doctor added to favorites.',
            'favorite' => $favorite,
        ], Response::HTTP_OK);
    } catch (\Exception $e) {
        return response()->json([
            'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
            'message' => 'Failed to add favorite. Please try again later.',
        ], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
}
public function removeFavorite(Request $request, $patientId)
{
    $validator = Validator::make($request->all(), [
        'doctor_id' => 'required|integer|exists:doctors,id',
    ]);

    if ($validator->fails()) {
        return response()->json([
            'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
            'message' => $validator->messages(),
        ], Response::HTTP_UNPROCESSABLE_ENTITY);
    }

    try {
        $favorite = FavoriteDoctor::where([
            'patient_id' => $patientId,
            'doctor_id' => $request->input('doctor_id'),
        ])->first();

        if ($favorite) {
            $favorite->update(['status' => false]);
            return response()->json([
                'status' => Response::HTTP_OK,
                'message' => 'Doctor removed from favorites.',
            ], Response::HTTP_OK);
        }

        return response()->json([
            'status' => Response::HTTP_NOT_FOUND,
            'message' => 'Favorite not found.',
        ], Response::HTTP_NOT_FOUND);
    } catch (\Exception $e) {
        return response()->json([
            'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
            'message' => 'Failed to remove favorite. Please try again later.',
        ], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
}
public function isFavorite($patientId, $doctorId)
{
    try {
        $isFavorite = FavoriteDoctor::where([
            'patient_id' => $patientId,
            'doctor_id' => $doctorId,
            'status' => true,
        ])->exists();

        return response()->json([
            'status' => Response::HTTP_OK,
            'is_favorite' => $isFavorite,
        ], Response::HTTP_OK);
    } catch (\Exception $e) {
        return response()->json([
            'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
            'message' => 'Failed to check favorite status. Please try again later.',
        ], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
}


}