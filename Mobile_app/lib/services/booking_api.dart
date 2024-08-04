import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingApi {
  // Local API URL 
  static const String _baseUrl = 'http://10.0.2.2:8002/api/appointments';

  // Method to create a new booking
  static Future<Map<String, dynamic>> createBooking(Map<String, dynamic> bookingData) async {
    try {
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

      // Print statements for debugging
      print('Request URL: ${Uri.parse('$_baseUrl/booking')}');
      print('Request Headers: ${{
        'Content-Type': 'application/json',
      }}');
      print('Request Body: ${jsonEncode(bookingData)}');
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $responseBody');

      return {
        'statusCode': response.statusCode,
        'data': responseBody,
      };
    } catch (e) {
      print('Error creating booking: $e');
      return {
        'statusCode': 500,
        'data': {'message': 'An error occurred while creating the booking.'},
      };
    }
  }

}
