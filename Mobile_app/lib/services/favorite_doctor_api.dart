import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteDoctorApi {
  static const String _baseUrl = 'http://10.0.2.2:8002/api/favorites';

  static Future<bool> isFavorite(int patientId, int doctorId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/show/$patientId/$doctorId'),
    );

    print('isFavorite - Response status: ${response.statusCode}');
    print('isFavorite - Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('isFavorite - Parsed data: $data');
      return data['is_favorite'];
    } else {
      throw Exception('Failed to check favorite status');
    }
  }

  static Future<void> addFavorite(int patientId, int doctorId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add/$patientId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'doctor_id': doctorId}),
    );

    print('addFavorite - Response status: ${response.statusCode}');
    print('addFavorite - Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to add favorite');
    }
  }

  static Future<void> removeFavorite(int patientId, int doctorId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/remove/$patientId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode({'doctor_id': doctorId}),
    );

    print('removeFavorite - Response status: ${response.statusCode}');
    print('removeFavorite - Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to remove favorite');
    }
  }

  static Future<List<Map<String, dynamic>>> getFavoriteDoctors(int patientId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$patientId'));

    print('getFavoriteDoctors - Response status: ${response.statusCode}');
    print('getFavoriteDoctors - Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print('getFavoriteDoctors - Parsed data: $data');
      return data.map((doctor) => {
        'id': doctor['id'],
        'first_name': doctor['first_name'],
        'last_name': doctor['last_name'],
        'profile_picture_url': doctor['profile_picture_url'],
        'specialist_title': doctor['specialist_title'],
      }).toList();
    } else {
      throw Exception('Failed to load favorite doctors');
    }
  }
}
