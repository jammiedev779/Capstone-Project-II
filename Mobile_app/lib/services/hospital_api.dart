import 'dart:convert';
import 'package:doc_care/screens/hospital/hospital_list.dart';
import 'package:http/http.dart' as http;

class HospitalApi {
  static const String _baseUrl = 'http://10.0.2.2:8002/api/hospital_details/all';

  static Future<List<Map<String, dynamic>>> fetchHospitals() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['hospitalDetails'];
      return data.map((hospital) => hospital as Map<String, dynamic>).toList();
    } else {
      throw Exception('Failed to load hospitals');
    }
  }
}
