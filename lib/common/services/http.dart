import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:perfect_pay/common/services/storage.dart';
import 'package:perfect_pay/common/utils/environment.dart';

class HttpService {
  final String baseUrl;
  String? _token;

  HttpService._internal({required this.baseUrl});

  static HttpService? _instance;

  static Future<HttpService> create({required String baseUrl}) async {
    if (_instance == null) {
      // Create a new instance and initialize the token
      var service = HttpService._internal(baseUrl: baseUrl);
      await service._getTokenFromLocalStorage();
      _instance = service;
    }
    return _instance!;
  }

  Future<http.Response> request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? data,
  }) async {
    await _getTokenFromLocalStorage();

    final uri = Uri.parse('$baseUrl$endpoint');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }

    late http.Response response;

    switch (method.toUpperCase()) {
      case 'GET':
        response = await http.get(uri, headers: headers);
        break;

      case 'POST':
        response =
            await http.post(uri, headers: headers, body: jsonEncode(data));
        break;

      case 'PUT':
        response =
            await http.put(uri, headers: headers, body: jsonEncode(data));
        break;

      case 'DELETE':
        response = await http.delete(uri, headers: headers);
        break;

      default:
        throw Exception('Unsupported HTTP method: $method');
    }

    _handleErrors(response);
    return response;
  }

  Future<void> _getTokenFromLocalStorage() async {
    _token ??= Storage.getString(Environment.tokenKey);
  }

  Future<void> saveToken(String token) async {
    Storage.setString(Environment.tokenKey, token);
    _token = token;
  }

  Future<void> clearToken() async {
    await Storage.removeKey(Environment.tokenKey);
    _token = null;
  }

  void _handleErrors(http.Response response) {
    if (response.statusCode >= 400 && response.statusCode < 500) {
      throw Exception(
          'Client Error: ${response.statusCode} - ${response.body}');
    } else if (response.statusCode >= 500) {
      throw Exception(
          'Server Error: ${response.statusCode} - ${response.body}');
    }
  }
}
