import 'dart:convert';
import 'package:http/http.dart' as http;

class AppointmentApi {
  static const String _baseUrl = 'http://10.0.2.2:8002/api/appointments';

  static Future<Map<String, dynamic>> fetchAppointments(int patientId) async {
    final response = await http.get(Uri.parse('$_baseUrl/$patientId'));
  print('API response: ${response.body}');
    if (response.statusCode == 200) {
      print('API response: ${response.body}');
      return json.decode(response.body);
    } else {
      print('Failed to load appointments. Status code: ${response.statusCode}');
      throw Exception('Failed to load appointments');
    }
  }

  static Future<void> cancelAppointment(int appointmentId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/cancel/$appointmentId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'user_status': 1}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to cancel appointment');
    }
  }
}
