import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  final String baseUrl = 'https://kotiboxglobaltech.com/travel_app/api';

  // ✅ Register User
  Future<http.Response> registerUser(Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to register: $e');
    }
  }

  // ✅ Login User (email or phone + password)
  Future<http.Response> loginUser({
    String? email,
    String? phoneNumber,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/login');

    final Map<String, dynamic> body = {
      if (email != null && email.isNotEmpty) 'email': email,
      if (phoneNumber != null && phoneNumber.isNotEmpty) 'phone_number': phoneNumber,
      'password': password,
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }

  // ✅ Forgot Password (only by email)
  Future<http.Response> forgotPassword(String email) async {
    final url = Uri.parse('$baseUrl/forgot-password');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'email': email}),
      );
      return response;
    } catch (e) {
      throw Exception('Failed to send forgot password request: $e');
    }
  }
}
