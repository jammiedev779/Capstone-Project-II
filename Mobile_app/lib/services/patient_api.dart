import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://10.0.2.2:8002/api/patients';

  static Future<Map<String, dynamic>> registerPatient(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      return {
        'status': 200,
        'message': 'Registration successful',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': jsonDecode(response.body)['message'],
      };
    }
  }

    static Future<Map<String, dynamic>> loginPatient(Map<String, String> credentials) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {
       'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(credentials),
    );

    return jsonDecode(response.body);
  }
}

