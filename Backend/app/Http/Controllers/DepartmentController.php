<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Department;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class DepartmentController extends Controller
{
    public function index(Request $Request){
        $departments = Department::all();

        return Response()->json([
            'status'=> Response::HTTP_OK,
            'departments' => $departments,
        ],Response::HTTP_OK,);

    }
    public function show($id)
    {
        $department = Department::find($id);

        if (!$department) {
            return response()->json([
                'status' => Response::HTTP_NOT_FOUND,
                'message' => ' not found',
            ], Response::HTTP_NOT_FOUND);
        }

        return response()->json([
            'status' => Response::HTTP_OK,
            'department' => $department,
        ], Response::HTTP_OK);
    }
}
