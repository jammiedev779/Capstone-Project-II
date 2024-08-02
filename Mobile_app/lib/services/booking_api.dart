import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingApi {
  // Local API URL (use this for development/testing)
  static const String _baseUrl = 'http://10.0.2.2:8002/api/appointments';

  // Production API URL (replace with your production server URL)
  // static const String _baseUrl = 'http://your-production-server-url/api/appointments';


  static Future<Map<String, dynamic>> createBooking(Map<String, dynamic> bookingData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/booking'),
      headers: {
        'Content-Type': 'application/json',
        // Add Authorization header if needed
        // 'Authorization': 'Bearer your_token',
      },
      body: jsonEncode(bookingData),
    );

    final Map<String, dynamic> responseBody = jsonDecode(response.body);

    return {
      'statusCode': response.statusCode,
      'data': responseBody,
    };
  }
}
