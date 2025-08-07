import 'dart:convert';
import 'dart:io';
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

  Future<List<dynamic>> fetchPosts() async {
    final url = Uri.parse("https://kotiboxglobaltech.com/travel_app/api/posts");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == true) {
        return jsonResponse['data'];
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  Future<List<dynamic>> fetchPostsByLocation(String location) async {
    final url = Uri.parse("https://kotiboxglobaltech.com/travel_app/api/posts/location");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'location': location}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['status'] == true) {
        return jsonResponse['data'];
      } else {
        throw Exception(jsonResponse['message']);
      }
    } else {
      throw Exception('Failed to fetch location posts');
    }
  }


  // ✅ Add Post
  Future<http.Response> addPost({
    required String question,
    required String location,
    File? imageFile,
  }) async {
    print('Preparing multipart request for addPost...');
    var headers = {
      'Authorization': 'Bearer 8hDPsXafMMddwV4sTi3gEzHerwvpIIRdtRvR2eNR67fa9356', // Replace with actual token
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://kotiboxglobaltech.com/travel_app/api/posts'),
    );

    // Add form fields
    request.fields.addAll({
      'question': question,
      'location': location,
    });

    // Add image file if provided
    if (imageFile != null) {
      print('Adding image file: ${imageFile.path}');
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
    } else {
      print('No image file provided');
    }

    // Add headers
    request.headers.addAll(headers);
    print('Request headers: ${request.headers}');
    print('Request fields: ${request.fields}');

    try {
      print('Sending multipart request...');
      http.StreamedResponse streamedResponse = await request.send();
      print('Received response with status code: ${streamedResponse.statusCode}');

      // Convert StreamedResponse to Response for easier handling
      final response = await http.Response.fromStream(streamedResponse);
      print('Response body: ${response.body}');

      return response;
    } catch (e) {
      print('Error sending multipart request: $e');
      rethrow; // Rethrow to be handled by the caller
    }
  }

  Future<http.Response> logoutUser(String token) async {
  final url = Uri.parse('$baseUrl/logout');

  try {
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    return response;
  } catch (e) {
    throw Exception('Failed to logout: $e');
  }
}



}
