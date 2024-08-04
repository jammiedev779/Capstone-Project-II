<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Specialist;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class SpecialistController extends Controller
{
    public function index(Request $Request){
        $specialists = Specialist::all();

        return Response()->json([
            'status'=> Response::HTTP_OK,
            'specialists' => $specialists,
        ],Response::HTTP_OK,);

    }
    public function show($id)
    {
        $specialist = Specialist::find($id);

        if (!$specialist) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => ' not found',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json([
            'status' => Response::HTTP_OK,
            'specialist' => $specialist,
        ], Response::HTTP_OK);
    }

}