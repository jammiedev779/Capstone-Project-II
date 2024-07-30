import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchDoctorApi {
  //api local
  static const String _baseUrl = 'http://10.0.2.2:8002/api/doctors';

  //add enpoind api server here..
  // static const String _baseUrl = 'http://54.151.252.168/api/doctors';

  static Future<List<Map<String, dynamic>>> searchDoctors(String query) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/search?query=$query'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> doctors = jsonDecode(response.body)['doctors'];
      return doctors.map((doctor) {
        return {
          'first_name': doctor['first_name'],
          'last_name': doctor['last_name'],
          'phone_number': doctor['phone_number'],
          'status': doctor['status'],
          'address': doctor['address'],
        };
      }).toList();
    } else {
      throw Exception('Failed to load doctors');
    }
  }
}
