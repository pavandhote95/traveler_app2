import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;

import 'dart:async';




class RestApi {
  var storage = GetStorage();

  //Post api without authentication
  Future<http.Response> postApi(String url, String request) async {
    var response = await http.post(
      Uri.parse(url),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
      encoding: Encoding.getByName("utf-8"),
    );
    return response;
  }

  //OTP api with url
  Future<http.Response> getApiOTP(String path) async {
    var response = await http.get(Uri.parse(path));
    print(response.body);
    return response;
  }

  //Post api with authentication
  Future<http.Response> postApiWithAuth(String path, String request) async {
    var response = await http.post(
      Uri.parse(path),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }
  // inside RestApi class
Future<http.Response> getWithBodyAndAuth(String url, Map<String, dynamic> body) async {
  final token = storage.read("token");

  final request = http.Request("GET", Uri.parse(url));
  request.headers.addAll({
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Authorization": "Bearer $token",
  });

  request.body = jsonEncode(body);

  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);

  return response;
}


  //Delete api with authentication
  Future<http.Response> deleteApiWithAuth(String path, String request) async {
    var response = await http.delete(
      Uri.parse(path),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }

  //Put api with authentication
  Future<http.Response> putApiWithAuth(String path, String request) async {
    var response = await http.post(
      Uri.parse(path),
      body: request,
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Authorization": 'Bearer ${storage.read("token")}',
      },
    );

    return response;
  }

  //Get api with authentication
// required for debugPrint

Future<http.Response> getWithAuthApi(String path) async {
  final token = storage.read("token");

  // ✅ Clear debug output
  debugPrint("====== AUTH TOKEN START ======");
  debugPrint("Bearer $token");
  debugPrint("====== AUTH TOKEN END ========");

  var response = await http.get(
    Uri.parse(path),
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
      "Authorization": 'Bearer $token',
    },
  );

  // ✅ Optional: log status and response
  debugPrint("Response Status: ${response.statusCode}");
  debugPrint("Response Body: ${response.body}");

  return response;
}


  Future<http.Response> getApi(String path) async {
    print("my token is here >>>>");
    print(storage.read("token"));

    var response = await http.get(
      Uri.parse(path),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );

    return response;
  }


  //   Future<RESPONSE.Response?> addPropertyData({
  //     required String apiUrl,
  //     required List<File> images,
  //     required String name,
  //     required int apartmentId,
  //     required int bedrooms,
  //     required int bathrooms,
  //     required int area,
  //     required int monthlyRent,
  //     required int securityDeposite,
  //     required List<int> amenityIds,
  //     required int pincode,
  //     required int stateId,
  //     required int cityId,
  //     required String address,
  //   }) async {
  //     try {
  //       FormData formData = FormData.fromMap({
  //         "name": name,
  //         "apartment_id": apartmentId,
  //         "bedrooms": bedrooms,
  //         "bathrooms": bathrooms,
  //         "area": area,
  //         "monthly_rent": monthlyRent,
  //         "security_deposite": securityDeposite,
  //         "state_id": stateId,
  //         "city_id": cityId,
  //         "pincode": pincode,
  //         "address": address,
  //         "amenity_ids": jsonEncode(amenityIds),
  //       });
  //
  // // 👉 Add this print block right here
  //       print("🔍 FormData being sent:");
  //       formData.fields.forEach((field) {
  //         print("${field.key}: ${field.value}");
  //       });
  //       print("📸 Image count: ${images.length}");
  //       for (var file in images) {
  //         print("Image file: ${file.path}");
  //       }
  //       for (var file in images) {
  //         String fileName = file.path.split('/').last;
  //         formData.files.add(
  //           MapEntry(
  //             "image",
  //             await MultipartFile.fromFile(file.path, filename: fileName),
  //           ),
  //         );
  //       }
  //
  //       Dio dio = Dio();
  //       dio.options.headers = {
  //         "content-type": "multipart/form-data",
  //         "Authorization": "Bearer ${storage.read("token")}",
  //         "x-api-key": "k9l3xJuL6D9dBmvPIDMe6Th3Wj8WpzeJKvDbcBU4vgsdfgvdgdfN6DOVXmZzgKHEZ2hPYdGsyhhJdmCWzvFkGpl",
  //       };
  //
  //       print("Sending to $apiUrl");
  //
  //       RESPONSE.Response response = await dio.post(apiUrl, data: formData);
  //       print("Response: ${response.statusCode} - ${response.data}");
  //       return response;
  //     } catch (e) {
  //       print("Error uploading property: $e");
  //       return null;
  //     }
  //   }
}
