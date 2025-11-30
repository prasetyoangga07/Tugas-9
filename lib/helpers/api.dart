import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:h1d023028_tugas8/helpers/user_info.dart';
import 'app_exception.dart';

class Api {
  // ===============================
  // POST REQUEST
  // ===============================
  Future<dynamic> post(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      print("=== DEBUG POST ===");
      print("URL: $url");
      print("DATA: $data");

      final response = await http.post(
        Uri.parse(url),
        body: data,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // ===============================
  // GET REQUEST
  // ===============================
  Future<dynamic> get(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      print("=== DEBUG GET ===");
      print("URL: $url");

      final response = await http.get(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // ===============================
  // PUT REQUEST
  // ===============================
  Future<dynamic> put(dynamic url, dynamic data) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      print("=== DEBUG PUT ===");
      print("URL: $url");
      print("DATA: $data");

      final response = await http.put(
        Uri.parse(url),
        body: data,
        headers: {
          HttpHeaders.authorizationHeader: "Bearer $token",
          HttpHeaders.contentTypeHeader: "application/json",
        },
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // ===============================
  // DELETE REQUEST
  // ===============================
  Future<dynamic> delete(dynamic url) async {
    var token = await UserInfo().getToken();
    var responseJson;

    try {
      print("=== DEBUG DELETE ===");
      print("URL: $url");

      final response = await http.delete(
        Uri.parse(url),
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
      );

      print("STATUS: ${response.statusCode}");
      print("BODY: ${response.body}");

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }

    return responseJson;
  }

  // ===============================
  // HANDLE RESPONSE
  // ===============================
  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return jsonDecode(response.body); // 🔥 FIX
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 422:
        throw InvalidInputException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error Occurred While Communication With Server (StatusCode: ${response.statusCode})',
        );
    }
  }
}
