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
            $favorite = FavoriteDoctor::firstOrNew([
                'patient_id' => $patientId,
                'doctor_id' => $request->input('doctor_id'),
            ]);

            $favorite->status = true;
            $favorite->save();

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
                $favorite->status = false;
                $favorite->save();

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

    public function showFavorite($patientId, $doctorId)
    {
        try {
            $favorite = FavoriteDoctor::where([
                'patient_id' => $patientId,
                'doctor_id' => $doctorId,
                'status' => true,
            ])->first();

            return response()->json([
                'status' => Response::HTTP_OK,
                'is_favorite' => $favorite !== null,
            ], Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to check favorite status. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }

    public function getFavoriteDoctors($patientId)
    {
        try {
            $favorites = FavoriteDoctor::with('doctor')
                ->where('patient_id', $patientId)
                ->where('status', true)
                ->get();

            $favoriteDoctors = $favorites->map(function ($favorite) {
                return [
                    'id' => $favorite->doctor->id,
                    'first_name' => $favorite->doctor->first_name,
                    'last_name' => $favorite->doctor->last_name,
                    'profile_picture_url' => $favorite->doctor->profile_picture_url,
                    'specialist_title' => $favorite->doctor->specialist_title,
                ];
            });

            return response()->json($favoriteDoctors, Response::HTTP_OK);
        } catch (\Exception $e) {
            return response()->json([
                'status' => Response::HTTP_INTERNAL_SERVER_ERROR,
                'message' => 'Failed to load favorite doctors. Please try again later.',
            ], Response::HTTP_INTERNAL_SERVER_ERROR);
        }
    }
}