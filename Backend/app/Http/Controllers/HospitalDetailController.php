<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\HospitalDetail;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Validator;

class HospitalDetailController extends Controller
{
    public function index()
    {
        $hospitalDetails = HospitalDetail::with(['category'])
            ->get(['id','category_id', 'phone_number','kh_name', 'email','description', 'location', 'contact_person_phone', 'url','image']);

        $hospitalDetails = $hospitalDetails->map(function ($hospitalDetail) {
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

        return response()->json(['hospitalDetails' => $hospitalDetails], 200);
    }

    public function search(Request $request)
    {
        $query = $request->query('query');
        
        if (!$query) {
            return response()->json(['hospitalDetails' => []], 200);
        }

        $hospitalDetails = HospitalDetail::with(['category', 'specialist'])
            ->where(function ($queryBuilder) use ($query) {
                $queryBuilder->where('kh_name', 'LIKE', "%{$query}%")
                             ->orWhere('address', 'LIKE', "%{$query}%");
            })
            ->get(['id','category_id', 'phone_number','kh_name', 'email','description', 'location', 'contact_person_phone', 'url','image']);
    
        $hospitalDetails = $hospitalDetails->map(function ($hospitalDetail) {
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

        return response()->json(['hospitalDetails' => $hospitalDetails], 200);
    }

    public function show($id)
    {
        try {
            $hospitalDetail = HospitalDetail::with(['category'])
                ->where('id', $id)
                ->first(['id', 'category_id', 'phone_number', 'kh_name', 'email', 'description', 'location', 'contact_person_phone', 'url', 'image']);

            if ($hospitalDetail) {
                return response()->json($hospitalDetail, 200);
            } else {
                return response()->json(['error' => 'Hospital not found'], 404);
            }
        } catch (\Exception $e) {
            error_log('Error fetching hospital detail: ' . $e->getMessage());
            return response()->json(['error' => 'Failed to load hospital detail'], 500);
        }
    }

     
}