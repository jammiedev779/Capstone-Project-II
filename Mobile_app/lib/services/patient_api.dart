import 'dart:convert';
import 'package:doc_care/models/patient.dart';
import 'package:http/http.dart' as http;

class ApiService {

  //endpoint api local port 8002

  //For chrome developer
  static const String _baseUrl = 'http://127.0.0.1:8002/api/patients'; 
  
  //For emulator developer
  // static const String _baseUrl = ' 'http://10.0.2.2:8002/api/patients'; 

  //add enpoind api server here..
  // static const String _baseUrl = 'http://54.151.252.168/api/patients';
  
  //register
  static Future<Map<String, dynamic>> registerPatient(Map<String, String> userData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'status': 200,
        'message': 'Registration successful',
        'token': responseBody['token'], 
      };
    } else {
      return {
        'status': response.statusCode,
        'message': jsonDecode(response.body)['message'],
      };
    }
  }

  //login
  static Future<Map<String, dynamic>> loginPatient(Map<String, String> credentials) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/login'),
      headers: {
       'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(credentials),
    );

     if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return {
        'status': 200,
        'message': 'Registration successful',
        'token': responseBody['token'], 
      };
    } else {
      return {
        'status': response.statusCode,
        'message': jsonDecode(response.body)['message'],
      };
    }
  }

  // Add this to your ApiService class
  static Future<Map<String, dynamic>> logout(String token) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/logout'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return {
        'status': 200,
        'message': 'Logout successful',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': jsonDecode(response.body)['message'],
      };
    }
  }


  //display data of user (profile)
  static Future<Map<String, dynamic>> fetchProfile(String token) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      print('Response body: ${response.body}'); 


      final Map<String, dynamic> data = responseBody['data'];

      return {
        'name': data['name'] ?? 'N/A',
        'age': data['age'] != null ? data['age'].toString() : 'N/A',
        'gender': data['gender'] ?? 'N/A',
        'phone_number': data['phone_number'] ?? 'N/A',
        'status': data['status'] ?? 'N/A',
        'address': data['address'] ?? 'N/A',
        'email': data['email'] ?? 'N/A', 
      };
    } else {
      throw Exception('Failed to load profile');
    }
  }
   // Update Profile
  static Future<Map<String, dynamic>> updateProfile(String token, Map<String, dynamic> updatedData) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/updateProfile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedData),
    );

    if (response.statusCode == 200) {
      return {
        'status': 200,
        'message': 'Profile updated successfully',
      };
    } else {
      return {
        'status': response.statusCode,
        'message': jsonDecode(response.body)['message'],
      };
    }
  }


}

