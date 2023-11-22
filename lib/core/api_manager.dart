import 'package:chd/core/cookie_manager.dart';
import 'package:dio/dio.dart';

class ApiManager {
  late final Dio _dio;

  ApiManager._instance();
  static final ApiManager _internal = ApiManager._instance();
  factory ApiManager() => _internal;

  init() {
    _dio = Dio();
    _dio.interceptors.add(CookieManager());
  }

  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      print('Request error: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> post(String endpoint) async {
    try {
      final response = await _dio.post(endpoint);
      print(response);
      return response.data;
    } catch (e) {
      print('Request error: $e');
      rethrow;
    }
  }
}
