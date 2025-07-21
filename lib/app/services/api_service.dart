import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  final String baseUrl = 'https://kotiboxglobaltech.com/travel_app/api';

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
}