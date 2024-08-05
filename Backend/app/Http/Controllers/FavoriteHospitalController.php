<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\FavoriteHospital;
use App\Models\HospitalDetail;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class FavoriteHospitalController extends Controller
{
    public function addFavorite(Request $request, $patientId)
    {
        $validator = Validator::make($request->all(), [
            'hospital_id' => 'required|integer|exists:hospital_details,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        try {
            $favorite = FavoriteHospital::firstOrNew([
                'patient_id' => $patientId,
                'hospital_id' => $request->input('hospital_id'),
            ]);

            $favorite->status = true;
            $favorite->save();

            return response()->json([
                'status' => Response::HTTP_OK,
                'message' => 'Hospital added to favorites.',
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
            'hospital_id' => 'required|integer|exists:hospital_details,id',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => Response::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->messages(),
            ], Response::HTTP_UNPROCESSABLE_ENTITY);
        }

        try {
            $favorite = FavoriteHospital::where([
                'patient_id' => $patientId,
                'hospital_id' => $request->input('hospital_id'),
            ])->first();

            if ($favorite) {
                $favorite->status = false;
                $favorite->save();

                return response()->json([
                    'status' => Response::HTTP_OK,
                    'message' => 'Hospital removed from favorites.',
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

    public function showFavorite($patientId, $hospitalId)
    {
        try {
            $favoriteHospitals = FavoriteHospital::where([
                'patient_id' => $patientId,
                'hospital_id' => $hospitalId,
                'status' => true,
            ])->first();

            return response()->json([
                'status' => Response::HTTP_OK,
                'is_favorite' => $favoriteHospitals !== null,
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to check favorite status. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }


    public function getFavoriteHospitals($patientId)
    {
        try {
            $favoriteHospitals = FavoriteHospital::with('hospital')
                ->where('patient_id', $patientId)
                ->where('status', true)
                ->get()
                ->map(function ($favorite) {
                    $hospitalDetail = $favorite->hospital;
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

            return response()->json([               
                'status' => Response::HTTP_OK,
                'favoriteHospitals' => $favoriteHospitals,
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to load favorite hospitals. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}