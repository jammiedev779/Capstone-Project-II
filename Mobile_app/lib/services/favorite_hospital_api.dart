import 'dart:convert';
import 'package:http/http.dart' as http;

class FavoriteHospitalApi {
  static const String _baseUrl = 'http://10.0.2.2:8002/api/favorite_hospital';




  static Future<bool> isFavorite(int patientId, int hospitalId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/show/$patientId/$hospitalId'),
    );

    print('isFavorite - Response status: ${response.statusCode}');
    print('isFavorite - Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print('isFavorite - Parsed data: $data');
      return data['is_favorite'] ?? false;
    } else {
      throw Exception('Failed to check favorite status');
    }
  }

  static Future<bool> addFavorite(int patientId, int hospitalId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/add/$patientId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'hospital_id': hospitalId}),
    );

    print('addFavorite - Response status: ${response.statusCode}');
    print('addFavorite - Response body: ${response.body}');

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add favorite hospital');
    }
  }

  static Future<bool> removeFavorite(int patientId, int hospitalId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/remove/$patientId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({'hospital_id': hospitalId}),
    );

    print('removeFavorite - Response status: ${response.statusCode}');
    print('removeFavorite - Response body: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to remove favorite hospital');
    }
  }

  // static Future<List<Map<String, dynamic>>> getFavoriteHospitals(int patientId) async {
  //   final response = await http.get(
  //     Uri.parse('$_baseUrl/$patientId'),
  //     headers: {"Content-Type": "application/json"},
  //   );

  //   print('getFavoriteHospitals - Response status: ${response.statusCode}');
  //   print('getFavoriteHospitals - Response body: ${response.body}');

  //   if (response.statusCode == 200) {
  //     final List<dynamic> data = jsonDecode(response.body);
  //     print('getFavoriteDoctors - Parsed data: $data');
  //     return data.map((hospital) => {
  //       'id': hospital['id'],
  //       'kh_name': hospital['kh_name'],
  //       'descripiton': hospital['descripiton'],
  //       'location': hospital['location'],
  //       'phone_number': hospital['phone_number'],
  //       'image': hospital['image'],
  //       'url': hospital['url'],
  //       'email': hospital['email'],

  //     }).toList();
  //   } else {
  //     throw Exception('Failed to load favorite hospitals');
  //   }
  // }


  static Future<List<Map<String, dynamic>>> getFavoriteHospitals(int patientId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$patientId'),
      headers: {"Content-Type": "application/json"},
    );

    print('getFavoriteHospitals - Response status: ${response.statusCode}');
    print('getFavoriteHospitals - Response body: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      print('getFavoriteHospitals - Parsed data: $data');

      // Extract the list from the 'favoriteHospitals' field
      final List<dynamic> hospitalsData = data['favoriteHospitals'];
      return hospitalsData.map((hospital) => {
        'id': hospital['id'],
        'kh_name': hospital['kh_name'],
        'description': hospital['description'], 
        'location': hospital['location'],
        'phone_number': hospital['phone_number'],
        'image': hospital['image'],
        'url': hospital['url'],
        'email': hospital['email'],
      }).toList();
    } else {
      throw Exception('Failed to load favorite hospitals');
    }
  }
}
