import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:byte_blossoms/url/url.dart';

class OTPService {
  final String baseUrl = URL.getBaseUrl();

  Future<void> sendPasswordOTP_M(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/sendOTP'),
      body: jsonEncode({'email': email}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send OTP.');
    }
  }

  Future<bool> verifyOTP(String email, String otp) async {
    final response = await http.post(
      Uri.parse('$baseUrl/verifyOTP'),
      body: jsonEncode({'email': email, 'otp': otp}),
      headers: {'Content-Type': 'application/json'},
    );
    return response.statusCode == 200;
  }
}
