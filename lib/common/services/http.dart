import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:perfect_pay/common/services/storage.dart';
import 'package:perfect_pay/common/utils/environment.dart';

class HttpService {
  final String baseUrl;
  String? _token;

  HttpService._internal({required this.baseUrl});

  static HttpService? _instance;

  /// Create and initialize an instance of HttpService.
  static Future<HttpService> create({required String baseUrl}) async {
    _instance ??= HttpService._internal(baseUrl: baseUrl);
    await _instance!._initializeToken();
    return _instance!;
  }

  /// Initialize token from local storage.
  Future<void> _initializeToken() async {
    _token = await Storage.getString(Environment.tokenKey);
  }

  /// Perform an HTTP request.
  Future<http.Response> request({
    required String endpoint,
    required String method,
    Map<String, dynamic>? data,
  }) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final headers = _buildHeaders();

    try {
      final response = await _sendRequest(uri, method, headers, data);
      _handleErrors(response);
      return response;
    } catch (e) {
      // Retry after refreshing the token
      if (e is HttpException && e.statusCode == 401) {
        await _refreshToken();
        return request(endpoint: endpoint, method: method, data: data);
      }
      rethrow;
    }
  }

  /// Save the token to local storage and update in-memory token.
  Future<void> saveToken(String token) async {
    Storage.setString(Environment.tokenKey, token);
    _token = token;
  }

  /// Clear the token from local storage and memory.
  Future<void> clearToken() async {
    await Storage.removeKey(Environment.tokenKey);
    _token = null;
  }

  /// Refresh the token dynamically if needed.
  Future<void> _refreshToken() async {
    _token = await Storage.getString(Environment.tokenKey);
    if (_token == null) {
      throw HttpException(
        message: 'Unauthorized: Token not found',
        body: 'Please login again',
        statusCode: 401,
      );
    }
  }

  /// Build HTTP headers for requests.
  Map<String, String> _buildHeaders() {
    final headers = {'Content-Type': 'application/json'};
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  /// Send an HTTP request based on the method.
  Future<http.Response> _sendRequest(
    Uri uri,
    String method,
    Map<String, String> headers,
    Map<String, dynamic>? data,
  ) async {
    switch (method.toUpperCase()) {
      case 'GET':
        return http.get(uri, headers: headers);
      case 'POST':
        return http.post(uri, headers: headers, body: jsonEncode(data));
      case 'PUT':
        return http.put(uri, headers: headers, body: jsonEncode(data));
      case 'DELETE':
        return http.delete(uri, headers: headers);
      default:
        throw UnsupportedError('Unsupported HTTP method: $method');
    }
  }

  /// Handle HTTP response errors.
  void _handleErrors(http.Response response) {
    if (response.statusCode >= 400) {
      final errorType =
          response.statusCode < 500 ? 'Client Error' : 'Server Error';
      throw HttpException(
        message: '$errorType: ${response.statusCode}',
        body: response.body,
        statusCode: response.statusCode,
      );
    }
  }
}

class HttpException implements Exception {
  final String message;
  final String body;
  final int statusCode;

  HttpException({
    required this.message,
    required this.body,
    required this.statusCode,
  });

  @override
  String toString() => 'HttpException: $message\nBody: $body';
}
