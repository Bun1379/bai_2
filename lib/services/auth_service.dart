import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://192.168.0.104:3000/api/v1/auth';

  Future<void> sendOtp(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/send-otp'),
      body: {'email': email},
    );
    if (response.statusCode == 200) {
      print("OTP sent successfully");
    } else {
      print("Failed to send OTP");
    }
  }

  Future<bool> resetPassword(
      String email, String otp, String newPassword) async {
    print('email: $email, otp: $otp, newPassword: $newPassword');
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      body: {'email': email, 'otp': otp, 'newPassword': newPassword},
    );
    if (response.statusCode == 200) {
      return true;
    }
    print("Lỗi: ${response.body}");
    return false;
  }

  Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      body: {'email': email, 'password': password},
    );
    return response.statusCode == 200;
  }

  Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {'email': username, 'password': password},
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
