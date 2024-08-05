import 'dart:convert';
import 'package:http/http.dart' as http;

class HospitalApi {
  static const String _baseUrl = 'http://10.0.2.2:8002/api/hospital_details';

  static Future<List<Map<String, dynamic>>> fetchHospitals() async {
    final response = await http.get(Uri.parse('$_baseUrl/all'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['hospitalDetails'];
       print('Hospital details fetched successfully: $data');
      return data.map((hospital) => hospital as Map<String, dynamic>).toList();
    } else {
      print('Failed to load hospital details. Status code: ${response.statusCode}');
      throw Exception('Failed to load hospitals');
    }
  }

  static Future<Map<String, dynamic>> fetchHospitalDetails(int hospitalId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$hospitalId'));

    if (response.statusCode == 200) {
         
      final Map<String, dynamic> data = json.decode(response.body);
      print('Hospital details fetched successfully: $data');
      return data;
    } else {
      print('Failed to load hospital details. Status code: ${response.statusCode}');
      throw Exception('Failed to load hospital details');
    }
  }
}
