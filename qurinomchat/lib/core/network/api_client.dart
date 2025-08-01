import 'package:dio/dio.dart';
import '../constants/api_routes.dart';

class ApiClient {
  final Dio _dio;

  ApiClient(this._dio) {
    _dio.options.baseUrl = ApiRoutes.baseUrl;
    _dio.options.connectTimeout = const Duration(seconds: 30);
    _dio.options.receiveTimeout = const Duration(seconds: 30);
    _dio.interceptors.add(LogInterceptor(
      request: true,
      responseBody: true,
      requestBody: true,
      error: true,
    ));
  }

  Future<Response> post(String path, {dynamic data}) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> get(String path) async {
    return await _dio.get(path);
  }
}