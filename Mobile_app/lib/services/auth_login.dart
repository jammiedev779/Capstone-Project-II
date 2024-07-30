import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';



class AuthService {
  final storage = FlutterSecureStorage();
  final String loginUrl = 'http://10.0.2.2:8002/api/patients/login';

  Future<void> login(String phoneNumber, String password) async {
    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone_number': phoneNumber, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await storage.write(key: 'token', value: data['token']);
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }
}
