<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HospitalDetail;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class HospitalDetailController extends Controller
{
    public function index(Request $Request){

        $hospital_details = HospitalDetail::all();

        return response()->json([
            'status'=> Response::HTTP_OK,
            'hospital_details'=>$hospital_details,
        ],Response::HTTP_OK,);
    }
    public function store(Request $Request){

        $validator = Validator::make($request->all(),[
            'admin_id',
            'category_id',
            'phone_number',
            'kh_name',
            'email',
            'description',
            'location',
            'contact_person_phone',
            'url'
        ]);

        if($validator ->fails()){
            return Response()->json([
                'status' => Respone::HTTP_UNPROCESSABLE_ENTITY,
                'message' => $validator->message(),
            ],Respone::HTTP_UNPROCESSABLE_ENTITY);
        }

        $hospital_detail = new HospitalDetail($request->all());
        $hospital_detail->save();

        return Response()->json([
            'status' => Response::HTTP_CREATED,
            'message' => 'Hospital Detail created successfully',
            'hospital_detail' => $hospital_detail,
        ],Response::HTTP_CREATED);
    }
    public function show($id)
    {
        $hospital_detail = HospitalDetail::find($id);

        if (!$hospital_detail) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => ' not found',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json([
            'status' => Response::HTTP_OK,
            'hospital_detail' => $hospital_detail,
        ], Response::HTTP_OK);
    }
    


     
}
